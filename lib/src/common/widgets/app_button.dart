import "package:aplikacja_explore/src/common/consts/app_styles.dart";
import "package:flutter/material.dart";

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    super.key,
  });

  const AppButton.primary({
    required this.text,
    this.onTap,
    super.key,
  })  : backgroundColor = AppStyles.primaryColor,
        textColor = const Color(0xFFFFFFFF);

  const AppButton.transparent({
    required this.text,
    this.onTap,
    super.key,
  })  : backgroundColor = Colors.transparent,
        textColor = AppStyles.primaryColor;

  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: text,
      button: true,
      onTap: onTap,
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 11,
              bottom: 10,
              left: 21,
              right: 21,
            ),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                height: 20 / 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
