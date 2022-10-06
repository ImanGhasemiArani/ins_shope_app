import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef OnChange = void Function(int index);

class FNavBar extends StatelessWidget {
  const FNavBar({
    Key? key,
    required this.items,
    this.onChange,
    this.initItemIndex = 0,
  }) : super(key: key);

  final List<FNavBarItem> items;
  final OnChange? onChange;
  final int initItemIndex;

  @override
  Widget build(BuildContext context) {
    final itemController = List.generate(
      items.length,
      (index) => (index == initItemIndex).obs,
    );

    return Card(
      color: Get.theme.colorScheme.background,
      margin: EdgeInsets.zero,
      child: SizedBox(
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            items.length,
            (i) => Obx(
              () => CupertinoButton(
                onPressed: itemController[i].value
                    ? null
                    : () {
                        onChange?.call(i);
                        itemController
                            .forEach((element) => element.value = false);
                        itemController[i].value = true;
                      },
                child: FNavBarItem(
                  icon: items[i].icon,
                  selectedIcon: items[i].selectedIcon,
                  title: items[i].title,
                  isSelected: itemController[i].value,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FNavBarItem extends StatelessWidget {
  const FNavBarItem({
    super.key,
    this.selectedIcon,
    required this.icon,
    this.title,
    this.isSelected = false,
  });

  final Widget? selectedIcon;
  final Widget icon;
  final String? title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        isSelected ? selectedIcon ?? icon : icon,
        if (title != null) const SizedBox(height: 5),
        if (title != null) Text(title!),
      ],
    );
  }
}
