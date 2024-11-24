import "package:aplikacja_explore/src/common/consts/app_grid.dart";
import "package:flutter/material.dart";

class EdgePadding extends StatelessWidget {
  const EdgePadding({
    required this.child,
    required this.left,
    required this.right,
    super.key,
  });

  const EdgePadding.gridDefined({
    required this.child,
    bool left = true,
    bool right = true,
    super.key,
  })  : left = left ? AppGrid.margin : 0,
        right = right ? AppGrid.margin : 0;

  final double left;
  final double right;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
      ),
      child: child,
    );
  }
}
