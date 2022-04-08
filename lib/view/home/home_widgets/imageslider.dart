import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var _images = [
  'assets/slider-image-2.jpg',
  'assets/slider-image-1.jpg',
  'assets/slider-image-2.jpg',
];

Widget imageSlider() {
  return SizedBox(
    width: 1.sw,
    height: 0.35.sh,
    child: Swiper(
      itemCount: _images.length,
      duration: 2000,
      itemBuilder: (BuildContext context, int index) => Image.asset(
        _images[index],
        fit: BoxFit.fill,
      ),
      autoplay: true,
    ),
  );
}
/*
*
* */
