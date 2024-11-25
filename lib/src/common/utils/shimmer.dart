import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

class _ShimmerFill extends Shimmer {
  _ShimmerFill({required super.child})
      : super.fromColors(
          baseColor: const Color(0xFFB5B5B5),
          highlightColor: const Color(0xFFE5E5E5),
        );
}

extension SizedBoxShimmer on SizedBox {
  Widget shimmer() => _ShimmerFill(child: this);
}
