import "package:aplikacja_explore/src/common/consts/app_grid.dart";
import "package:flutter/widgets.dart";

class VSpace extends SizedBox {
  const VSpace(double space, {super.key}) : super(height: space);

  const VSpace.gutter({Key? key}) : this(AppGrid.gutter, key: key);
}
