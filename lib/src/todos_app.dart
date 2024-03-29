import 'package:flutter/material.dart';
import 'package:todos_riverpod/src/common/common.dart';
import 'package:todos_riverpod/src/features/home/home.dart';

class TodosApp extends StatelessWidget {
  const TodosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlutterTodosTheme.dark,
      darkTheme: FlutterTodosTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const TodosHomeScreen(),
    );
  }
}
