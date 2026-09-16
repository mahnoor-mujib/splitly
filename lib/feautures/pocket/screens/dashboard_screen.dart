import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../logic/pocket_cubit.dart';
import '../logic/pocket_state.dart';
import '../presentation/modals/move_money_modal.dart';
import '../presentation/modals/quick_expense_modal.dart';
import '../presentation/modals/split_money_modal.dart';
import '../presentation/widgets/pocket_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Good evening 👋',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: BlocBuilder<PocketCubit, PocketState>(
        builder: (context, state) {
          if (state is PocketLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.neonGreen),
            );
          }

          if (state is PocketLoadedState) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Balance",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Rs. ${state.totalBalance.toStringAsFixed(0)}",
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _QuickActionButton(
                              icon: Icons.add,
                              label: "Add",
                              onTap: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => const SplitMoneyModal(),
                              ),
                            ),
                            _QuickActionButton(
                              icon: Icons.remove,
                              label: "Spend",
                              onTap: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => const QuickExpenseModal(),
                              ),
                            ),
                            _QuickActionButton(
                              icon: Icons.swap_horiz,
                              label: "Move",
                              onTap: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => const MoveMoneyModal(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.1,
                        ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          PocketCard(pocket: state.pockets[index]),
                      childCount: state.pockets.length,
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: Text(
              'Initialize money pockets!',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.neonGreen,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppColors.darkBackground, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
