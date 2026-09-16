import '../data/models/transaction_model.dart';

abstract class TransactionState {}

class TransactionInitialState extends TransactionState {}

class TransactionLoadingState extends TransactionState {}

class TransactionLoadedState extends TransactionState {
  final List<TransactionModel> transactions;
  TransactionLoadedState(this.transactions);
}

class TransactionErrorState extends TransactionState {
  final String message;
  TransactionErrorState(this.message);
}
