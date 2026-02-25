import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_template/ui/screens/membership/cubit/membership_screen_cubit.dart';
import 'package:app_template/ui/screens/membership/cubit/membership_screen_state.dart';

class MembershipScreenView extends StatefulWidget {
  const MembershipScreenView({super.key});

  @override
  State<MembershipScreenView> createState() => _MembershipScreenViewState();
}

class _MembershipScreenViewState extends State<MembershipScreenView> {
  late final MembershipScreenCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<MembershipScreenCubit>();
  }

  void _listener(BuildContext context, MembershipScreenState state) {
    switch (state.status) {
      case MembershipScreenStatus.initial:
      case MembershipScreenStatus.loading:
      case MembershipScreenStatus.ready:
        break;

      case MembershipScreenStatus.failure:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MembershipScreenCubit, MembershipScreenState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _listener,
      child: _buildScaffold(),
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Membership'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Membership'),
      ),
    );
  }
}
