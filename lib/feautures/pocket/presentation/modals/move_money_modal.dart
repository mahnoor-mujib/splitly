import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/repositories/pocket_repository.dart';
import '../../logic/pocket_cubit.dart';
import '../../logic/pocket_state.dart';

class MoveMoneyModal extends StatefulWidget {
  const MoveMoneyModal({super.key});

  @override
  State<MoveMoneyModal> createState() => _MoveMoneyModalState();
}

class _MoveMoneyModalState extends State<MoveMoneyModal> {
  final _amountController = TextEditingController();
  String? _fromPocketId;
  String? _toPocketId;

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

          _fromPocketId ??= state.pockets.first.id;
          _toPocketId ??= state.pockets.length > 1
              ? state.pockets[1].id
              : state.pockets.first.id;

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Move Money 🔄',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _fromPocketId,
                dropdownColor: AppColors.darkCardBg,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'From Pocket',
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
                    child: Text('${p.iconEmoji} ${p.name}'),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _fromPocketId = val),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Icon(
                  Icons.arrow_downward_rounded,
                  color: AppColors.neonGreen,
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _toPocketId,
                dropdownColor: AppColors.darkCardBg,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'To Pocket',
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
                    child: Text('${p.iconEmoji} ${p.name}'),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _toPocketId = val),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'Transfer Amount (Rs.)',
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
                  onPressed: () async {
                    final amount =
                        double.tryParse(_amountController.text) ?? 0.0;
                    if (amount > 0 &&
                        _fromPocketId != null &&
                        _toPocketId != null &&
                        _fromPocketId != _toPocketId) {
                      final repository = context.read<PocketRepository>();
                      final cubit = context.read<PocketCubit>();
                      final navigator = Navigator.of(context);

                      await repository.transferMoney(
                        _fromPocketId!,
                        _toPocketId!,
                        amount,
                      );

                      if (!mounted) return;
                      cubit.loadPockets();
                      navigator.pop();
                    }
                  },
                  child: const Text(
                    'Transfer Funds',
                    style: TextStyle(
                      color: AppColors.darkBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
