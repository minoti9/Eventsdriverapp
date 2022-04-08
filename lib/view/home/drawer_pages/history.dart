import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speedx_driver_122283/controller/MyController.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speedx_driver_122283/view/home/home_widgets/bottomNavBar_Pages/home/afterOnAccept.dart';
import 'package:speedx_driver_122283/view/home/home_widgets/bottomNavBar_Pages/home/onAccept.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final myControler = MyController.to;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myControler.getAcceptedOrderList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("My Orders"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 0.02.sh,
          ),
          Expanded(
            child: Obx(() {
              if (myControler.isLoading2.value)
                return Center(
                  child: CupertinoActivityIndicator(
                    radius: 20,
                  ),
                );
              if (myControler.acceptedOrderList.length == 0)
                return Center(child: Text('No Data Found'));
              return ListView.separated(
                separatorBuilder: (_, __) => SizedBox(
                  height: 15,
                ),
                shrinkWrap: true,
                itemCount: myControler.acceptedOrderList.length,
                itemBuilder: (_, int index) {
                  final item = myControler.acceptedOrderList[index];
                  return Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Booking id: ${item.order.uniqueId}'),
                            Text(
                              '${item.status} ',
                              style: TextStyle(
                                  color: green, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Order Date: '),
                            Text(
                                '${item.order.createdAt.toString().split('.')[0]} '),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Pickup Date: '),
                            Text(
                                '${item.order.orderDate.toString().split(' ')[0]} ${item.order.orderTime} '),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(radius: 5, backgroundColor: green),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Pick up Address:',
                              style: TextStyle(
                                  color: green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                  '${item.order.pickupAddress.detailAddress},${item.order.pickupAddress.landmark},${item.order.pickupAddress.address}'),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(radius: 5, backgroundColor: red),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Drop Location:',
                              style: TextStyle(
                                  color: red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      item.order.dropAddress.length,
                                      (index) => Column(
                                            children: [
                                              Text(
                                                  '${index + 1}. ${item.order.dropAddress[index].dropAddress.detailAddress},${item.order.dropAddress[index].dropAddress.landmark},${item.order.dropAddress[index].dropAddress.address}'),
                                              Divider()
                                            ],
                                          )) /* item.order.dropAddress
                                    .map((e) => Column(
                                          children: [
                                            Text(
                                                '${e.dropAddress.detailAddress},${e.dropAddress.landmark},${e.dropAddress.address}'),
                                            Divider()
                                          ],
                                        ))
                                    .toList(), */
                                  ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (item.status.toLowerCase() != 'delivered')
                          ElevatedButton(
                            onPressed: () {
                              myControler.index(index);
                              myControler.action('history');
                              if (item.status
                                  .toLowerCase()
                                  .contains('picked')) {
                                Get.to(() => AfterOnAcceptDropLocation(
                                      acceptId: item.id.toString(),
                                    ));
                              } else {
                                Get.to(() => OnAccept(
                                      item: item.order,
                                      acceptId: item.id.toString(),
                                    ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                            ),
                            child: Text(
                              'Ready For ${item.status.toLowerCase().contains('picked') ? 'Delivery' : 'Pickup'}',
                              style: TextStyle(color: white),
                            ),
                          )
                      ],
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
