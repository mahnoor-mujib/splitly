import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../logic/pocket_cubit.dart';
import '../../logic/pocket_state.dart';

class QuickExpenseModal extends StatefulWidget {
  const QuickExpenseModal({super.key});

  @override
  State<QuickExpenseModal> createState() => _QuickExpenseModalState();
}

class _QuickExpenseModalState extends State<QuickExpenseModal> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String? _selectedPocketId;
  String _selectedMethod = 'Easypaisa';

  final List<String> _paymentMethods = [
    'Easypaisa',
    'JazzCash',
    'Bank',
    'Cash',
    'Card',
  ];

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

          _selectedPocketId ??= state.pockets.first.id;

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quick Spend ⚡',
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
                  autofocus: true,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    prefixText: 'Rs. ',
                    prefixStyle: const TextStyle(
                      color: AppColors.neonGreen,
                      fontSize: 24,
                    ),
                    labelText: 'Amount Spent',
                    labelStyle: const TextStyle(color: AppColors.textSecondary),
                    filled: true,
                    fillColor: AppColors.darkBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _selectedPocketId,
                  dropdownColor: AppColors.darkCardBg,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    labelText: 'Deduct From Pocket',
                    labelStyle: const TextStyle(color: AppColors.textSecondary),
                    filled: true,
                    fillColor: AppColors.darkBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: state.pockets.map((p) {
                    return DropdownMenuItem(
                      value: p.id,
                      child: Text(
                        '${p.iconEmoji} ${p.name} (Rs. ${p.balance.toStringAsFixed(0)})',
                      ),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _selectedPocketId = val),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _paymentMethods.map((method) {
                      final isSelected = _selectedMethod == method;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(method),
                          selected: isSelected,
                          selectedColor: AppColors.neonGreen,
                          backgroundColor: AppColors.darkBackground,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? AppColors.darkBackground
                                : AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                          onSelected: (_) =>
                              setState(() => _selectedMethod = method),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _noteController,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    labelText: 'Note (Optional)',
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
                    onPressed: () {
                      final amount =
                          double.tryParse(_amountController.text) ?? 0.0;
                      if (amount > 0 && _selectedPocketId != null) {
                        context.read<PocketCubit>().quickDeduct(
                          _selectedPocketId!,
                          amount,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Deduct Amount',
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
