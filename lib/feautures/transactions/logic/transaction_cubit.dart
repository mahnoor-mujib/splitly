import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/database/hive_service.dart';
import '../data/models/transaction_model.dart';
import 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitialState());

  Box<TransactionModel> get _box =>
      Hive.box<TransactionModel>(HiveService.transactionsBoxName);

  void loadTransactions() {
    emit(TransactionLoadingState());
    try {
      final transactions = _box.values.toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      emit(TransactionLoadedState(transactions));
    } catch (e) {
      emit(
        TransactionErrorState(
          'Failed to load transaction history: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await _box.put(transaction.id, transaction);
    loadTransactions();
  }
}
