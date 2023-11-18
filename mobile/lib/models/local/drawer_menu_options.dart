import 'package:pasha_insurance/constants/strings/assets.dart';

class DrawerMenuOptions {
  DrawerMenuOptions._();

  static final List<DrawerMenuOption> menuOptions = [
    DrawerMenuOption(title: "Settings", iconPath: Assets.settingsIcon),
  ];
}

class DrawerMenuOption {
  final String title;
  final String iconPath;

  DrawerMenuOption({required this.title, required this.iconPath});
}