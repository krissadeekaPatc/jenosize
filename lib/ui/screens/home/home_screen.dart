import 'package:app_template/app/router/app_routes.dart';
import 'package:app_template/ui/screens/home/cubit/home_screen_cubit.dart';
import 'package:app_template/ui/screens/home/cubit/home_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  void _listener(BuildContext context, HomeScreenState state) {
    switch (state.status) {
      case HomeScreenStatus.initial:
      case HomeScreenStatus.loading:
      case HomeScreenStatus.ready:
        break;

      case HomeScreenStatus.failure:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreenCubit, HomeScreenState>(
      listener: _listener,
      child: Scaffold(
        appBar: AppBar(title: const Text('Home'), centerTitle: true),
        body: Center(
          child: TextButton(
            onPressed: () {
              context.push(AppRoutes.bodyAge);
            },
            child: const Text('Click'),
          ),
        ),
      ),
    );
  }
}
