import 'package:flutter/material.dart';
import 'package:jenosize/data/models/campaign.dart';
import 'package:jenosize/ui/extensions/build_context_extension.dart';
import 'package:jenosize/ui/styles/app_text_style.dart';

class CampaignCard extends StatelessWidget {
  final Campaign? campaign;
  final bool isJoined;
  final Function onJoin;

  const CampaignCard({
    super.key,
    required this.campaign,
    required this.isJoined,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      color: context.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            campaign?.imageUrl ?? '',
            height: 180,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
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
                        '+${campaign?.pointsReward ?? 0} ${context.l10n.common_points_suffix}',
                        style: AppTextStyle.w800(
                          16,
                        ).copyWith(color: context.appColors.positive),
                      ),
                    ),
                    FilledButton(
                      onPressed: () => isJoined ? null : onJoin(),
                      style: FilledButton.styleFrom(
                        backgroundColor: isJoined
                            ? context.colorScheme.secondary
                            : context.colorScheme.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        isJoined
                            ? context.l10n.home_button_joined
                            : context.l10n.home_button_join_now,
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
