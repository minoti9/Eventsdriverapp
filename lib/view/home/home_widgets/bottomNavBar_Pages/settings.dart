import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speedx_driver_122283/utils/const.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speedx_driver_122283/view/home/home_widgets/bottomNavBar_Pages/profile.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            InkWell(
              onTap: () => Get.to(()=>Profile(action: 'edit',)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Edit account', style: TextStyle(fontSize: 20)),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ],
              ),
            ),
            Divider(thickness: 2, color: grey),
            InkWell(
              onTap: () {
                Get.to(ChangePassword());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Change Password', style: TextStyle(fontSize: 20)),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget createDrawerBodyItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(
            width: 0.01.sw,
          ),
          Container(
            width: 0.3.sw,
            child: Text(
              text,
              style: customizeTextStyle(
                mediumTextWeight,
                0.05.sw,
                Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 0.2.sw,
          ),
          Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
      onTap: onTap,
    );
  }
}

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueGrey,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            }),
        title: Text('Change Password', style: TextStyle(color: white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              obscureText: isHidden,
              decoration: InputDecoration(
                labelText: 'Old Password',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                suffixIcon: Container(
                  margin: EdgeInsets.all(8),
                  decoration: new BoxDecoration(
                    color: blueGrey,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          isHidden = !isHidden;
                        });
                      },
                      child: Icon(
                        isHidden ? Icons.visibility_off : Icons.visibility,
                        size: 16,
                        color: white,
                      )),
                ),
              ),
            ),
            TextFormField(
              obscureText: isHidden,
              decoration: InputDecoration(
                labelText: 'New Password',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                suffixIcon: Container(
                  margin: EdgeInsets.all(8),
                  decoration: new BoxDecoration(
                    color: blueGrey,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          isHidden = !isHidden;
                        });
                      },
                      child: Icon(
                        isHidden ? Icons.visibility_off : Icons.visibility,
                        size: 16,
                        color: white,
                      )),
                ),
              ),
            ),
            TextFormField(
              obscureText: isHidden,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                suffixIcon: Container(
                  margin: EdgeInsets.all(8),
                  decoration: new BoxDecoration(
                    color: blueGrey,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          isHidden = !isHidden;
                        });
                      },
                      child: Icon(
                        isHidden ? Icons.visibility_off : Icons.visibility,
                        size: 16,
                        color: white,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 0.9.sw,
              height: 0.06.sh,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                onPressed: () {},
                child: Text('Update Password',
                    style: TextStyle(color: white, fontSize: 20)),
                color: blueGrey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
