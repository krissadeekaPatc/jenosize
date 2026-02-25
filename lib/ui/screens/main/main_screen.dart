import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenosize/app/initializers/dependencies_initializer.dart';
import 'package:jenosize/ui/global_widgets/loading_overlay.dart';
import 'package:jenosize/ui/screens/home/cubit/home_screen_cubit.dart';
import 'package:jenosize/ui/screens/home/home_screen.dart';
import 'package:jenosize/ui/screens/main/cubit/main_screen_cubit.dart';
import 'package:jenosize/ui/screens/main/cubit/main_screen_state.dart';
import 'package:jenosize/ui/screens/main/main_screen_tab.dart';
import 'package:jenosize/ui/screens/membership/cubit/membership_screen_cubit.dart';
import 'package:jenosize/ui/screens/membership/membership_screen.dart';
import 'package:jenosize/ui/screens/point_track/cubit/point_track_screen_cubit.dart';
import 'package:jenosize/ui/screens/point_track/point_track_screen.dart';
import 'package:jenosize/ui/screens/settings/cubit/settings_screen_cubit.dart';
import 'package:jenosize/ui/screens/settings/settings_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MainScreenCubit(),
        ),
        BlocProvider(
          create: (_) => HomeScreenCubit(
            campaignRepository: getIt(),
            sessionCubit: getIt(),
          ),
        ),
        BlocProvider(
          create: (_) => PointTrackScreenCubit(
            getPointTransactionsUseCase: getIt(),
          ),
        ),
        BlocProvider(
          create: (_) => MembershipScreenCubit(
            sessionCubit: getIt(),
            pointRepository: getIt(),
          ),
        ),
        BlocProvider(
          create: (_) => SettingsScreenCubit(
            sessionCubit: getIt(),
            tokenVault: getIt(),
            appStorage: getIt(),
          ),
        ),
      ],
      child: const MainScreenView(),
    );
  }
}

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = [
      context.select<HomeScreenCubit, bool>(
        (c) => c.state.status.isLoading,
      ),
      context.select<PointTrackScreenCubit, bool>(
        (c) => c.state.status.isLoading,
      ),
      context.select<MembershipScreenCubit, bool>(
        (c) => c.state.status.isLoading,
      ),
      context.select<SettingsScreenCubit, bool>(
        (c) => c.state.status.isLoading,
      ),
    ].any((e) => e == true);

    return BlocSelector<MainScreenCubit, MainScreenState, MainScreenTab>(
      selector: (state) => state.selectedTab,
      builder: (context, selectedTab) {
        return LoadingOverlay(
          isLoading: isLoading,
          child: Scaffold(
            extendBody: true,
            body: IndexedStack(
              index: selectedTab.index,
              children: const [
                HomeScreenView(),
                PointTrackScreenView(),
                MembershipScreenView(),
                SettingsScreenView(),
              ],
            ),
            bottomNavigationBar: _CustomBottomNavBar(
              selectedTab: selectedTab,
              onTabSelected: (index) {
                context.read<MainScreenCubit>().changeTab(
                  MainScreenTab.values[index],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  final MainScreenTab selectedTab;
  final ValueChanged<int> onTabSelected;

  const _CustomBottomNavBar({
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xff3f4354),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(MainScreenTab.values.length, (index) {
            final tab = MainScreenTab.values[index];
            final isSelected = selectedTab == tab;

            return GestureDetector(
              onTap: () => onTabSelected(index),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 3,
                    width: 16,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xff6e95ff)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    isSelected ? tab.iconSelected(context) : tab.icon(context),
                    color: isSelected ? Colors.white : Colors.white60,
                    size: 26,
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
