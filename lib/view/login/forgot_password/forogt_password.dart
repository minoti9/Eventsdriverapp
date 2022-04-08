import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:speedx_driver_122283/network/NetworkCall.dart';
// import 'package:sms_autofill/sms_autofill.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speedx_driver_122283/view/login/login.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _contr = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _contr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Forgot Password', style: TextStyle(color: white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 0.08.sh,
            ),
            Text('Phone Verification',
                style: TextStyle(
                    color: red, fontSize: 25, fontWeight: FontWeight.bold)),
            Divider(
              thickness: 2,
              endIndent: 0.2.sw,
              indent: 0.2.sw,
            ),
            SizedBox(
              height: 0.05.sh,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35),
              child: Text('We just neeed your registered mobile number to',
                  style: TextStyle(fontSize: 15)),
            ),
            Text(' send your password reset', style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 0.03.sh,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _contr,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: 'Enter Phone No',
                    labelText: 'Phone No.',
                    counterText: ''),
              ),
            ),
            SizedBox(
              height: 0.04.sh,
            ),
            SizedBox(
              width: 0.9.sw,
              height: 0.06.sh,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                onPressed: () {
                  if (_contr.text.trim().isEmpty) {
                    showToast('Please enter phone no.', red);
                  } else if (_contr.text.trim().length < 10) {
                    showToast('Phone no. should be 10 digits', red);
                  } else
                    _getOtp();
                },
                child: Text('Get Otp',
                    style: TextStyle(color: white, fontSize: 20)),
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOtpDialog(int otp, int id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('OTP Validate'),
            actions: [
              FlatButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Cancel'),
              )
            ],
            content: PinFieldAutoFill(
              decoration: UnderlineDecoration(
                textStyle: TextStyle(fontSize: 20, color: Colors.black),
                colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
              ),
              onCodeChanged: (code) {
                if (code.length == 6) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (int.parse(code) == otp) {
                    _otpValidate(code, id);
                  } else
                    showToast('Please enter valid code', Colors.black);
                }
              },
            ),
          );
        });
  }

  void _getOtp() async {
    showProgress(context);
    final result = await networkCall.forgotPasswordCall(phoneNo: _contr.text);
    hideProgress(context);
    if (result != null) {
      _showOtpDialog(result['data']['otp'], result['data']['id']);
    }
  }

  void _otpValidate(String code, int id) async {
    showProgress(context);
    bool result = await networkCall.otpValidate(id.toString(), code);
    hideProgress(context);
    print(result);
    if (result)
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }
}
