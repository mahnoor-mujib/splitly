import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/database/hive_service.dart';
import 'feautures/pocket/data/repositories/pocket_repository.dart';
import 'feautures/pocket/logic/pocket_cubit.dart';
import 'feautures/pocket/screens/dashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  final repository = PocketRepository();

  runApp(
    RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) => PocketCubit(repository),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splitly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00FF9D)),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}
