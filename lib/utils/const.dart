import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geocoding/geocoding.dart';
import 'package:google_place/google_place.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

//--------------- images ---------------
final String logoImg = 'assets/logo.png';
final String bgAssetImg = 'assets/bg.jpg';
final String earningAssetImg = 'assets/earning.png';
final String mapAssetImg = 'assets/map.png';
final String offersTagAssetImg = 'assets/offers_tag.png';
final String profileAssetImg = 'assets/profile.png';
final String sliderAssetImg = 'assets/slider.jpg';

//---------------colors---------------
final Color grey = Colors.grey[200];
final Color greySolid = Colors.grey;
final Color red = Colors.red;
final Color black = Colors.black;
final Color green = Colors.green;
final Color white = Colors.white;
final Color blue = Colors.blue;
final Color dividerColor = Color(0xff818181);
final Color blueGrey = Colors.blueGrey[900];
///////////weight
final FontWeight mediumTextWeight = FontWeight.w500;
final Color primaryColor = Color(0xffFF7D13);
final Color secondaryColor = Color(0xff003B71);


///size-------------------------------------------------------

//final double fontSizeTen = 10.0.ssp;
final double fontSizeEleven = 11.0;
final double fontSizeTwelve = 12.0;
final double fontSizeThirteen = 13.0;
final double fontSizeFourteen = 14.0;
final double fontSizeFifteen = 15.0;
final double fontSizeSixteen = 16.0;
final double fontSizeSeventeen = 17.0;
final double fontSizeEighteen = 18.0;
final double fontSizeNineteen = 19.0;
final double fontSizeTwenty = 20.0;
final double fontSizeTwentyOne = 21.0;
final double fontSizeTwentyTwo = 22.0;
final double fontSizeTwentyThree = 23.0;
final double fontSizeTwentyFour = 24.0;
final double fontSizeTwentySix = 26.0;
final double fontSizeTwentyEight = 28.0;
final double fontSizeThirty = 30.0;
final double fontSizeThirtyTwo = 32.0;
final double fontSizeSixty = 60.0;
final double fontSizeFiftyFive = 50.0;
final double buttonCornerRadius = 100.0;
final double logoutBtnCornerRadius = 40.0;
final double fontSizeForty = 60.0;
final double skipButtonCornerRedius = 100.0;
final double loginAsGuestUserButtonCornerRadius = 80;
final double loginButtonCornerRadius = 100;
final double fontSizeFourty = 40;
final double fontSizethirty = 30;
final double fontSizethirtyFive = 35;
final double marginTop = 15;
final String defaultFontFamily = "Inter";

/*-------------------------Fluttertoast-------------------------*/

showToast(msg, color) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0);

///------------------------progress--------------------
showProgress(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: CupertinoActivityIndicator(
            radius: 25,
          ),
        );
      },
      barrierDismissible: false);
}

void hideProgress(BuildContext context) {
  Navigator.pop(context);
}

////style
TextStyle customizeTextStyle(
  fontWeight,
  fontSize,
  fontColor,
) =>
    TextStyle(
        fontWeight: fontWeight,
        fontFamily: defaultFontFamily,
        wordSpacing: 3,
        color: fontColor,
        fontSize: fontSize);

final String googlePlaceApiKey = 'AIzaSyBMiQPffGpvMTrSGNv0mWQZ_U1tqBURzec';
final googleplace = GooglePlace(googlePlaceApiKey);

Future<geo.Location> getLatLngFromAddress(String adrss) async {
  var address = await locationFromAddress(adrss);
  print(address.first.toJson());
  
  return address.first;
}

///----------------------------network--------------------------
//for Send it app
//final String baseUrl =
//  'https://laravel.gowebbidemo.com/122245/public/api/v1/user';
// for My Delivery app
final String baseUrl =
    'https://laravel.gowebbidemo.com/122245/public/';

final String getStateApi = '/get-states';
final String getCityApi = '/get-cities';
final String registerApi = '/driver-register';
final String otpVerifyApi = '/otp-verification';
final String loginApi = '/login';
final String forgotPasswordApi = '/forget-password';
final String getAllOrderApi = '/get-all-requested-orders';
final String acceptOrderApi = '/accept-order-by-driver';
final String getAcceptedOrderApi = '/get-driver-accepted-orders';
final String saveParcelDetailApi = '/save-pickup-item-details';
final String sendPickupOtpApi = '/send-pickup-otp';
final String verifyPickupOtpApi = '/verify-pickup-otp';
final String sendDropOtpApi = '/send-drop-otp';
final String verifyDropOtpApi = '/verify-drop-otp';
final String logoutApi = '/logout';
final String rejectOrderApi = '/reject-order-by-driver';
final String emergencyRejectOrderApi = '/emergency-reject-order-by-driver';
final String updateProfileApi = '/update-profile';
final String getAuthUserApi = '/get-auth-user';

final String internetError = "Please check your Internet! 😢";
final String internetSlowError = 'Internet is too slow';
final String currencyINR = '\$';
final String success = "success";
final String weightUnit = 'Pound';
final String weightUnit2 = 'Pounds';
final String lengthUnit = 'CM';
final String oneSignalAppId = '74707e32-f4e0-4b33-9a4f-2bff940b0007';

//--------------------------inti onesignal-------------------------
void initOneSignal() {
  // OneSignal.shared.init(oneSignalAppId, iOSSettings: {
  //   OSiOSSettings.autoPrompt: false,
  //   OSiOSSettings.inAppLaunchUrl: false
  // });
  OneSignal.shared.setAppId(oneSignalAppId);
  // OneSignal.shared
  //     .setInFocusDisplayType(OSNotificationDisplayType.notification);
}

//--------------------------headers--------------------------------

Map<String, String> myHeaders([String authorization, String contentType]) {
  if (contentType != null) {
    return {'Authorization': authorization, 'content-type': contentType};
  }
  return {'Authorization': authorization};
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      .buffer
      .asUint8List();
}
