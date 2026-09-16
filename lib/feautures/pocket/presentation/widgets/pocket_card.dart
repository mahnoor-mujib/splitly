import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/pocket_model.dart';

class PocketCard extends StatelessWidget {
  final PocketModel pocket;

  const PocketCard({super.key, required this.pocket});

  @override
  Widget build(BuildContext context) {
    final double progress = pocket.targetAmount > 0
        ? (pocket.balance / pocket.targetAmount).clamp(0.0, 1.0)
        : 1.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.cardBorder, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(pocket.iconEmoji, style: const TextStyle(fontSize: 28)),
              Text(
                'Rs. ${pocket.balance.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            pocket.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.cardBorder,
              color: AppColors.neonGreen,
            ),
          ),
        ],
      ),
    );
  }
}
