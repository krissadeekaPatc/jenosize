import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_template/ui/screens/point_track/cubit/point_track_screen_cubit.dart';
import 'package:app_template/ui/screens/point_track/cubit/point_track_screen_state.dart';

class PointTrackScreenView extends StatefulWidget {
  const PointTrackScreenView({super.key});

  @override
  State<PointTrackScreenView> createState() => _PointTrackScreenViewState();
}

class _PointTrackScreenViewState extends State<PointTrackScreenView> {
  late final PointTrackScreenCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<PointTrackScreenCubit>();
  }

  void _listener(BuildContext context, PointTrackScreenState state) {
    switch (state.status) {
      case PointTrackScreenStatus.initial:
      case PointTrackScreenStatus.loading:
      case PointTrackScreenStatus.ready:
        break;

      case PointTrackScreenStatus.failure:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PointTrackScreenCubit, PointTrackScreenState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _listener,
      child: _buildScaffold(),
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Point Track'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Point Track'),
      ),
    );
  }
}
