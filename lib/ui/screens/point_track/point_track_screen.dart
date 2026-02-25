import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenosize/data/models/point_history.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';
import 'package:jenosize/ui/cubits/session/session_state.dart';
import 'package:jenosize/ui/extensions/build_context_extension.dart';
import 'package:jenosize/ui/extensions/num_extension.dart';
import 'package:jenosize/ui/screens/point_track/cubit/point_track_screen_cubit.dart';
import 'package:jenosize/ui/screens/point_track/cubit/point_track_screen_state.dart';
import 'package:jenosize/ui/screens/point_track/widgets/transaction_item.dart';
import 'package:jenosize/ui/styles/app_text_style.dart';
import 'package:jenosize/ui/utils/app_alert.dart';

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
    _cubit.loadTransactions();
  }

  void _listener(BuildContext context, PointTrackScreenState state) {
    switch (state.status) {
      case PointTrackScreenStatus.initial:
      case PointTrackScreenStatus.loading:
      case PointTrackScreenStatus.ready:
        break;
      case PointTrackScreenStatus.failure:
        AppAlert.error(context, error: state.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PointTrackScreenCubit, PointTrackScreenState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _listener,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: [
            _buildTotalPointsHeader(),
            Expanded(child: _buildBodyList()),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        context.l10n.point_track_title,
        style: AppTextStyle.w700(20).colorOnSurface(context),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildTotalPointsHeader() {
    return BlocSelector<SessionCubit, SessionState, int>(
      selector: (state) => state.user?.totalPoints ?? 0,
      builder: (context, totalPoints) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              _buildBalanceLabel(context),
              const SizedBox(height: 8),
              _buildPointsValue(context, totalPoints),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBalanceLabel(BuildContext context) {
    return Text(
      context.l10n.point_track_total_balance,
      style: AppTextStyle.w500(14).copyWith(
        color: Theme.of(
          context,
        ).colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
      ),
    );
  }

  Widget _buildPointsValue(BuildContext context, int totalPoints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          totalPoints.thousandSeparated,
          style: AppTextStyle.w800(40).copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          context.l10n.point_track_unit_points,
          style: AppTextStyle.w600(16).copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }

  Widget _buildBodyList() {
    return BlocSelector<SessionCubit, SessionState, List<PointHistory?>>(
      selector: (state) => state.pointHistories,
      builder: (context, histories) {
        return BlocSelector<PointTrackScreenCubit, PointTrackScreenState, bool>(
          selector: (state) => state.status.isLoading,
          builder: (context, isLoading) {
            if (histories.isEmpty) {
              return _buildEmptyState();
            }

            return _buildTransactionListView(histories);
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        context.l10n.point_track_empty_transactions,
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildTransactionListView(List<PointHistory?> histories) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      itemCount: histories.length,
      itemBuilder: (context, index) {
        return TransactionItem(item: histories[index]);
      },
    );
  }
}
