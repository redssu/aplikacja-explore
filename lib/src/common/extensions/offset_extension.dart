import "dart:ui";

extension OffsetExtension on Offset {
  Size asSize() => Size(dx, dy);
}
