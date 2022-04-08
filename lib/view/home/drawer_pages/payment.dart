import 'package:flutter/material.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Payment"),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Container(
            height: 1.sh,
            width: 1.sw,
            padding: EdgeInsets.all(10),
            child: ListView.separated(
              separatorBuilder: (_, __) => SizedBox(
                height: 25,
              ),
              itemCount: 2,
              itemBuilder: (_, int index) {
                return Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('\$ 12,400',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Total price',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: grey,
                            radius: 30,
                            child: Icon(
                              Icons.account_balance_wallet,
                              color: blueGrey,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
