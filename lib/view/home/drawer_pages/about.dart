import 'package:flutter/material.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ABOUT extends StatefulWidget {
  @override
  _ABOUTState createState() => _ABOUTState();
}

class _ABOUTState extends State<ABOUT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("About"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        height: 0.5.sh,
        width: 1.sw,
        child: Text(
          "Flutter is an open-source UI software development kit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, Google Fuchsia, and the web from a single codebase. The first version of Flutter was known as codename and ran on the Android operating system. Wikipedia",
          style:
              customizeTextStyle(FontWeight.normal, fontSizeFifteen, blueGrey),
        ),
      ),
    );
  }
}
