import "dart:math";
import "dart:ui";

import "package:flutter/material.dart";

// Skopiowane i zmodyfikowane z [DropSliderValueIndicatorShape]

class AppValueIndicatorSliderShape extends SliderComponentShape {
  const AppValueIndicatorSliderShape();

  static const _AppValueIndicatorPathPainter _pathPainter = _AppValueIndicatorPathPainter();

  @override
  Size getPreferredSize(
    bool isEnabled,
    bool isDiscrete, {
    TextPainter? labelPainter,
    double? textScaleFactor,
  }) {
    assert(labelPainter != null);
    assert(textScaleFactor != null && textScaleFactor >= 0);
    return _pathPainter.getPreferredSize(labelPainter!, textScaleFactor!);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final double scale = activationAnimation.value;
    _pathPainter.paint(
      parentBox: parentBox,
      canvas: canvas,
      center: center,
      scale: scale,
      labelPainter: labelPainter,
      textScaleFactor: textScaleFactor,
      sizeWithOverflow: sizeWithOverflow,
      backgroundPaintColor: sliderTheme.valueIndicatorColor!,
      strokePaintColor: sliderTheme.valueIndicatorStrokeColor,
    );
  }
}

class _AppValueIndicatorPathPainter {
  const _AppValueIndicatorPathPainter();

  static const double _triangleHeight = 5.0;
  static const double _triangleWidth = 6.5;
  static const EdgeInsets _labelPadding = EdgeInsets.only(left: 21, right: 21, top: 5, bottom: 6);
  static const double _preferredHeight = 32.0;
  static const double _minLabelWidth = 20.0;
  static const double _minRectHeight = 20.0;
  static const double _rectYOffset = _triangleHeight;
  static const double _bottomTipYOffset = 16.0;
  static const double _upperRectRadius = 4;

  Size getPreferredSize(
    TextPainter labelPainter,
    double textScaleFactor,
  ) {
    final double width = max(_minLabelWidth, labelPainter.width) + _labelPadding.horizontal * textScaleFactor;
    return Size(width, _preferredHeight * textScaleFactor);
  }

  double getHorizontalShift({
    required RenderBox parentBox,
    required Offset center,
    required TextPainter labelPainter,
    required double textScaleFactor,
    required Size sizeWithOverflow,
    required double scale,
  }) {
    assert(!sizeWithOverflow.isEmpty);

    const double edgePadding = 8.0;
    final Size rectangleSize = _lowerRectangleUnscaledSize(labelPainter) * scale;
    final Offset globalCenter = parentBox.localToGlobal(center);

    final double overflowLeft = max(0, rectangleSize.width / 2 - globalCenter.dx + edgePadding);
    final double overflowRight =
        max(0, rectangleSize.width / 2 - (sizeWithOverflow.width - globalCenter.dx - edgePadding));

    if (rectangleSize.width < sizeWithOverflow.width) {
      return overflowLeft - overflowRight;
    } else if (overflowLeft - overflowRight > 0) {
      return overflowLeft - (edgePadding * textScaleFactor);
    } else {
      return -overflowRight + (edgePadding * textScaleFactor);
    }
  }

  Size _lowerRectangleUnscaledSize(TextPainter labelPainter) {
    return Size(
      max(_minLabelWidth, labelPainter.width) + _labelPadding.horizontal,
      max(_minRectHeight, labelPainter.height) + _labelPadding.vertical,
    );
  }

  BorderRadius _adjustBorderRadius(Rect rect) {
    const double rectness = 0.0;
    return BorderRadius.lerp(
      BorderRadius.circular(_upperRectRadius),
      BorderRadius.all(Radius.circular(rect.shortestSide / 2.0)),
      1.0 - rectness,
    )!;
  }

  void paint({
    required RenderBox parentBox,
    required Canvas canvas,
    required Offset center,
    required double scale,
    required TextPainter labelPainter,
    required double textScaleFactor,
    required Size sizeWithOverflow,
    required Color backgroundPaintColor,
    Color? strokePaintColor,
  }) {
    if (scale == 0.0) {
      return;
    }

    assert(!sizeWithOverflow.isEmpty);

    final Size rectangleUnscaledSize = _lowerRectangleUnscaledSize(labelPainter);
    final Size rectangleSize = rectangleUnscaledSize * scale;
    final double horizontalShift = getHorizontalShift(
      parentBox: parentBox,
      center: center,
      labelPainter: labelPainter,
      textScaleFactor: textScaleFactor,
      sizeWithOverflow: sizeWithOverflow,
      scale: scale,
    );
    final Rect lowerRect = Rect.fromLTWH(
      -rectangleSize.width / 2 + horizontalShift,
      _rectYOffset,
      rectangleSize.width,
      rectangleSize.height,
    );

    final Paint fillPaint = Paint()..color = backgroundPaintColor;

    canvas.save();
    canvas.translate(center.dx, center.dy + _bottomTipYOffset);
    canvas.scale(scale, scale);

    final BorderRadius adjustedBorderRadius = _adjustBorderRadius(lowerRect);
    final RRect borderRect = adjustedBorderRadius.resolve(labelPainter.textDirection).toRRect(lowerRect);
    final Path trianglePath = Path()
      ..lineTo(-(_triangleWidth / 2), _triangleHeight)
      ..lineTo(0, 0)
      ..lineTo(_triangleWidth / 2, _triangleHeight)
      ..lineTo(-(_triangleWidth / 2), _triangleHeight)
      ..close();

    trianglePath.addRRect(borderRect);

    if (strokePaintColor != null) {
      final Paint strokePaint = Paint()
        ..color = strokePaintColor
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawPath(trianglePath, strokePaint);
    }

    canvas.drawPath(trianglePath, fillPaint);

    // The label text is centered within the value indicator.
    const double bottomTipToLowerRectTranslateY = _triangleHeight;
    canvas.translate(0, bottomTipToLowerRectTranslateY);

    final Offset boxCenter = Offset(horizontalShift, lowerRect.height / 2);
    final Offset halfLabelPainterOffset = Offset(labelPainter.width / 2, labelPainter.height / 2);
    final Offset labelOffset = boxCenter - halfLabelPainterOffset;
    labelPainter.paint(canvas, labelOffset);
    canvas.restore();
  }
}
