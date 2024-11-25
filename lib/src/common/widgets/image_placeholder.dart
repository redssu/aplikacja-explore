import "package:aplikacja_explore/src/common/widgets/v_space.dart";
import "package:flutter/material.dart";

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    this.width = 400,
    this.height = 400,
    this.showText = true,
    super.key,
  });

  static Widget Function(dynamic, dynamic, dynamic) errorBuilder({
    double width = 400,
    double height = 400,
    bool showText = true,
  }) {
    return (_, __, ___) => ImagePlaceholder(width: width, height: height, showText: showText);
  }

  final double width;
  final double height;
  final bool showText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ColoredBox(
        color: const Color(0xFFE1E1E1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                color: Colors.red,
              ),
              if (showText) ...[
                const VSpace(5),
                const Text(
                  "Błąd ładowania obrazu",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
