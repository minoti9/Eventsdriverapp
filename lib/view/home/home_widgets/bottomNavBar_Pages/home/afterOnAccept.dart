import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:speedx_driver_122283/controller/MyController.dart';
import 'package:speedx_driver_122283/models/ParcelItem.dart';
import 'package:speedx_driver_122283/network/NetworkCall.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speedx_driver_122283/view/home/home_widgets/bottomNavBar_Pages/home/ParcelDetail.dart';
import 'package:speedx_driver_122283/view/home/home_widgets/bottomNavBar_Pages/home/startJourney.dart';

class AfterOnAcceptDropLocation extends StatefulWidget {
  final String acceptId;

  const AfterOnAcceptDropLocation({Key key, this.acceptId}) : super(key: key);
  @override
  _AfterOnAcceptDropLocationState createState() =>
      _AfterOnAcceptDropLocationState();
}

class _AfterOnAcceptDropLocationState extends State<AfterOnAcceptDropLocation> {
  final _getXcontr = MyController.to;

  @override
  Widget build(BuildContext context) {
    _getXcontr.orderDetail.value = // _getXcontr.action.value == 'history'?
        _getXcontr.acceptedOrderList[_getXcontr.index.value].order;
    //: _getXcontr.orderList[_getXcontr.index.value];

    final orderStatus = _getXcontr.orderDetail.value.status;
    print('status- $orderStatus');
    if (orderStatus.toLowerCase().contains('delivered')) {
      Get.back();
    }
    // print(
    //     'after- ${_getXcontr.acceptedOrderList[_getXcontr.index.value].order.dropAddress.length}');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            color: black,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            }),
        backgroundColor: white,
        title: Text('Drop Location', style: TextStyle(color: black)),
      ),
      body: Column(children: [
        Expanded(
            child: Obx(
          () => ListView.builder(
            itemCount: _getXcontr.orderDetail.value.dropAddress.length,
            shrinkWrap: true,
            itemBuilder: (_, int index) {
              final item = _getXcontr.orderDetail.value.dropAddress[index];

              return Card(
                // color: blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),

                    ///texts ---------------------------------------
                    Row(
                      children: [
                        Image.asset(
                          profileAssetImg,
                          height: 0.1.sh,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.dropAddress.name),
                              Text('+1 ${item.dropAddress.phoneNo}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Parcel Details',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              if (item.status
                                  .toLowerCase()
                                  .contains('delivered'))
                                Text(
                                  'Complete',
                                  style: TextStyle(color: green),
                                )
                            ],
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              //print(orderStatus);
                              //if (item.status.toLowerCase().contains('pending'))
                              Get.to(() => ParcelDetail(
                                    item: item.items,
                                  ));
                              // else
                              //   showToast('Parcel detail already saved', red);
                            })
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        // style: TextStyle(color: Colors.black, fontSize: 36),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Address- ',
                              style: TextStyle(color: black)),
                          TextSpan(
                              text:
                                  '${item.dropAddress.detailAddress}, ${item.dropAddress.landmark}, ${item.dropAddress.address}',
                              style: TextStyle(color: Colors.black87)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (item.status.toLowerCase().contains('picked'))
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 1.sw,
                        // color: white,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: blueGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () {
                            Get.to(() => StartJourney(
                                  dropAddress: item,
                                )).then((value) async {
                              try {
                                await _getXcontr.getAcceptedOrderList();
                              } finally {
                                setState(() {});
                                // print('orderStatus- $orderStatus');

                              }
                            });
                          },
                          child: Text('Start Journey',
                              style: TextStyle(fontSize: 20, color: white)),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        )),
        if (!orderStatus.toLowerCase().contains('picked') &&
            !orderStatus.toLowerCase().contains('delivered'))
          Container(
            padding: EdgeInsets.all(10),
            width: 1.sw,
            // color: white,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: blueGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                var detail = _getXcontr.orderDetail.value;

                var checkAccepted = detail.dropAddress.firstWhere(
                  (element) => element.status.toLowerCase().contains('pending'),
                  orElse: () => null,
                );
                if (checkAccepted == null) {
                  //print('checkaccept');
                  _showOtpDialog(
                      detail.pickupAddress.phoneNo, detail.id.toString());
                } else {
                  // print('checkcontain');
                  // var contain = detail.dropAddress.firstWhere(
                  //   (element) => element.itemName == null,
                  //   orElse: () => null,
                  // );
                  // if (contain != null) {
                  //   showToast('Please add parcel details', red);
                  // } else {
                  _submitDetail();
                  //}
                }
              },
              child: Text('Continue',
                  style: TextStyle(fontSize: 20, color: white)),
            ),
          ),
      ]),
    );
  }

  void _submitDetail() async {
    var detail = _getXcontr.orderDetail.value;

    var param = {
      "id": widget.acceptId,
      "order_id": detail.id.toString(),
      "pickup_address_id": detail.pickupAddress.id.toString(),
      "items": detail.dropAddress.map((e) {
        // final itemImg = base64Encode(e.parcelItem.itemImg.readAsBytesSync());
        // final idProof = base64Encode(e.parcelItem.idProofImg.readAsBytesSync());
        return {
          "drop_address_id": e.id.toString(),
          // "item_name": e.parcelItem.name,
          // "item_weight": e.parcelItem.weight,
          // "item_length": e.parcelItem.itemLength,
          // "item_height": e.parcelItem.height,
          // "item_image": 'data:image/jpeg;base64,' + itemImg,
          // "adhaar_document_image_string": 'data:image/jpeg;base64,' + idProof
        };
      }).toList()
    };
    // print(jsonEncode(param));

    showProgress(context);
    bool result = await networkCall.saveParcelDetails(param);
    hideProgress(context);
    if (result) {
      _showOtpDialog(detail.pickupAddress.phoneNo, detail.id.toString());
      //Get.off(() => StartJourney());
    }
  }

  void _showOtpDialog(String phoneNo, String orderId) {
    bool _isShowOtp = false;
    String _otp = '';
    Get.defaultDialog(
        title: 'Verify OTP',
        barrierDismissible: false,
        content: StatefulBuilder(
          builder: (context, mstate) => Column(
            children: [
              Divider(),
              Text('+1 $phoneNo'),
              ElevatedButton(
                onPressed: () async {
                  showProgress(context);
                  var result = await networkCall.sendPickupOTP(
                      phone: phoneNo, orderId: orderId);
                  hideProgress(context);
                  if (result != null) {
                    mstate(() {
                      _isShowOtp = true;
                      _otp = result['data']['otp'];
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: blueGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  'Send OTP',
                  style: TextStyle(color: white),
                ),
              ),
              if (_isShowOtp)
                PinFieldAutoFill(
                  decoration: UnderlineDecoration(
                    textStyle: TextStyle(fontSize: 20, color: Colors.black),
                    colorBuilder:
                        FixedColorBuilder(Colors.black.withOpacity(0.3)),
                  ),
                  onCodeChanged: (code) {
                    if (code.length == 6) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (int.parse(code) == int.parse(_otp)) {
                        _otpValidate(code, orderId);
                      } else
                        showToast('Please enter valid code', Colors.black);
                    }
                  },
                ),
              SizedBox(
                height: 0.02.sh,
              )
            ],
          ),
        ));
  }

  void _otpValidate(String code, String orderId) async {
    print('orderId- $orderId\n acceptId- ${widget.acceptId}');
    showProgress(context);
    bool result = await networkCall.verifyPickupOtp(
        orderID: orderId, otp: code, acceptId: widget.acceptId);
    hideProgress(context);
    if (result) {
      Get.back();
      try {
        await _getXcontr.getAcceptedOrderList();
      } finally {
        setState(() {});
      }
    }
  }
}
