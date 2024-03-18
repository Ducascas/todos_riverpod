import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_riverpod/src/features/edit_todo/edit_todo.dart';
import 'package:todos_riverpod/src/features/home/home.dart';
import 'package:todos_riverpod/src/features/stats/stats.dart';
import 'package:todos_riverpod/src/features/todos_overview/todos_overview.dart';

class TodosHomeScreen extends ConsumerWidget {
  const TodosHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab =
        ref.watch(homeNotifierProvider.select((state) => state.tab));

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [
          TodosOverviewScreen(),
          StatsScreen(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        key: const Key('homeView_addTodo_floatingActionButton'),
        onPressed: () => Navigator.of(context).push(EditTodoPage.route()),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              ref: ref,
              groupValue: selectedTab,
              value: HomeTab.todos,
              icon: const Icon(Icons.list_rounded),
            ),
            const SizedBox(width: 100),
            _HomeTabButton(
              ref: ref,
              groupValue: selectedTab,
              value: HomeTab.stats,
              icon: const Icon(Icons.show_chart_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    required this.ref,
    required this.groupValue,
    required this.value,
    required this.icon,
  });

  final WidgetRef ref;
  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => ref.read(homeNotifierProvider.notifier).setTab(value),
      iconSize: 32,
      color: groupValue != value
          ? null
          : Colors.pink, // Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}
