import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:speedx_driver_122283/models/AcceptedOrdersRes.dart';
import 'package:speedx_driver_122283/models/CityResponse.dart';
import 'package:speedx_driver_122283/models/OrderListRes.dart';
import 'package:speedx_driver_122283/models/StatesResponse.dart';
import 'package:speedx_driver_122283/network/MyClient.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:speedx_driver_122283/utils/sharedPref.dart';

NetworkCall networkCall = NetworkCall();

class NetworkCall {
  Future<List<StatesData>> getStates() async {
    String url = baseUrl + getStateApi;
    print('getStateApi $url');

    try {
      Response response = await MyClient().get(Uri.parse(url));
      if (response.statusCode == 200) {
        final myjson = jsonDecode(response.body);
        final myResponse = StatesResponse.fromJson(myjson);
        if (myResponse.status == success) {
          return myResponse.dataList;
        } else {
          throw response.body;
        }
      } else {
        throw 'Failed';
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  ///-------------------------------get city api----------------------------
  Future getCities(String id) async {
    String url = baseUrl + getCityApi;
    print('getCityApi $url');
    try {
      Response response = await MyClient().get(Uri.parse('$url/$id'));
      if (response.statusCode == 200) {
        final myjson = jsonDecode(response.body);
        final myResponse = CityResponse.fromJson(myjson);
        if (myResponse.status == success) {
          return myResponse.dataList;
        } else {
          throw response.body;
        }
      } else {
        throw 'Failed';
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  //-----------------------------------register api---------------------------
  Future register(
      {String fName,
      String mName,
      String lName,
      String email,
      String phoneNo,
      String address,
      String referalCode,
      String latitude,
      String longitude,
      String address2,
      String stateId,
      String cityId,
      String zipCode,
      String idProof1,
      String idProrf1Img,
      String idProof2,
      String idProof2Img,
      String drivingLicsnc,
      String drivingLImg,
      String password}) async {
    String url = baseUrl + registerApi;
    print('registerApi $url');
    Map params = {
      "f_name": fName,
      "m_name": mName,
      "l_name": lName,
      "email": email,
      "phone_no": phoneNo,
      "address": address,
      "referral_code": referalCode,
      "latitude": latitude,
      "longitude": longitude,
      "address2": address2,
      "state_id": stateId,
      "city_id": cityId,
      "zip_code": zipCode,
      "id_proof_1": idProof1,
      "id_proof_1_image": "data:image/jpeg;base64,$idProrf1Img",
      "id_proof_2": idProof2,
      "id_proof_2_image": "data:image/jpeg;base64,$idProof2Img",
      "driving_license_no": drivingLicsnc,
      "driving_license_image": "data:image/jpeg;base64,$drivingLImg",
      "password": password
    };
    // print(params);
    try {
      Response response = await MyClient().post(Uri.parse(url), body: params);
      final myJson = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        if (myJson['status'] == success) return myJson;
      } else {
        var error = myJson['errors'] as Map;
        if (error != null) {
          showToast(error.values.first[0], red);
        }
        return null;
      }
    } on SocketException {
      showToast(internetError, red);
      return null;
    }
  }

  ///--------------------------------OTP validate--------------------------------

  Future<bool> otpValidate(String id, String otp) async {
    String url = baseUrl + otpVerifyApi;
    print('OtpVerification $url');
    Map<String, String> data = {"id": id, "otp": otp};
    try {
      Response response = await MyClient().post(
        Uri.parse(url),
        body: data,
      );
      print(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == success) {
          showToast(jsonResponse['message'], Colors.blue);
          return true;
        } else {
          showToast(jsonResponse['message'], Colors.red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      return false;
    } catch (e) {
      return false;
    }
  }

  // ---------------------- signin ----------------------
  Future<bool> signInApiCall(
      {String email, String password, String deviceId}) async {
    String url = baseUrl + loginApi;
    print('signInApiCall ' + url);
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
      "device_id": deviceId
    };
    // make POST request
    //print(json.encode(body));
    try {
      Response response = await MyClient().post(
        Uri.parse(url),
        body: body,
      );

      print(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == success) {
          // print(jsonResponse);

          sharePrefereceInstance.saveUserDetail(jsonResponse['data']);

          return true;
        } else {
          showToast(jsonResponse["msg"], red);
          return false;
        }
      } else {
        var error = json.decode(response.body)["errors"] as Map;
        if (error != null) {
          showToast(error.values.first[0], red);
        }
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      return false;
    } catch (e) {
      return false;
    }
  }

  /// ---------------------------------logout(post)---------------------------------

  Future<bool> logOut() async {
    String url = baseUrl + logoutApi;
    print('logout ' + url);

    String authorizitionWithBearer =
        'Bearer ${SharePreferenceInstance().getToken()}';

    //print(authorizitionWithBearer);
    try {
      Response response = await MyClient()
          .post(Uri.parse(url), headers: myHeaders(authorizitionWithBearer));
      // print(response.body);

      //print(response.body + '\n${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == success) {
          print(jsonResponse);
          showToast(jsonResponse["message"], blue);
          return true;
        } else {
          showToast(jsonResponse["message"], red);
          return false;
        }
      } else {
        //print(json.decode(response.body)["message"]);
        showToast(json.decode(response.body)["message"], Colors.red);
        throw json.decode(response.body)["message"];
      }
    } catch (e) {
      showToast(e, Colors.red);
      return false;
    }
  }

  //-----------------------------Forgot password-------------------------
  Future forgotPasswordCall({String phoneNo}) async {
    String url = baseUrl + forgotPasswordApi;
    print('forgotPasswordCall ' + url);

    // String authorizitionWithBearer =
    //     'Bearer ${SharePreferenceInstance().getToken()}';
    Map<String, dynamic> body = {"phone_no": phoneNo};
    // make POST request
    // print(json.encode(body));
    try {
      Response response = await MyClient().post(
        Uri.parse(url),
        body: body,
      );
      print(response.body);
      if (response.statusCode == 200) {
        final myjson = jsonDecode(response.body);
        if (myjson['status'] == success) {
          //print(jsonResponse);
          showToast(myjson['message'], blue);
          return myjson;
        } else {
          showToast(myjson['message'], red);
          return null;
        }
      } else {
        var error = json.decode(response.body)["errors"];
        if (error != null) error = error['phone_no'][0];
        showToast(error, red);
        throw error;
        //throw CustomError(json.decode(response.body)["msg"]);
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  //--------------------------get All request order--------------------------
  Future<List<Datum>> getAllOrder({double latitude, double longitude}) async {
    String url = baseUrl + getAllOrderApi;
    print('getAllOrderApi $url');
    String authorizitionWithBearer =
        'Bearer ${SharePreferenceInstance().getToken()}';
    var param = {
      'latitude': latitude.toString(),
      'longitude': longitude.toString()
    };
    print(param);
    try {
      Uri uri = Uri.parse(url).replace(queryParameters: param);
      Response response = await MyClient()
          .get(uri, headers: myHeaders(authorizitionWithBearer));
      print(response.body);
      if (response.statusCode == 200) {
        final myResponse = OrderListRes.fromJson(jsonDecode(response.body));
        if (myResponse.status == success) {
          //if (myResponse.data.length == 0) showToast('No Data Found', red);
          return myResponse.data;
        } else {
          // showToast('No Data Found', red);
          return null;
        }
      } else {
        return null;
      }
    } on SocketException {
      showToast(internetError, red);
      return null;
    }
  }

  //-----------------------------Accept Order---------------------------
  Future acceptOrder({String id, String datetime}) async {
    String url = baseUrl + acceptOrderApi;
    print('acceptOrderApi- $url');
    String token = 'Bearer ${SharePreferenceInstance().getToken()}';
    var param = {'id': id, 'date_time': datetime};
    try {
      Response response = await MyClient()
          .post(Uri.parse(url), body: param, headers: myHeaders(token));
      print(response.body);
      if (response.statusCode == 200) {
        final myjson = jsonDecode(response.body);
        showToast(myjson['message'], blue);
        if (myjson['status'] == success) return myjson;
        return null;
      } else {
        showToast(response.body, red);
        return null;
      }
    } on SocketException {
      showToast(internetError, red);
      return null;
    }
  }

  //--------------------------get accepted order-----------------------------
  Future<List<AcceptDatum>> getAcceptedOrder() async {
    String url = baseUrl + getAcceptedOrderApi;
    String token = 'Bearer ${sharePrefereceInstance.getToken()}';
    try {
      Response response =
          await MyClient().get(Uri.parse(url), headers: myHeaders(token));
      final myJson = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final myResponse = AcceptedOrdersRes.fromJson(myJson);
        if (myResponse.status == success) {
          return myResponse.data;
        } else {
          showToast(myJson, red);
          return null;
        }
      } else {
        final error = myJson['errors'] as Map;
        if (error != null) showToast(error.values.first[0], red);
        return null;
      }
    } on SocketException {
      showToast(internetError, red);
      return null;
    } on TimeoutException {
      showToast(internetSlowError, red);
      return null;
    }
  }

  //-------------------------save parcel detail-------------------------

  Future<bool> saveParcelDetails(Map<String, dynamic> params) async {
    String url = baseUrl + saveParcelDetailApi;
    print('saveParcelDetailApi- $url');
    String token = 'Bearer ${sharePrefereceInstance.getToken()}';
    try {
      Response response = await MyClient().post(Uri.parse(url),
          body: jsonEncode(params),
          headers: myHeaders(token, 'application/json'));
      print(response.body);
      final myjson = jsonDecode(response.body);
      showToast(myjson['message'], red);
      if (response.statusCode == 200) {
        if (myjson['status'] == success) return true;
        return false;
      } else {
        final error = myjson['errors'] as Map;
        if (error != null) showToast(error.values.first[0], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      return false;
    } on TimeoutException {
      showToast(internetSlowError, red);
      return false;
    }
  }

  //-----------------------send pickup otp---------------------------
  Future sendPickupOTP({String phone, String orderId}) async {
    String url = baseUrl + sendPickupOtpApi;
    print('sendPickupOtp- $url');
    var param = {"order_id": orderId, "phone_no": phone};
    print('param- $param');
    String token = 'Bearer ${sharePrefereceInstance.getToken()}';
    try {
      Response response = await MyClient()
          .post(Uri.parse(url), body: param, headers: myHeaders(token));
      print(response.body);
      final myjson = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showToast(myjson['message'], blue);
        return myjson;
      } else {
        showToast(myjson['message'], red);
        return null;
      }
    } on SocketException {
      showToast(internetError, red);
      return null;
    }
  }

  //--------------------------verify pickup OTP----------------------
  Future<bool> verifyPickupOtp(
      {String orderID, String acceptId, String otp}) async {
    String url = baseUrl + verifyPickupOtpApi;
    print('verifyPickupOtp- $url');
    var param = {"id": acceptId, "order_id": orderID, "otp": otp};
    print(param);
    String token = 'Bearer ${sharePrefereceInstance.getToken()}';
    try {
      Response response = await MyClient()
          .post(Uri.parse(url), body: param, headers: myHeaders(token));
      print(response.body);
      final myjson = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (myjson['status'] == success) return true;
        return false;
      } else {
        showToast(myjson['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      return false;
    }
  }

  //---------------------------send drop OTP------------------------
  Future sendDropOtp({String dropAddId, String phoneNo}) async {
    String url = baseUrl + sendDropOtpApi;
    print('sendDropOtpApi- $url');
    String token = 'Bearer ${sharePrefereceInstance.getToken()}';
    var param = {"drop_address_id": dropAddId, "phone_no": phoneNo};
    print(param);
    try {
      Response response = await MyClient()
          .post(Uri.parse(url), body: param, headers: myHeaders(token));
      print(response.body);
      if (response.statusCode == 200) {
        final myjson = jsonDecode(response.body);
        if (myjson['status'] == success) return myjson;
        return null;
      } else {
        showToast(response.body, red);
        return null;
      }
    } on SocketException {
      showToast(internetError, red);
    }
  }

  //---------------------------verify drop OTP------------------------
  Future<bool> verifyDropOtp({String dropAddId, String otp}) async {
    String url = baseUrl + verifyDropOtpApi;
    print('verifyDropOtpApi- $url');
    String token = 'Bearer ${sharePrefereceInstance.getToken()}';
    var param = {"drop_address_id": dropAddId, "otp": otp};
    print(param);
    try {
      Response response = await MyClient()
          .post(Uri.parse(url), body: param, headers: myHeaders(token));
      print(response.body);
      if (response.statusCode == 200) {
        final myjson = jsonDecode(response.body);
        if (myjson['status'] == success) return true;
        return false;
      } else {
        showToast(response.body, red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      return false;
    }
  }

  //-----------------------------reject order---------------------------

  Future<bool> rejectOrder({String orderId, String remark}) async {
    String url = baseUrl + rejectOrderApi;
    print('rejectOrderApi- $url');
    String token = 'Bearer ${sharePrefereceInstance.getToken()}';
    var param = {"id": orderId, "remarks": remark};
    try {
      Response response = await MyClient()
          .post(Uri.parse(url), body: param, headers: myHeaders(token));
      if (response.statusCode == 200) {
        final myjson = jsonDecode(response.body);
        showToast(myjson['message'], red);
        if (myjson['status'] == success) return true;
        return false;
      } else {
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      return false;
    }
  }

  //-------------------------emergency order reject--------------------------
  Future<bool> emergencyOrderReject(
      {String acceptId, String orderId, String remark}) async {
    String url = baseUrl + emergencyRejectOrderApi;
    print('emergencyRejectApi- $url');
    String token = 'Bearer ${sharePrefereceInstance.getToken()}';
    var param = {"id": acceptId, "order_id": orderId, "remarks": remark};
    try {
      Response response = await MyClient()
          .post(Uri.parse(url), body: param, headers: myHeaders(token));
      print(response.body);
      if (response.statusCode == 200) {
        final myjson = jsonDecode(response.body);
        showToast(myjson['message'], red);
        if (myjson['status'] == success) return true;
        return false;
      } else {
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      return false;
    }
  }

  ///---------------------------------update Profile------------------------

  Future<bool> updateProfile(Map<String, String> params) async {
    String url = baseUrl + updateProfileApi;
    print('updateProfileApi- $url');
    String token = 'Bearer ${SharePreferenceInstance().getToken()}';
    print(jsonEncode(params));
    try {
      Response response = await MyClient()
          .post(Uri.parse(url), body: params, headers: myHeaders(token));
      print(response.body);
      if (response.statusCode == 200) {
        final myJson = jsonDecode(response.body);
        showToast(myJson['message'], red);
        if (myJson['status'] == success) {
          return true;
        }
        return false;
      } else {
        final error = jsonDecode(response.body)['errors'] as Map;
        if (error != null) {
          var msg = error.values.first as List;
          showToast(msg[0], red);
        }

        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      return false;
    }
  }

  //---------------------------------get user data-----------------------------
  Future<bool> getUserData() async {
    String url = baseUrl + getAuthUserApi;
    print('getAuthUserApi $url');
    String token = 'Bearer ${SharePreferenceInstance().getToken()}';
    try {
      Response response =
          await MyClient().get(Uri.parse(url), headers: myHeaders(token));
      if (response.statusCode == 200) {
        final myjson = jsonDecode(response.body);
        if (myjson['status'] == success) {
          final sp = sharePrefereceInstance;
          sp.setEmail(myjson['data']['email']);
          sp.setUserId(myjson['data']['id']);
          sp.setUserPhone(myjson['data']['phone_no']);
          sp.setName(myjson['data']['f_name']);
          sp.setMiddleName(myjson['data']['m_name'] ?? '');
          sp.setLastName(myjson['data']['l_name']);
          sp.setImage(myjson['data']['image']);
          sp.setUserAddress(myjson['data']['address']);
          sp.setAddress2(myjson['data']['address2'] ?? '');
          sp.setZipCode(myjson['data']['zip_code']);
          sp.setState(myjson['data']['state']['state_name']);
          sp.setCity(myjson['data']['city']['city_name']);
          sp.setAccCreateAt(myjson['data']['created_at']);
          sp.setRefCode(myjson['data']['referral_code']);
          sp.setWallet(myjson['data']["wallet"]);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } on SocketException {
      return false;
    }
  }
}
