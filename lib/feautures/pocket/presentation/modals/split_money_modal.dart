import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../logic/pocket_cubit.dart';
import '../../logic/pocket_state.dart';

class SplitMoneyModal extends StatefulWidget {
  const SplitMoneyModal({super.key});

  @override
  State<SplitMoneyModal> createState() => _SplitMoneyModalState();
}

class _SplitMoneyModalState extends State<SplitMoneyModal> {
  final _amountController = TextEditingController();
  final Map<String, double> _percentages = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.darkCardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: BlocBuilder<PocketCubit, PocketState>(
        builder: (context, state) {
          if (state is! PocketLoadedState) return const SizedBox.shrink();

          if (_percentages.isEmpty) {
            final defaultPct = 100 / state.pockets.length;
            for (var p in state.pockets) {
              _percentages[p.id] = defaultPct;
            }
          }

          final double currentTotalPct = _percentages.values.fold(
            0,
            (sum, val) => sum + val,
          );

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Split My Money 💸',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    labelText: 'Total Income (Rs.)',
                    labelStyle: const TextStyle(color: AppColors.textSecondary),
                    filled: true,
                    fillColor: AppColors.darkBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Allocation Percentages',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ...state.pockets.map(
                  (pocket) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Text(
                          '${pocket.iconEmoji} ${pocket.name}',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  '${_percentages[pocket.id]?.toStringAsFixed(0)}%',
                              hintStyle: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              filled: true,
                              fillColor: AppColors.darkBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (val) {
                              setState(() {
                                _percentages[pocket.id] =
                                    double.tryParse(val) ?? 0.0;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Allocation:',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    Text(
                      '${currentTotalPct.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: currentTotalPct == 100
                            ? AppColors.neonGreen
                            : Colors.redAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.neonGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: currentTotalPct != 100
                        ? null
                        : () {
                            final income =
                                double.tryParse(_amountController.text) ?? 0.0;
                            if (income > 0) {
                              context.read<PocketCubit>().splitMoney(
                                income,
                                _percentages,
                              );
                              Navigator.pop(context);
                            }
                          },
                    child: const Text(
                      'Apply Split',
                      style: TextStyle(
                        color: AppColors.darkBackground,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
