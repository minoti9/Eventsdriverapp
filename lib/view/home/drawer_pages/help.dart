import 'package:flutter/material.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Help& suppport"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Faq-------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Faq",
                  style: customizeTextStyle(
                      FontWeight.normal, fontSizeTwenty, Colors.black),
                ),
                Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            Divider(
              thickness: 0.002.sw,
            ),

            ///Term & condition ---------------------------
            SizedBox(
              height: 0.02.sh,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Term & condition",
                  style: customizeTextStyle(
                      FontWeight.normal, fontSizeTwenty, Colors.black),
                ),
                Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            Divider(
              thickness: 0.002.sw,
            ),

            /// PrivacyPolicy ------------------------------
            SizedBox(
              height: 0.02.sh,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Privacy Policy",
                  style: customizeTextStyle(
                      FontWeight.normal, fontSizeTwenty, Colors.black),
                ),
                Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            Divider(
              thickness: 0.002.sw,
            ),

            ///Contact Us-----------------------
            SizedBox(
              height: 0.02.sh,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Contact Us",
                  style: customizeTextStyle(
                      FontWeight.normal, fontSizeTwenty, Colors.black),
                ),
                Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            Divider(
              thickness: 0.002.sw,
            )
          ],
        ),
      ),
    );
  }
}
