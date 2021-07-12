// Copyright 2020 The rhyme_lph Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
library r_dotted_line_border;

import 'dart:ui';
import 'package:flutter/material.dart';

/// https://github.com/rhymelph/r_dotted_line_border
/// 写的很好
/// 虚线边框
class RDottedLineBorder extends BoxBorder {
  final double dottedLength;
  final double dottedSpace;

  RDottedLineBorder({
    this.top = BorderSide.none,
    this.right = BorderSide.none,
    this.bottom = BorderSide.none,
    this.left = BorderSide.none,
    this.dottedLength = 5,
    this.dottedSpace = 3,
  });

  const RDottedLineBorder.fromBorderSide(
    BorderSide side, {
    this.dottedLength = 5,
    this.dottedSpace = 3,
  })  : top = side,
        right = side,
        bottom = side,
        left = side;

  const RDottedLineBorder.symmetric({
    BorderSide vertical = BorderSide.none,
    BorderSide horizontal = BorderSide.none,
    this.dottedLength = 5,
    this.dottedSpace = 3,
  })  : left = vertical,
        top = horizontal,
        right = vertical,
        bottom = horizontal;

  factory RDottedLineBorder.all({
    Color color = const Color(0xFF000000),
    double width = 1.0,
    double dottedLength = 5,
    double dottedSpace = 3,
  }) {
    final BorderSide side =
        BorderSide(color: color, width: width, style: BorderStyle.solid);
    return RDottedLineBorder.fromBorderSide(side,
        dottedLength: dottedLength, dottedSpace: dottedSpace);
  }

  static RDottedLineBorder merge(RDottedLineBorder a, RDottedLineBorder b) {
    assert(BorderSide.canMerge(a.top, b.top));
    assert(BorderSide.canMerge(a.right, b.right));
    assert(BorderSide.canMerge(a.bottom, b.bottom));
    assert(BorderSide.canMerge(a.left, b.left));
    return RDottedLineBorder(
      top: BorderSide.merge(a.top, b.top),
      right: BorderSide.merge(a.right, b.right),
      bottom: BorderSide.merge(a.bottom, b.bottom),
      left: BorderSide.merge(a.left, b.left),
      dottedSpace: a.dottedSpace + b.dottedSpace,
      dottedLength: a.dottedLength + b.dottedLength,
    );
  }

