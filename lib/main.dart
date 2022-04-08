import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:speedx_driver_122283/utils/sharedPref.dart';
import 'package:speedx_driver_122283/view/getStarted/getStarted.dart';
import 'package:speedx_driver_122283/view/home/dashboard.dart';
import 'applicationProvider/authentication_event.dart';
import 'applicationProvider/authentication_notifier.dart';
import 'applicationProvider/authentication_state.dart';
import 'controller/MyController.dart';
import 'utils/const.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MyController());
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    Provider.debugCheckInvalidValueType = null;
    await sharePrefereceInstance.init();
    initOneSignal();
    runApp(
      ChangeNotifierProvider(
        create: (_) =>
            AuthenticationNotifier()..notifyStateChange(AppStarted()),
        child: MyApp(),
        //child: Xyz(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: () {
          return GetMaterialApp(
            theme: ThemeData(primaryColor: Colors.black, fontFamily: 'Poppins'),
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              ScreenUtil.setContext(context);
              return MediaQuery(data: MediaQuery.of(context), child: child);
            },
            home: Consumer<AuthenticationNotifier>(
                builder: (context, authenticationNotifier, _) {
              AuthenticationState state =
                  authenticationNotifier.getAuthenticationState;
              if (state is AuthenticationAuthenticated) {
                return Dashboard();
                //return GetStarted();
              } else if (state is AuthenticationUnauthenticated) {
                return GetStarted();
              } else {
                // Login SplashScreen();
                return GetStarted();
              }
            }),
          );
        });
  }
}
