import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/utils/controlled_state.dart";
import "package:aplikacja_explore/src/common/widgets/app_button.dart";
import "package:aplikacja_explore/src/common/widgets/edge_padding.dart";
import "package:aplikacja_explore/src/common/widgets/h_space.dart";
import "package:aplikacja_explore/src/common/widgets/sheet_app_bar.dart";
import "package:aplikacja_explore/src/common/widgets/v_space.dart";
import "package:aplikacja_explore/src/presentation/events/list/sheets/filters_controller.dart";
import "package:aplikacja_explore/src/presentation/events/list/sheets/widgets/filters_list_tile.dart";
import "package:flutter/material.dart";

class FiltersSheet extends StatefulWidget {
  const FiltersSheet({super.key});

  static void open(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      barrierColor: const Color(0xFFDCDCDC),
      backgroundColor: const Color(0xFFFAF9F9),
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (_) => const FiltersSheet(),
    );
  }

  @override
  State<FiltersSheet> createState() => _FiltersSheetState();
}

class _FiltersSheetState extends ControlledState<FiltersSheet> {
  @override
  final FiltersController controller = inject<FiltersController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: SingleChildScrollView(
          child: EdgePadding(
            left: 17,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VSpace(27),
                const SheetAppBar(
                  showCloseButton: true,
                  title: "Filtry",
                ),
                const VSpace(24),
                FiltersListTile(
                  title: "Kultura",
                  children: [
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Sztuki wizualne",
                      isSubtile: true,
                    ),
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Muzyka",
                      isSubtile: true,
                    ),
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Muzeum",
                      isSubtile: true,
                    ),
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Teatr",
                      isSubtile: true,
                    ),
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Kino",
                      isSubtile: true,
                    ),
                  ],
                ),
                Divider(
                  height: 1,
                  color: const Color(0xFF4D4C4C).withOpacity(0.07),
                ),
                const FiltersListTile(
                  title: "Oświata",
                ),
                Divider(
                  height: 1,
                  color: const Color(0xFF4D4C4C).withOpacity(0.07),
                ),
                const FiltersListTile(
                  title: "Ochrona zdrowia",
                ),
                Divider(
                  height: 1,
                  color: const Color(0xFF4D4C4C).withOpacity(0.07),
                ),
                const FiltersListTile(
                  title: "Sport",
                ),
                Divider(
                  height: 1,
                  color: const Color(0xFF4D4C4C).withOpacity(0.07),
                ),
                const FiltersListTile(
                  title: "Turystyka",
                ),
                Divider(
                  height: 1,
                  color: const Color(0xFF4D4C4C).withOpacity(0.07),
                ),
                const FiltersListTile(
                  title: "Gospodarka",
                ),
                Divider(
                  height: 1,
                  color: const Color(0xFF4D4C4C).withOpacity(0.07),
                ),
                const FiltersListTile(
                  title: "Ekologia",
                ),
                Divider(
                  height: 1,
                  color: const Color(0xFF4D4C4C).withOpacity(0.07),
                ),
                const FiltersListTile(
                  title: "Fundusze Europejskie",
                ),
                Divider(
                  height: 1,
                  color: const Color(0xFF0066B1).withOpacity(0.4),
                ),
                FiltersListTile(
                  title: "Rodzaj wydarzenia",
                  children: [
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Warsztaty",
                      isSubtile: true,
                    ),
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Targi",
                      isSubtile: true,
                    ),
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Pikniki",
                      isSubtile: true,
                    ),
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Kongresy",
                      isSubtile: true,
                    ),
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Koncery",
                      isSubtile: true,
                    ),
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Spektakle",
                      isSubtile: true,
                    ),
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Wystawy",
                      isSubtile: true,
                    ),
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Konferencje",
                      isSubtile: true,
                    ),
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Rajdy",
                      isSubtile: true,
                    ),
                  ],
                ),
                Divider(
                  height: 1,
                  color: const Color(0xFF0066B1).withOpacity(0.4),
                ),
                FiltersListTile(
                  title: "Według wieku",
                  children: [
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Dla dzieci",
                      isSubtile: true,
                    ),
                    Divider(
                      height: 1,
                      color: const Color(0xFF4D4C4C).withOpacity(0.07),
                    ),
                    const FiltersListTile(
                      title: "Dla Seniora",
                      isSubtile: true,
                    ),
                  ],
                ),
                Divider(
                  height: 1,
                  color: const Color(0xFF0066B1).withOpacity(0.4),
                ),
                const VSpace(45),
                Text(
                  "Szukaj w odległości od swojej lokalizacji",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF3C3C3B).withOpacity(0.7),
                    fontSize: 12,
                    height: 20 / 12,
                  ),
                ),
                const VSpace(8),
                Divider(
                  height: 1,
                  color: const Color(0xFF4D4C4C).withOpacity(0.07),
                ),
                const VSpace(38),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${controller.minDistance}km",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF3C3C3B).withOpacity(0.7),
                        fontSize: 12,
                        height: 20 / 12,
                      ),
                    ),
                    Text(
                      "${controller.maxDistance}km",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF3C3C3B).withOpacity(0.7),
                        fontSize: 12,
                        height: 20 / 12,
                      ),
                    ),
                  ],
                ),
                const VSpace(4),
                ValueListenableBuilder(
                  valueListenable: controller.distance,
                  builder: (context, distance, _) => Slider(
                    value: distance,
                    onChanged: (distance) => controller.distance.value = distance,
                    min: controller.minDistance,
                    max: controller.maxDistance,
                    divisions: controller.distanceSteps,
                    label: "${distance.round()}km",
                  ),
                ),
                const VSpace(73),
                Divider(
                  height: 1,
                  color: const Color(0xFF4D4C4C).withOpacity(0.07),
                ),
                const VSpace(56),
                const Row(
                  children: [
                    AppButton.transparent(text: "Wyczyść"),
                    Spacer(),
                    AppButton.primary(text: "Pokaż wyniki (24)"),
                    HSpace(20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
