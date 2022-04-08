import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speedx_driver_122283/network/NetworkCall.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speedx_driver_122283/utils/sharedPref.dart';
import 'package:speedx_driver_122283/view/DrawerCustomPaint.dart';
import 'package:speedx_driver_122283/view/home/drawer_pages/about.dart';
import 'package:speedx_driver_122283/view/home/drawer_pages/help.dart';
import 'package:speedx_driver_122283/view/home/drawer_pages/history.dart';
import 'package:speedx_driver_122283/view/home/drawer_pages/payment.dart';
import 'package:speedx_driver_122283/view/home/drawer_pages/refer&earn.dart';
import 'package:speedx_driver_122283/view/home/drawer_pages/review.dart';
import 'package:speedx_driver_122283/view/login/login.dart';
import 'home_widgets/bottomNavBar_Pages/home/home.dart';
import 'home_widgets/bottomNavBar_Pages/profile.dart';
import 'home_widgets/bottomNavBar_Pages/settings.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var v = 'hiuni';
  bool isSwitched = false;
  int _selectedIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions = [
    Home(),
    Profile(),
    Settings(),
  ];
  Widget homeAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: black),
      backgroundColor: white,
      title: Text(sharePrefereceInstance.getName(),
          style: customizeTextStyle(FontWeight.normal, 17.0, black)),
      actions: [
        Row(
          children: [
            isSwitched
                ? Text(
                    'Active',
                    style: TextStyle(color: black),
                  )
                : Text(
                    'Deactive',
                    style: TextStyle(color: black),
                  ),
            Switch(
              value: isSwitched,
              onChanged: (val) {
                setState(() {
                  isSwitched = val;
                  print(isSwitched);
                });
              },
              activeTrackColor: Colors.blue[200],
              activeColor: Colors.green,
            ),
          ],
        )
      ],
    );
  }

////////////2nd page
  Widget ProfileAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: primaryColor,
      //iconTheme: IconThemeData(color: white),
      title: Text("My Account"),
    );
  }

  ///////3rd page
  Widget settingsAppbar() {
    return AppBar(
      backgroundColor: primaryColor,
      title: Text('Settings', style: TextStyle(color: white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _selectedIndex == 0
          ? homeAppBar()
          : _selectedIndex == 1
              ? ProfileAppBar()
              : settingsAppbar(),
      drawer: Drawer(
        child: Container(
          //width: 0.3.sw,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.3.sh,
                  child: Stack(
                    children: [
                      DrawerCustomPaint(),
                      //  DrawerCustomPaint(),
                      Positioned(
                        top: 0.05.sh,
                        left: 0.04.sw,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                //     Get.to(MyProfile());
                              },
                              child: CircleAvatar(
                                backgroundColor: white,
                                radius: 0.12.sw,
                                child: CircleAvatar(
                                  radius: 0.10.sw,
                                  backgroundImage: NetworkImage(
                                      // 'https://www.fbi.gov/wanted/seeking-info/john-doe/@@images/image/preview'
                                      sharePrefereceInstance.getImage()),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 0.02.sw,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 0.02.sw,
                                ),
                                Text(
                                  sharePrefereceInstance.getName(),
                                  textAlign: TextAlign.justify,
                                  style: customizeTextStyle(
                                      FontWeight.normal, 0.05.sw, white),
                                ),
                                SizedBox(
                                  height: 0.01.sh,
                                ),
                                SizedBox(
                                  width: 0.5.sw,
                                  child: Text(
                                    sharePrefereceInstance.getEmail(),
                                    overflow: TextOverflow.clip,
                                    style: customizeTextStyle(FontWeight.normal,
                                        0.04.sw, Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // SigninSignUpWidget().getHeightSizedBox(0.09.sh),
                createDrawerBodyItem(
                  onTap: () => Get.to(() => History()),
                  icon: Icons.history_edu_outlined,
                  text: 'My Orders',
                ),
                createDrawerBodyItem(
                  onTap: () => Get.to(() => Payment()),
                  icon: Icons.book_outlined,
                  text: 'Payment',
                ),
                createDrawerBodyItem(
                  onTap: () => Get.to(() => ReferAdEarn()),
                  icon: Icons.padding,
                  text: 'Refer& earn',
                ),
                createDrawerBodyItem(
                  onTap: () => Get.to(() => Review()),
                  icon: Icons.dynamic_feed,
                  text: 'Review',
                ),
                createDrawerBodyItem(
                  onTap: () => Get.to(() => Help()),
                  icon: Icons.assessment_outlined,
                  text: 'Help',
                ),
                createDrawerBodyItem(
                  onTap: () => Get.to(() => ABOUT()),
                  icon: Icons.help_outline_rounded,
                  text: 'About Us',
                ),
                createDrawerBodyItem(
                  onTap: () async {
                    showProgress(context);
                    bool result = await networkCall.logOut();
                    hideProgress(context);
                    if (result) {
                      sharePrefereceInstance.clear();
                      Get.offAll(() => Login());
                    }
                  },
                  icon: Icons.exit_to_app_outlined,
                  text: 'Logout',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: black,
        onTap: _onItemTapped,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
          Expanded(
            child: Text(
              text,
              style: customizeTextStyle(
                mediumTextWeight,
                16.0,
                Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 0.23.sw,
          ),
          Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
      onTap: onTap,
    );
  }
}
