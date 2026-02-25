import 'package:app_template/data/models/campaign.dart';
import 'package:app_template/ui/extensions/build_context_extension.dart';
import 'package:app_template/ui/screens/home/cubit/home_screen_cubit.dart';
import 'package:app_template/ui/screens/home/cubit/home_screen_state.dart';
import 'package:app_template/ui/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeScreenCubit>().loadCampaigns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Campaigns',
          style: AppTextStyle.w700(20).colorOnSurface(context),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          if (state.status.isLoading && state.campaigns.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == HomeScreenStatus.failure) {
            return Center(
              child: Text(
                'Failed to load campaigns',
                style: AppTextStyle.w500(16).colorError(context),
              ),
            );
          }

          if (state.campaigns.isEmpty) {
            return Center(
              child: Text(
                'No campaigns available',
                style: AppTextStyle.w500(16).colorOnSurfaceVariant(context),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 16,
              bottom: 100,
            ),
            itemCount: state.campaigns.length,
            separatorBuilder: (_, __) => const SizedBox(height: 24),
            itemBuilder: (context, index) {
              return _CampaignCard(
                campaign: state.campaigns[index],
              );
            },
          );
        },
      ),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  final Campaign? campaign;

  const _CampaignCard({required this.campaign});

  @override
  Widget build(BuildContext context) {
    final bgColor = context.colorScheme.surface;
    final primaryColor = context.colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            offset: const Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            campaign?.imageUrl ?? '',
            height: 180,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 180,
              color: context.colorScheme.surfaceContainerHighest,
              child: const Icon(Icons.image_not_supported, size: 40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  campaign?.title ?? 'Untitled Campaign',
                  style: AppTextStyle.w700(18).colorOnSurface(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  campaign?.description ?? 'No description available',
                  style: AppTextStyle.w400(14).colorOnSurfaceVariant(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: context.appColors.positive.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '+${campaign?.pointsReward ?? 0} Pts',
                        style: AppTextStyle.w800(
                          16,
                        ).copyWith(color: context.appColors.positive),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Join Now',
                        style: AppTextStyle.w700(14).colorOnPrimary(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
