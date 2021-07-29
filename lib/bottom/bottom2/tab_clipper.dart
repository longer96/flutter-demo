import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 首页底部导航裁剪
class TabClipper extends CustomClipper<Path> {
  TabClipper({
    required this.position,
    this.radius = 26.0,
    this.padding = const EdgeInsets.only(left: 0, right: 0),
  });

  final double radius;
  final EdgeInsets padding;

  /// 一格的width
  late double oneWidth;
  double position;
  int iconNum = 4;

  @override
  Path getClip(Size size) {
    position = position + 1.0;
    oneWidth = (size.width - padding.horizontal) / iconNum;
    final Path path = Path();

    final double v = radius * 2;
    path.lineTo(0, 0);

    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180),
        degreeToRadians(90), false);

    /// left
    path.arcTo(
        Rect.fromLTWH(
            (oneWidth * position - (oneWidth / 2) - v / 2) -
                radius +
                v * 0.12 +
                padding.left,
            -radius,
            radius,
            radius),
        degreeToRadians(90),
        degreeToRadians(-70),
        false);

    /// 半圆
    path.arcTo(
        Rect.fromLTWH(
            oneWidth * position - (oneWidth / 2) - v / 2 + padding.left,
            -v / 3,
            v,
            v),
        degreeToRadians(200),
        degreeToRadians(140),
        false);

    /// right
    path.arcTo(
        Rect.fromLTWH(
            oneWidth * position -
                (oneWidth / 2) +
                v / 2 -
                v * 0.12 +
                padding.left,
            -radius,
            radius,
            radius),
        degreeToRadians(160),
        degreeToRadians(-70),
        false);

    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(90), false);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TabClipper oldClipper) =>
      this.position != oldClipper.position;

  double degreeToRadians(double degree) {
    final double redian = (math.pi / 180) * degree;
    return redian;
  }
}
