import "package:aplikacja_explore/src/common/consts/app_styles.dart";
import "package:flutter/material.dart";

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    required this.value,
    required this.onChanged,
    this.size = 17,
    super.key,
  });

  final bool value;
  final void Function(bool?) onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      checked: value,
      button: true,
      onTap: () => onChanged(!value),
      label: "Pole typu \"Checkbox\"",
      child: GestureDetector(
        onTap: () => onChanged(!value),
        child: SizedBox(
          width: size,
          height: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: const Color(0x1D3C3C3B),
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: value
                  ? DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppStyles.primaryColor,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
