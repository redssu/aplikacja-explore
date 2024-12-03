import "package:aplikacja_explore/src/common/widgets/edge_padding.dart";
import "package:aplikacja_explore/src/common/widgets/sheet_app_bar.dart";
import "package:aplikacja_explore/src/common/widgets/v_space.dart";
import "package:flutter/material.dart";

class SheetLayout extends StatelessWidget {
  const SheetLayout({
    required this.child,
    this.title = "",
    this.edgePadding,
    this.onPop,
    super.key,
  });

  final Widget child;
  final String title;
  final EdgeInsets? edgePadding;
  final VoidCallback? onPop;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          children: [
            const VSpace(27),
            EdgePadding(
              left: edgePadding?.left ?? 16,
              right: edgePadding?.right ?? 16,
              child: SheetAppBar(
                onPop: onPop ?? () => Navigator.pop(context),
                showCloseButton: true,
                title: title,
              ),
            ),
            const VSpace(24),
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: child,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
