import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ReferAdEarn extends StatefulWidget {
  @override
  _ReferAdEarnState createState() => _ReferAdEarnState();
}

class _ReferAdEarnState extends State<ReferAdEarn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Refer & Earn'),
      ),
      floatingActionButton: SpeedDial(
        elevation: 0,
        curve: Curves.fastOutSlowIn,
        animationSpeed: 50,
        overlayOpacity: 0.0,
        overlayColor: Colors.transparent,
        backgroundColor: blueGrey,
        // icon: Icons.share,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(child: Icon(Icons.add, color: black)),
          SpeedDialChild(child: Icon(Icons.east, color: black)),
          SpeedDialChild(child: Icon(Icons.dangerous, color: black)),
          SpeedDialChild(child: Icon(Icons.dnd_forwardslash, color: black))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Image.asset(
                earningAssetImg,
                height: 0.15.sh,
                width: 0.5.sw,
                // color: red,
              ),
            ),
            Text(
              'Fastro Refer Cash',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              '\$ 100.00',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(left: 18.0, right: 18, top: 25),
              child: Text(
                  'Established employee referral the value proposition or tagline you’re using to create a strong buzz.',
                  style: TextStyle(
                    fontSize: 15,
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'YOUR REFERAL CODE',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45),
            ),
            Container(
                // decoration: BoxDecoration(
                //   border: Border.all(width: 1, style: BorderStyle.solid),
                // ),
                padding: EdgeInsets.all(25),
                child: DottedBorder(
                  padding: EdgeInsets.all(15),
                  dashPattern: [6, 3, 2, 3],
                  color: Colors.red[900],
                  strokeWidth: 1,
                  child: Text(
                    'BDQW1245',
                    style: TextStyle(fontSize: 20, color: Colors.red[900]),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
