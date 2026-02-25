import 'package:flutter/material.dart';

enum MainScreenTab {
  home,
  pointTrack,
  membership,
  setting
  ;

  IconData icon(BuildContext context) {
    switch (this) {
      case MainScreenTab.home:
        return Icons.home_outlined;
      case MainScreenTab.pointTrack:
        return Icons.stars_outlined;
      case MainScreenTab.membership:
        return Icons.card_membership_outlined;
      case MainScreenTab.setting:
        return Icons.settings_outlined;
    }
  }

  IconData iconSelected(BuildContext context) {
    switch (this) {
      case MainScreenTab.home:
        return Icons.home_rounded;
      case MainScreenTab.pointTrack:
        return Icons.stars_rounded;
      case MainScreenTab.membership:
        return Icons.card_membership_rounded;
      case MainScreenTab.setting:
        return Icons.settings_rounded;
    }
  }
}
