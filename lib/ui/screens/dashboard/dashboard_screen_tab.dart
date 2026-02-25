import 'package:app_template/ui/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

enum DashboardScreenTab {
  home,
  settings;

  IconData get iconData {
    switch (this) {
      case DashboardScreenTab.home:
        return Icons.home;
      case DashboardScreenTab.settings:
        return Icons.settings;
    }
  }

  String title(BuildContext context) {
    switch (this) {
      case DashboardScreenTab.home:
        return context.l10n.dashboard_screen_tab_home;
      case DashboardScreenTab.settings:
        return context.l10n.dashboard_screen_tab_settings;
    }
  }
}
