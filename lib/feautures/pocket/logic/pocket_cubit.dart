import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/pocket_model.dart';
import '../data/repositories/pocket_repository.dart';
import 'pocket_state.dart';

class PocketCubit extends Cubit<PocketState> {
  final PocketRepository _repository;

  PocketCubit(this._repository) : super(PocketInitialState()) {
    loadPockets();
  }

  void loadPockets() {
    emit(PocketLoadingState());
    try {
      final pockets = _repository.getPockets();
      final total = pockets.fold<double>(0, (sum, item) => sum + item.balance);
      emit(PocketLoadedState(pockets: pockets, totalBalance: total));
    } catch (e) {
      emit(PocketErrorState("Failed to load pockets: ${e.toString()}"));
    }
  }

  Future<void> addPocket(PocketModel pocket) async {
    await _repository.addPocket(pocket);
    loadPockets();
  }

  Future<void> splitMoney(
    double income,
    Map<String, double> percentages,
  ) async {
    await _repository.splitIncome(income, percentages);
    loadPockets();
  }

  Future<void> quickDeduct(String pocketId, double amount) async {
    final pockets = _repository.getPockets();
    final pocket = pockets.firstWhere((p) => p.id == pocketId);
    if (pocket.balance >= amount) {
      pocket.balance -= amount;
      await _repository.updatePocket(pocket);
      loadPockets();
    }
  }
}
