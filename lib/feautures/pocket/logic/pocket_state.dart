import '../data/models/pocket_model.dart';

abstract class PocketState {}

class PocketInitialState extends PocketState {}

class PocketLoadingState extends PocketState {}

class PocketLoadedState extends PocketState {
  final List<PocketModel> pockets;
  final double totalBalance;

  PocketLoadedState({required this.pockets, required this.totalBalance});
}

class PocketErrorState extends PocketState {
  final String message;
  PocketErrorState(this.message);
}
