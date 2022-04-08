import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:speedx_driver_122283/utils/sharedPref.dart';
import 'package:speedx_driver_122283/view/login/login.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ///top_image----------------------------------------------------------
            Image.asset(
              logoImg,
              height: 0.1.sh,
              width: 0.5.sw,
            ),

            ///texts---------------------------------------------------------
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Fastro',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                  Text('Delivery',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text('Moving Made Simple',
                      style: TextStyle(
                        color: red,
                        fontSize: 12,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Delivery to your adddress',
                      style: TextStyle(
                        color: blue,
                        fontSize: 30,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Our courier will get adjusted your',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  Text('customers schedule. As a result-everyone ',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  Text('is pleased', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),

            SizedBox(
              height: 0.1.sh,
            ),

            ///top_image----------------------------------------------------------
            Expanded(
              child: Image.asset(
                bgAssetImg,
              ),
            ),

            SizedBox(
              height: 0.03.sh,
            ),

            ///getStarted text-------------------------------------------
            if (!sharePrefereceInstance.getIsLogin())
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: SizedBox(
                  width: 1.sw,
                  height: 0.06.sh,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                       shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    ),
                   
                    onPressed: () {
                      Get.off(() => Login());
                    },
                    child: Text('Get Started',
                        style: TextStyle(color: white, fontSize: 20)),
                    
                  ),
                ),
              ),
            SizedBox(
              height: 0.01.sh,
            ),
          ],
        ),
      ),
    );
  }
}
