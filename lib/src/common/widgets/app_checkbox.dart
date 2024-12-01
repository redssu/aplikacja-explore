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
    return GestureDetector(
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
                      color: const Color(0xFF0066B1),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
