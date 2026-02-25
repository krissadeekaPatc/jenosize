import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenosize/data/models/campaign.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';
import 'package:jenosize/ui/cubits/session/session_state.dart';
import 'package:jenosize/ui/extensions/build_context_extension.dart';
import 'package:jenosize/ui/global_widgets/campaign_card.dart';
import 'package:jenosize/ui/screens/home/cubit/home_screen_cubit.dart';
import 'package:jenosize/ui/screens/home/cubit/home_screen_state.dart';
import 'package:jenosize/ui/styles/app_text_style.dart';
import 'package:jenosize/ui/utils/app_alert.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  late final HomeScreenCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = context.read<HomeScreenCubit>();
    _cubit.loadCampaigns();
  }

  void _listener(BuildContext context, HomeScreenState state) {
    switch (state.status) {
      case HomeScreenStatus.initial:
      case HomeScreenStatus.loading:
      case HomeScreenStatus.ready:
        break;
      case HomeScreenStatus.failure:
        AppAlert.error(context, error: state.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _listener,
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(state),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        context.l10n.home_title_campaigns,
        style: AppTextStyle.w700(20).colorOnSurface(context),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildBody(HomeScreenState state) {
    if (state.campaigns.isEmpty) {
      return _buildEmptyState();
    }
    return _buildCampaignList(state.campaigns);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        context.l10n.home_empty_campaigns,
        style: AppTextStyle.w500(16).colorOnSurfaceVariant(context),
      ),
    );
  }

  Widget _buildCampaignList(List<Campaign?> campaigns) {
    return BlocSelector<SessionCubit, SessionState, Set<String>>(
      selector: (state) => state.joinedCampaignIds,
      builder: (context, joinedIds) {
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
          itemCount: campaigns.length,
          separatorBuilder: (_, _) => const SizedBox(height: 24),
          itemBuilder: (context, index) {
            final campaign = campaigns[index];
            final isJoined = joinedIds.contains(campaign?.id);

            return CampaignCard(
              campaign: campaign,
              isJoined: isJoined,
              onJoin: () => _onShowJoinConfirmation(campaign),
            );
          },
        );
      },
    );
  }

  void _onShowJoinConfirmation(Campaign? campaign) {
    if (campaign == null) return;

    AppAlert.confirmation(
      context,
      title: context.l10n.home_alert_join_title,
      message: context.l10n.home_alert_join_message,
      onConfirm: () => _cubit.joinCampaign(campaign),
    );
  }
}
