import "package:aplikacja_explore/src/common/consts/app_grid.dart";
import "package:flutter/widgets.dart";

class HSpace extends SizedBox {
  const HSpace(double space, {super.key}) : super(width: space);

  const HSpace.gutter({Key? key}) : this(AppGrid.gutter, key: key);
}
