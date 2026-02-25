import 'package:flutter/material.dart';
import 'package:jenosize/data/models/point_history.dart';

class TransactionItem extends StatelessWidget {
  final PointHistory item;

  const TransactionItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final points = item.points ?? 0;
    final isPositive = points >= 0;

    final color = isPositive
        ? const Color(0xff8b5cf6)
        : const Color(0xffef4444);

    final amountColor = isPositive
        ? const Color(0xff10b981)
        : const Color(0xffef4444);

    final icon = isPositive
        ? Icons.south_west_rounded
        : Icons.north_east_rounded;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title ?? '- ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  formatTransactionDate(item.createdAt),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isPositive ? '+' : ''}$points',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}

String formatTransactionDate(DateTime? date) {
  if (date == null) return '';
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final day = date.day;
  final suffix = (day >= 11 && day <= 13)
      ? 'th'
      : (day % 10 == 1)
      ? 'st'
      : (day % 10 == 2)
      ? 'nd'
      : (day % 10 == 3)
      ? 'rd'
      : 'th';

  return '${months[date.month - 1]} $day$suffix, ${date.year}';
}
