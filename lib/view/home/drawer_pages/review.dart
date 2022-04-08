import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:speedx_driver_122283/utils/const.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("Reviews(240)", style: TextStyle(fontSize: 18)),
          actions: [
            Row(
              children: [
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 0.05.sw,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(
                  width: 0.01.sw,
                ),
                Text("3.8 / 5.0"),
                SizedBox(
                  width: 0.02.sw,
                )
              ],
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: 12, right: 12, top: 10),
          child: Column(
            children: [
              SizedBox(
                height: 0.01.sh,
              ),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    height: 0.11.sh,
                    width: 1.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 0.01.sh,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 0.02.sw,
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://www.fbi.gov/wanted/seeking-info/john-doe/@@images/image/preview'),
                            ),
                            SizedBox(
                              width: 0.05.sw,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cecilia Craft",
                                  style: customizeTextStyle(
                                      FontWeight.normal, fontSizeTwenty, black),
                                ),
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 0.05.sw,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    SizedBox(
                                      width: 0.02.sw,
                                    ),
                                    Text(
                                      "16/01/2020",
                                      style: customizeTextStyle(
                                          FontWeight.normal,
                                          fontSizeFifteen,
                                          black),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 0.01.sh,
                        ),
                        Text(
                          "Dolor sit amet Consectetur",
                          style: customizeTextStyle(
                              FontWeight.normal, 15.0, black),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
