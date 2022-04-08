import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DrawerCustomPaint extends StatefulWidget {
  @override
  _DrawerCustomPaintState createState() => _DrawerCustomPaintState();
}

class _DrawerCustomPaintState extends State<DrawerCustomPaint> {
  @override
  Widget build(BuildContext context) {
  
    return CustomPaint(
      size: Size(2.sw,
          0.25.sh), //You can Replace this with your desired WIDTH and HEIGHT
      painter: RPSCustomPainter(),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 1, 61, 87)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.quadraticBezierTo(size.width, size.height * 0.3755000, size.width,
        size.height * 0.5180000);
    path_0.cubicTo(
        size.width * 0.7850000,
        size.height * 0.6225000,
        size.width * 0.3390625,
        size.height * 0.9265000,
        size.width * 0.1400000,
        size.height * 0.9880000);
    path_0.cubicTo(
        size.width * 0.0484375,
        size.height * 1.0055000,
        size.width * 0.0528125,
        size.height * 0.8080000,
        size.width * 0.0012500,
        size.height * 0.6140000);
    path_0.quadraticBezierTo(
        size.width * -0.0178125, size.height * 0.4945000, 0, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
