import "package:flutter/material.dart";

class AppStyles {
  /**
   * MARK: Common
   */
  ///
  static const InputDecoration searchBar = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(35)),
      borderSide: BorderSide(color: Color(0xFF4D4C4C)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(35)),
      borderSide: BorderSide(color: Color(0xFF4D4C4C)),
    ),
  );
}
