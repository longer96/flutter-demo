import 'dart:math' as math;
import 'package:flutter/material.dart';

class MenuClipper extends CustomClipper<Path> {
  MenuClipper({this.radius = 38.0});

  final double radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();

    final double v = radius * 2;
    path.lineTo(0, 0);
    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180),
        degreeToRadians(90), false);

    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(90), false);

    /// 右下圆角
    path.arcTo(
        Rect.fromLTWH(
            size.width - radius, size.height - radius, radius, radius),
        0,
        degreeToRadians(90),
        false);

    path.arcTo(
        Rect.fromLTWH(
          (size.width - ((size.width / 2) - v / 2)) - v * 0.3,
          size.height,
          radius,
          radius,
        ),
        degreeToRadians(270),
        // degreeToRadians(-60),
        degreeToRadians(-50),
        false);

    /// 凹陷 箭头
    // path.arcTo(Rect.fromLTWH((size.width / 2) - 4, 4 + size.height, 8, 8),
    //     degreeToRadians(20), degreeToRadians(140), false);

    path.lineTo(size.width / 2, size.height + 12);
    path.lineTo((size.width / 2) - 6, size.height + 6);

    path.arcTo(
        Rect.fromLTWH(
          ((size.width / 2) - v / 2) - radius + v * 0.3,
          size.height,
          radius,
          radius,
        ),
        degreeToRadians(320),
        degreeToRadians(-60),
        false);

    /// 左下圆角
    path.arcTo(Rect.fromLTWH(0, size.height - radius, radius, radius),
        degreeToRadians(90), degreeToRadians(90), false);

    // path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(MenuClipper oldClipper) => false;

  double degreeToRadians(double degree) {
    final double redian = (math.pi / 180) * degree;
    return redian;
  }
}