  @override
  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.fromLTRB(
        left.width, top.width, right.width, bottom.width);
  }

  bool get _colorIsUniform {
    final Color topColor = top.color;
    return right.color == topColor &&
        bottom.color == topColor &&
        left.color == topColor;
  }

  bool get _widthIsUniform {
    final double topWidth = top.width;
    return right.width == topWidth &&
        bottom.width == topWidth &&
        left.width == topWidth;
  }

  bool get _styleIsUniform {
    final BorderStyle topStyle = top.style;
    return right.style == topStyle &&
        bottom.style == topStyle &&
        left.style == topStyle;
  }

  @override
  bool get isUniform => _colorIsUniform && _widthIsUniform && _styleIsUniform;

  @override
  void paint(Canvas canvas, Rect rect,
      {TextDirection? textDirection,
      BoxShape shape = BoxShape.rectangle,
      BorderRadius? borderRadius}) {
    if (isUniform) {
      switch (top.style) {
        case BorderStyle.none:
          return;
        case BorderStyle.solid:
          switch (shape) {
            case BoxShape.circle:
              assert(borderRadius == null,
                  'A borderRadius can only be given for rectangular boxes.');
              final double width = top.width;
              final Paint paint = top.toPaint();
              // final double radius = (rect.shortestSide - width) / 2.0;
              Rect inner = rect.deflate(width);
              // canvas.drawCircle(rect.center, radius, paint);
              canvas.drawPath(
                  _buildDashPath(
                      Path()..addOval(inner), dottedLength, dottedSpace),
                  paint);
              break;
            case BoxShape.rectangle:
              if (borderRadius != null) {
                // BoxBorder._paintUniformBorderWithRadius(canvas, rect, top, borderRadius);
                final Paint paint = Paint()..color = top.color;
                final RRect outer = borderRadius.toRRect(rect);
                final double width = top.width;
                if (width == 0.0) {
                  paint
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 0.0;
                  // canvas.drawRRect(outer, paint);
                  // print('outer');
                  canvas.drawPath(
                      _buildDashPath(
                          Path()..addRRect(outer), dottedLength, dottedSpace),
                      paint);
                } else {
                  final RRect inner = outer.deflate(width);
                  // canvas.drawDRRect(outer, inner, paint);
                  // print('outer inner');
                  // canvas.drawPath(Path()..addRRect(inner), paint);
                  //
                  canvas.drawPath(
                      _buildDashPath(
                          Path()..addRRect(inner), dottedLength, dottedSpace),
                      paint
                        ..isAntiAlias = true
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = width);
                }
                return;
              }
              // BoxBorder._paintUniformBorderWithRectangle(canvas, rect, top);
              final double width = top.width;
              final Paint paint = top.toPaint();
              // canvas.drawRect(rect.deflate(width / 2.0), paint);
              // print('rect');
              canvas.drawPath(
                  _buildDashPath(Path()..addRect(rect.deflate(width / 2.0)),
                      dottedLength, dottedSpace),
                  paint);
              break;
          }
          return;
      }
    }

    assert(() {
      if (borderRadius != null) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
              'A borderRadius can only be given for a uniform Border.'),
          ErrorDescription('The following is not uniform:'),
          if (!_colorIsUniform) ErrorDescription('BorderSide.color'),
          if (!_widthIsUniform) ErrorDescription('BorderSide.width'),
          if (!_styleIsUniform) ErrorDescription('BorderSide.style'),
        ]);
      }
      return true;
    }());
    assert(() {
      if (shape != BoxShape.rectangle) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
              'A Border can only be drawn as a circle if it is uniform'),
          ErrorDescription('The following is not uniform:'),
          if (!_colorIsUniform) ErrorDescription('BorderSide.color'),
          if (!_widthIsUniform) ErrorDescription('BorderSide.width'),
          if (!_styleIsUniform) ErrorDescription('BorderSide.style'),
        ]);
      }
      return true;
    }());

    // print('paint border');

    paintDottedBorder(canvas, rect,
        top: top, right: right, bottom: bottom, left: left);
  }

  void paintDottedBorder(
    Canvas canvas,
    Rect rect, {
    BorderSide top = BorderSide.none,
    BorderSide right = BorderSide.none,
    BorderSide bottom = BorderSide.none,
    BorderSide left = BorderSide.none,
  }) {
    // We draw the borders as filled shapes, unless the borders are hairline
    // borders, in which case we use PaintingStyle.stroke, with the stroke width
    // specified here.
    final Paint paint = Paint()..strokeWidth = 0.0;

    final Path path = Path();

    switch (top.style) {
      case BorderStyle.solid:
        paint.color = top.color;
        path.reset();
        path.moveTo(rect.left, rect.top + top.width / 2);
        path.lineTo(rect.right, rect.top + top.width / 2);
        paint.style = PaintingStyle.stroke;

        canvas.drawPath(_buildDashPath(path, dottedLength, dottedSpace),
            paint..strokeWidth = top.width);
        break;
      case BorderStyle.none:
        break;
    }

    switch (right.style) {
      case BorderStyle.solid:
        paint.color = right.color;
        path.reset();
        path.moveTo(rect.right, rect.top);
        path.lineTo(rect.right, rect.bottom);
        paint.style = PaintingStyle.stroke;

        canvas.drawPath(_buildDashPath(path, dottedLength, dottedSpace),
            paint..strokeWidth = right.width);
        break;
      case BorderStyle.none:
        break;
    }

    switch (bottom.style) {
      case BorderStyle.solid:
        paint.color = bottom.color;
        path.reset();
        path.moveTo(rect.right, rect.bottom);
        path.lineTo(rect.left, rect.bottom);
        paint.style = PaintingStyle.stroke;
        canvas.drawPath(_buildDashPath(path, dottedLength, dottedSpace),
            paint..strokeWidth = bottom.width);
        break;
      case BorderStyle.none:
        break;
    }

    switch (left.style) {
      case BorderStyle.solid:
        paint.color = left.color;
        path.reset();
        path.moveTo(rect.left + left.width / 2, rect.bottom);
        path.lineTo(rect.left + left.width / 2, rect.top);
        paint.style = PaintingStyle.stroke;
        canvas.drawPath(_buildDashPath(path, dottedLength, dottedSpace),
            paint..strokeWidth = left.width);
        break;
      case BorderStyle.none:
        break;
    }
  }

  Path _buildDashPath(Path path, double dottedLength, double dottedSpace) {
    final Path r = Path();
    for (PathMetric metric in path.computeMetrics()) {
      double start = 0.0;
      while (start < metric.length) {
        double end = start + dottedLength;
        r.addPath(metric.extractPath(start, end), Offset.zero);
        start = end + dottedSpace;
      }
    }
    return r;
  }

  @override
  ShapeBorder scale(double t) {
    return RDottedLineBorder(
      top: top.scale(t),
      right: right.scale(t),
      bottom: bottom.scale(t),
      left: left.scale(t),
    );
  }

  @override
  BoxBorder? add(ShapeBorder other, {bool reversed = false}) {
    if (other is RDottedLineBorder &&
        BorderSide.canMerge(top, other.top) &&
        BorderSide.canMerge(right, other.right) &&
        BorderSide.canMerge(bottom, other.bottom) &&
        BorderSide.canMerge(left, other.left)) {
      return RDottedLineBorder.merge(this, other);
    }
    return null;
  }

  @override
  final BorderSide top;

  final BorderSide right;

  @override
  final BorderSide bottom;

  final BorderSide left;
}
