import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:speedx_driver_122283/models/AcceptedOrdersRes.dart';
import 'package:speedx_driver_122283/models/OrderListRes.dart';
import 'package:speedx_driver_122283/network/NetworkCall.dart';

class MyController extends GetxController {
  var isSelected = 0.obs;
  var isBottomNavbarVisival = true.obs;
  var orderList = <Datum>[].obs;
  var acceptedOrderList = <AcceptDatum>[].obs;
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  var index = 0.obs;
  var action = ''.obs;
  var orderDetail = Datum().obs;

  static MyController get to => Get.find<MyController>();
  Future getOrderList({@required double latitude, @required double longitude}) async {
    isLoading.value = true;
    try {
      orderList.value = await networkCall.getAllOrder(
          latitude: latitude, longitude: longitude);
    } finally {
      isLoading.value = false;
    }
  }

  Future getAcceptedOrderList() async {
    isLoading2.value = true;
    try {
      acceptedOrderList.value = await networkCall.getAcceptedOrder();
    } finally {
      isLoading2.value = false;
    }
  }
}
