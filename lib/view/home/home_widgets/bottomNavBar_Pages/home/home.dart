import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speedx_driver_122283/controller/MyController.dart';
import 'package:speedx_driver_122283/models/OrderListRes.dart';
import 'package:speedx_driver_122283/network/NetworkCall.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'onAccept.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController controller = ScrollController();
  final _remark = TextEditingController();

  var _images = [
    'assets/slider-image-2.jpg',
    'assets/slider-image-1.jpg',
    'assets/slider-image-2.jpg',
  ];
  bool isSwitched = false;
  var c = MyController.to;
  StreamSubscription _currstream;
  double latitude, longitude;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _permissionCheck();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _remark.dispose();
    // _currstream.cancel();
  }

  void _permissionCheck() async {
    await Permission.location.request();
    if (!await Geolocator.isLocationServiceEnabled()) {
      print('not done');
      await Geolocator.openLocationSettings().then((value) async {
        if (value) _getCurrentLocation();
      });
    } else
      _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      // print('not done');
      await Geolocator.openLocationSettings();
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    _currstream = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
      accuracy: LocationAccuracy.best,
    )).listen((event) {
      print('mylocation');
      latitude = event.latitude;
      longitude = event.longitude;
      c.getOrderList(latitude: latitude, longitude: longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   body: NestedScrollView(
      // controller: controller,
      // headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      //   return <Widget>[
      //     SliverAppBar(
      //       automaticallyImplyLeading: false,
      //       primary: true,
      //       floating: false,
      //       pinned: false,
      //       forceElevated: false,
      //       expandedHeight: 250.0,
      //       flexibleSpace: FlexibleSpaceBar(
      //           background: Swiper(
      //         itemCount: _images.length,
      //         duration: 2000,
      //         itemBuilder: (BuildContext context, int index) => Image.asset(
      //           _images[index],
      //           fit: BoxFit.fill,
      //         ),
      //         autoplay: true,
      //       )),
      //     ),
      //   ];
      // },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),

          ///booking list text -------------------------------------
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              'Booking list',
              style: TextStyle(color: red, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 0.02.sh,
          ),

          ///list view booking id----------------------------------------
          Expanded(
              child: Obx(
            () => c.isLoading.value
                ? Center(
                    child: CupertinoActivityIndicator(
                    radius: 20,
                  ))
                : c.orderList.length == 0
                    ? Center(child: Text('No Data Found'))
                    : ListView.builder(
                        shrinkWrap: true,
                        // separatorBuilder: (_, __) => SizedBox(
                        //       height: 0,
                        //     ),
                        itemCount: c.orderList.length,
                        itemBuilder: (_, int index) {
                          final item = c.orderList[index];
                          int weight = 0;
                          item.dropAddress.forEach((element) {
                            element.items.forEach((element2) {
                              weight = weight + int.parse(element2.itemWeight);
                            });
                          });
                          return Column(
                            children: [
                              ColoredBox(
                                color: grey,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black45,
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 18.0, right: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 0.02.sh,
                                            ),
                                            Text('Booking id: ${item.uniqueId}',
                                                style: TextStyle(fontSize: 18)),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text(
                                                  item.rideType,
                                                  style: TextStyle(color: blue),
                                                ),
                                                SizedBox(
                                                  width: 0.07.sw,
                                                ),
                                                Text(
                                                  'Date- ${item.orderDate.toString().split(' ')[0]}',
                                                  style:
                                                      TextStyle(color: green),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                    'Weight: $weight ${weight > 1 ? weightUnit2 : weightUnit}',
                                                    style: TextStyle(
                                                        color: Colors.brown)),
                                                SizedBox(width: 15),
                                                Text('Qnty.: ${item.parcelQty}',
                                                    style:
                                                        TextStyle(color: blue)),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0.02.sh,
                                            ),
                                            Text(
                                              'Drop Address-',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            SizedBox(
                                              height: 0.01.sh,
                                            ),
                                            Column(
                                              children: List.generate(
                                                  item.dropAddress.length,
                                                  (index) {
                                                var e = item.dropAddress[index];
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      left: 0.05.sw),
                                                  child: Text(
                                                    '${index + 1}. ${e.dropAddress.detailAddress}, ${e.dropAddress.address}',
                                                    style:
                                                        TextStyle(color: blue),
                                                  ),
                                                );
                                              }),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: green,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side:
                                                      BorderSide(color: green)),
                                            ),
                                            onPressed: () {
                                              c.index(index);
                                              _acceptOrder(item);
                                            },
                                            child: Text(
                                              'Accept',
                                              style: customizeTextStyle(
                                                  FontWeight.normal,
                                                  fontSizeFifteen,
                                                  white),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: red,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: BorderSide(color: red)),
                                            ),
                                            onPressed: () {
                                              customBottomSheet(
                                                  context, item.id.toString());
                                            },
                                            child: Text(
                                              'Reject',
                                              style: customizeTextStyle(
                                                  FontWeight.normal,
                                                  fontSizeFifteen,
                                                  white),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
          )),
        ],
        // ),
      ),
    );
  }

  void customBottomSheet(context, String orderId) {
    _remark.clear();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          width: 0.1.sw,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 0.01.sh,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Reason of rejection ?",
                    style: customizeTextStyle(
                      FontWeight.normal,
                      fontSizeTwenty,
                      red,
                    ),
                  ),
                ),

                SizedBox(
                  height: 0.02.sh,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: TextFormField(
                    maxLines: 4,
                    controller: _remark,
                    decoration: InputDecoration(
                        hintText: 'Remark',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),

                SizedBox(
                  height: 0.02.sh,
                ),

                ///submit btn------------------------------------
                SizedBox(
                  //height: 0.05.sh,
                  width: 0.9.sw,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: red,
                      onPrimary: white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        // side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onPressed: () async {
                      if (_remark.text.trim().isEmpty)
                        showToast('Please enter remark', red);
                      else {
                        showProgress(context);
                        bool result = await networkCall.rejectOrder(
                            remark: _remark.text, orderId: orderId);
                        hideProgress(context);
                        if (result) {
                          await c.getOrderList(
                              latitude: latitude, longitude: longitude);
                          Get.back();
                        }
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _acceptOrder(Datum item) async {
    var datetime = DateFormat('yyyy-MM-dd').format(DateTime.now());
    showProgress(context);
    var result = await networkCall.acceptOrder(
        id: item.id.toString(), datetime: datetime);
    hideProgress(context);
    if (result != null) {
      c.getOrderList(latitude: latitude, longitude: longitude);
      c.action('home');
      c.getAcceptedOrderList();
      c.index(0);
      Get.to(() => OnAccept(
            item: item,
            acceptId: result['data']['id'].toString(),
          ));
    }
  }
}
