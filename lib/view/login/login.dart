import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:speedx_driver_122283/network/NetworkCall.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:speedx_driver_122283/view/Signup/sign_up.dart';
import 'package:speedx_driver_122283/view/home/dashboard.dart';
import 'forgot_password/forogt_password.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isHidden = true;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Login', style: TextStyle(color: black, fontSize: 14)),
        backgroundColor: white,
        leading: IconButton(
          color: black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///top image----------------------------------
              Image.asset(
                logoImg,
                height: 0.1.sh,
                width: 0.5.sw,
              ),

              SizedBox(
                height: 0.01.sh,
              ),

              ///login text----------------------------------
              Text(
                'Log In',
                style: TextStyle(fontSize: 25, color: blueGrey),
              ),

              ///lower divider----------------------------------
              Padding(
                padding: EdgeInsets.only(left: 0.35.sw, right: 0.35.sw),
                child: SizedBox(
                  child: Divider(
                    thickness: 4,
                    color: grey,
                  ),
                ),
              ),

              ///text fields--------------------------------------
              // textFields(),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _email,
                        validator: (v) {
                          if (v.trim().isEmpty) return 'Please enter email id';
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Enter Email Id', labelText: 'Email Id'),
                      ),
                      SizedBox(
                        height: 0.03.sh,
                      ),
                      TextFormField(
                        controller: _password,
                        validator: (v) {
                          if (v.trim().isEmpty) return 'Please enter password';
                          return null;
                        },
                        obscureText: isHidden,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Password',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          suffixIcon: Container(
                            margin: EdgeInsets.all(8),
                            decoration: new BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isHidden = !isHidden;
                                  });
                                },
                                child: Icon(
                                  isHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 16,
                                  color: white,
                                )),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 0.03.sh,
              ),

              ///Forgot Password btn------------------------------
              InkWell(
                onTap: () {
                  Get.to(() => ForgotPassword());
                },
                child: Text('Forgot Password ?',
                    style: TextStyle(fontSize: 18, color: black)),
              ),

              SizedBox(
                height: 0.03.sh,
              ),

              ///loginButton --------------------------------------
              SizedBox(
                width: 0.9.sw,
                height: 0.06.sh,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () {
                    // Get.to(Dashboard());
                    if (_formKey.currentState.validate()) {
                      _login();
                    }
                  },
                  child: Text('Log In',
                      style: TextStyle(color: white, fontSize: 18)),
                  color: primaryColor,
                ),
              ),

              SizedBox(
                height: 0.03.sh,
              ),

              ///have nt acc------------------------------
              Text('Don\'t have an account ?',
                  style: TextStyle(fontSize: 18, color: black)),

              SizedBox(
                height: 0.03.sh,
              ),

              ///Sign Up btn ------------------------
              SizedBox(
                width: 0.9.sw,
                height: 0.06.sh,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  ),
                
                  onPressed: () => Get.to(() => SignUp()),
                  child: Text('Sign Up',
                      style: TextStyle(color: white, fontSize: 20)),
                  
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getDeviceId() async {
    DeviceInfoPlugin infoPlugin = DeviceInfoPlugin();
    String deviceId = '';
    if (Platform.isAndroid) {
      var info = await infoPlugin.androidInfo;
      deviceId = info.androidId;
    } else {
      var info = await infoPlugin.iosInfo;
      deviceId = info.identifierForVendor;
    }
    return deviceId;
  }

  void _login() async {
    var status = await OneSignal.shared.getDeviceState();
    var deviceId = status.userId;
    print('id- ${status.userId}');
    showProgress(context);
    bool result = await networkCall.signInApiCall(
        password: _password.text, email: _email.text, deviceId: deviceId);
    hideProgress(context);
    if (result) Get.off(() => Dashboard());
  }
}

