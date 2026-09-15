import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pocket.dart';
import '../models/app_transaction.dart';
import '../models/savings_goal.dart';
import '../models/wishlist_item.dart';
import '../models/recurring_item.dart';
import '../models/split_plan.dart';
import '../models/app_user.dart';

class StorageService {
  static const _kUser = 'user';
  static const _kPockets = 'pockets';
  static const _kTransactions = 'transactions';
  static const _kGoals = 'goals';
  static const _kWishlist = 'wishlist';
  static const _kRecurring = 'recurring';
  static const _kSplitPlan = 'split_plan';
  static const _kThemeMode = 'theme_mode';
  static const _kCurrency = 'currency';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static Future<StorageService> instance() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  Future<void> saveUser(AppUser user) async {
    await _prefs.setString(_kUser, jsonEncode(user.toMap()));
  }

  AppUser? getUser() {
    final raw = _prefs.getString(_kUser);
    if (raw == null) return null;
    return AppUser.fromMap(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> clearUser() async {
    await _prefs.remove(_kUser);
    await _prefs.remove(_kPockets);
    await _prefs.remove(_kTransactions);
    await _prefs.remove(_kGoals);
    await _prefs.remove(_kWishlist);
    await _prefs.remove(_kRecurring);
    await _prefs.remove(_kSplitPlan);
  }

  Future<void> savePockets(List<Pocket> pockets) async {
    await _prefs.setString(
      _kPockets,
      jsonEncode(pockets.map((p) => p.toMap()).toList()),
    );
  }

  List<Pocket> getPockets() {
    final raw = _prefs.getString(_kPockets);
    if (raw == null) return [];
    return (jsonDecode(raw) as List)
        .map((e) => Pocket.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveTransactions(List<AppTransaction> txs) async {
    await _prefs.setString(
      _kTransactions,
      jsonEncode(txs.map((t) => t.toMap()).toList()),
    );
  }

  List<AppTransaction> getTransactions() {
    final raw = _prefs.getString(_kTransactions);
    if (raw == null) return [];
    final list = (jsonDecode(raw) as List)
        .map((e) => AppTransaction.fromMap(e as Map<String, dynamic>))
        .toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  Future<void> saveGoals(List<SavingsGoal> goals) async {
    await _prefs.setString(
      _kGoals,
      jsonEncode(goals.map((g) => g.toMap()).toList()),
    );
  }

  List<SavingsGoal> getGoals() {
    final raw = _prefs.getString(_kGoals);
    if (raw == null) return [];
    return (jsonDecode(raw) as List)
        .map((e) => SavingsGoal.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveWishlist(List<WishlistItem> items) async {
    await _prefs.setString(
      _kWishlist,
      jsonEncode(items.map((i) => i.toMap()).toList()),
    );
  }

  List<WishlistItem> getWishlist() {
    final raw = _prefs.getString(_kWishlist);
    if (raw == null) return [];
    return (jsonDecode(raw) as List)
        .map((e) => WishlistItem.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveRecurring(List<RecurringItem> items) async {
    await _prefs.setString(
      _kRecurring,
      jsonEncode(items.map((i) => i.toMap()).toList()),
    );
  }

  List<RecurringItem> getRecurring() {
    final raw = _prefs.getString(_kRecurring);
    if (raw == null) return [];
    return (jsonDecode(raw) as List)
        .map((e) => RecurringItem.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveSplitPlan(SplitPlan? plan) async {
    if (plan == null) {
      await _prefs.remove(_kSplitPlan);
    } else {
      await _prefs.setString(_kSplitPlan, jsonEncode(plan.toMap()));
    }
  }

  SplitPlan? getSplitPlan() {
    final raw = _prefs.getString(_kSplitPlan);
    if (raw == null) return null;
    return SplitPlan.fromMap(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> saveThemeMode(String mode) async {
    await _prefs.setString(_kThemeMode, mode);
  }

  String getThemeMode() => _prefs.getString(_kThemeMode) ?? 'system';

  Future<void> saveCurrency(String currency) async {
    await _prefs.setString(_kCurrency, currency);
  }

  String getCurrency() => _prefs.getString(_kCurrency) ?? 'Rs.';

  Future<void> setPin(String pin) async {
    await _prefs.setString('app_pin', pin);
  }

  String? getPin() => _prefs.getString('app_pin');

  Future<void> clearPin() async {
    await _prefs.remove('app_pin');
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    await _prefs.setBool('biometric_enabled', enabled);
  }

  bool getBiometricEnabled() =>
      _prefs.getBool('biometric_enabled') ?? false;
}