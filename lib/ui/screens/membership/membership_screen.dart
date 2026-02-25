import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenosize/data/models/user.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';
import 'package:jenosize/ui/cubits/session/session_state.dart';
import 'package:jenosize/ui/extensions/build_context_extension.dart';
import 'package:jenosize/ui/screens/membership/cubit/membership_screen_cubit.dart';
import 'package:jenosize/ui/screens/membership/cubit/membership_screen_state.dart';
import 'package:jenosize/ui/styles/app_text_style.dart';
import 'package:jenosize/ui/utils/app_alert.dart';
import 'package:share_plus/share_plus.dart';

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
        AppAlert.error(context, error: state.error);
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
    return BlocSelector<SessionCubit, SessionState, User?>(
      selector: (state) => state.user,
      builder: (context, user) {
        final isMember = user?.isMember ?? false;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              context.l10n.membership_title,
              style: AppTextStyle.w700(20).colorOnSurface(context),
            ),
            centerTitle: true,
          ),
          body: _buildBody(isMember, user),
        );
      },
    );
  }

  Widget _buildBody(bool isMember, User? user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          if (isMember) ...[
            Text(
              context.l10n.membership_welcome_back(user?.firstName ?? ''),
              style: AppTextStyle.w700(24),
            ),
            const SizedBox(height: 16),
            _buildMembershipCard(user),
            const SizedBox(height: 32),
            _buildReferSection(user?.id ?? ''),
          ] else ...[
            _buildJoinSection(),
          ],
        ],
      ),
    );
  }

  Widget _buildJoinSection() {
    return Column(
      children: [
        const Icon(Icons.card_membership, size: 80, color: Colors.grey),
        const SizedBox(height: 16),
        Text(context.l10n.membership_join_promo, textAlign: TextAlign.center),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: FilledButton(
            onPressed: () => _cubit.joinMembership(),
            child: Text(context.l10n.membership_button_join),
          ),
        ),
      ],
    );
  }

  Widget _buildMembershipCard(User? user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff8b5cf6), Color(0xffd946ef)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.stars_rounded, color: Colors.white, size: 40),
          const SizedBox(height: 40),
          Text(
            '${user?.firstName ?? ''} ${user?.lastName ?? ''}'.toUpperCase(),
            style: AppTextStyle.w800(20).copyWith(color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            context.l10n.membership_status_premium,
            style: AppTextStyle.w600(14).copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildReferSection(String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.membership_refer_title,
            style: AppTextStyle.w700(18),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.membership_refer_desc,
            style: AppTextStyle.w400(16).copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          _buildReferralCodeBox(code),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton.icon(
              onPressed: () => SharePlus.instance.share(
                ShareParams(
                  text: context.l10n.membership_share_text(code),
                ),
              ),
              icon: const Icon(Icons.share_rounded),
              label: Text(context.l10n.membership_button_share),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralCodeBox(String code) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.primary.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              code,
              style: AppTextStyle.w800(20).copyWith(
                color: context.colorScheme.primary,
                letterSpacing: 1.5,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: code));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.membership_copy_success)),
              );
            },
            icon: const Icon(Icons.copy_rounded),
            color: context.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
