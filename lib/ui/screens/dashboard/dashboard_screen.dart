import 'package:app_template/ui/global_widgets/loading_overlay.dart';
import 'package:app_template/ui/screens/dashboard/cubit/dashboard_screen_cubit.dart';
import 'package:app_template/ui/screens/dashboard/cubit/dashboard_screen_state.dart';
import 'package:app_template/ui/screens/dashboard/dashboard_screen_tab.dart';
import 'package:app_template/ui/screens/home/cubit/home_screen_cubit.dart';
import 'package:app_template/ui/screens/home/home_screen.dart';
import 'package:app_template/ui/screens/settings/cubit/settings_screen_cubit.dart';
import 'package:app_template/ui/screens/settings/settings_screen.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DashboardScreenCubit()),
        BlocProvider(create: (context) => HomeScreenCubit()),
        BlocProvider(create: (context) => SettingsScreenCubit()),
      ],
      child: const DashboardScreenView(),
    );
  }
}

class DashboardScreenView extends StatefulWidget {
  const DashboardScreenView({super.key});

  @override
  State<DashboardScreenView> createState() => _DashboardScreenViewState();
}

class _DashboardScreenViewState extends State<DashboardScreenView> {
  late final DashboardScreenCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<DashboardScreenCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = [
      context.select<HomeScreenCubit, bool>(
        (cubit) => cubit.state.status.isLoading,
      ),
      context.select<SettingsScreenCubit, bool>(
        (cubit) => cubit.state.status.isLoading,
      ),
    ].any((e) => e == true);

    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        body: _body(),
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }

  Widget _body() {
    return BlocSelector<
      DashboardScreenCubit,
      DashboardScreenState,
      DashboardScreenTab
    >(
      selector: (state) => state.selectedTab,
      builder: (context, selectedTab) {
        return IndexedStack(
          index: selectedTab.index,
          children: const [HomeScreenView(), SettingsScreenView()],
        );
      },
    );
  }

  Widget _bottomNavigationBar() {
    return BlocSelector<
      DashboardScreenCubit,
      DashboardScreenState,
      DashboardScreenTab
    >(
      selector: (state) => state.selectedTab,
      builder: (context, selectedTab) {
        return NavigationBar(
          onDestinationSelected: (index) {
            HapticFeedback.lightImpact();
            final newTab = DashboardScreenTab.values.firstWhereOrNull(
              (e) => e.index == index,
            );
            if (newTab != null) {
              _cubit.setSelectedTab(newTab);
            }
          },
          selectedIndex: selectedTab.index,
          destinations: DashboardScreenTab.values.map((e) {
            return NavigationDestination(
              icon: Icon(e.iconData),
              label: e.title(context),
            );
          }).toList(),
        );
      },
    );
  }
}
