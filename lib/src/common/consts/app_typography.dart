import "package:flutter/material.dart";

class AppTypography {
  /**
   * MARK: Common
   */
  ///
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.bold,
    fontSize: 22,
    height: 20 / 22,
  );

  static const TextStyle bottomBarItemLabel = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w500,
  );

  /**
   * MARK: Event Card
   */
  ///
  static const TextStyle eventCardTitle = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.bold,
    fontSize: 17,
    height: 21 / 17,
  );

  static const TextStyle eventCardAddress = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
  );

  static const TextStyle eventCardDate = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 20 / 12,
  );
}
