import 'package:flutter/material.dart';
import 'package:speedx_driver_122283/utils/const.dart';

class DashBoardWidget {
  bool isSwitched = false;
/////ist page
  Widget HomeAppBar(_width, _height) {
    return AppBar(
      iconTheme: IconThemeData(color: black),
      backgroundColor: white,
      title: Text(
        'Driver Name',
        style: TextStyle(color: black),
      ),
      actions: [
        Row(
          children: [
            Text(
              'Active',
              style: TextStyle(color: black),
            ),
            Text(
              'Deactive',
              style: TextStyle(color: black),
            ),
            // Switch(
            //   value: isSwitched,
            //   onChanged: (val) {
            //     // setState(() {
            //     //   isSwitched = val;
            //     //   print(isSwitched);
            //     // }
            //     );
            // },
            //  activeTrackColor: Colors.lightGreenAccent,
            //  activeColor: Colors.green,
            //  ),
          ],
        )
      ],
    );
  }

////////////2nd page
  Widget ProfileAppBar(_width, _height) {
    return AppBar(
        elevation: 0,
        backgroundColor: blueGrey,
        //iconTheme: IconThemeData(color: white),
        title: Text("My Account"),
        actions: [
          Row(children: [
            Text("Edit"),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.edit),
                )),
          ])
        ]);
  }

  ///////3rd page
  Widget settingsAppbar(_width, _height) {
    return AppBar(
      backgroundColor: blueGrey,
      title: Text('Settings', style: TextStyle(color: white)),
    );
  }
}
