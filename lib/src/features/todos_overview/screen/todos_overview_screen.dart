// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_riverpod/src/common/common.dart';
import 'package:todos_riverpod/src/features/edit_todo/edit_todo.dart';
import 'package:todos_riverpod/src/features/todos_overview/todos_overview.dart';

class TodosOverviewScreen extends ConsumerWidget {
  const TodosOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final todos = ref.watch(todosOverviewNotifierProvider);
    
    ref.read(todosOverviewNotifierProvider.notifier).onSubscriptionRequested();

    ref.listen(
      todosOverviewNotifierProvider.select((state) => state.status),
      ((previous, next) {
        if (previous != next) {
          if (next == TodosOverviewStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(l10n.todosOverviewErrorSnackbarText),
                ),
              );
          }
        }
      }),
    );
    ref.listen(
      todosOverviewNotifierProvider.select((state) => state.lastDeletedTodo),
      ((previous, next) {
        if (previous != next) {
          if (next != null) {
            final messenger = ScaffoldMessenger.of(context);
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    l10n.todosOverviewTodoDeletedSnackbarText(
                      next.title,
                    ),
                  ),
                  action: SnackBarAction(
                    label: l10n.todosOverviewUndoDeletionButtonText,
                    onPressed: () {
                      messenger.hideCurrentSnackBar();
                      ref
                          .read(todosOverviewNotifierProvider.notifier)
                          .onUndoDeletionRequested();
                    },
                  ),
                ),
              );
          }
        }
      }),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.todosOverviewAppBarTitle),
        actions: const [
          TodosOverviewFilterButton(),
          TodosOverviewOptionsButton(),
        ],
      ),
      body: Consumer(
        builder: (context, state, child) {
          if (todos.todos.isEmpty) {
            if (todos.status == TodosOverviewStatus.loading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (todos.status != TodosOverviewStatus.success) {
              return const SizedBox();
            } else {
              return Center(
                child: Text(
                  l10n.todosOverviewEmptyText,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            }
          }
          return Scrollbar(
            child: ListView(
              children: [
                for (final todo in todos.filteredTodos)
                  TodoListTile(
                    todo: todo,
                    onToggleCompleted: (isCompleted) => ref
                        .read(todosOverviewNotifierProvider.notifier)
                        .onTodoCompletionToggled(todo, isCompleted),
                    onDismissed: (_) => ref
                        .read(todosOverviewNotifierProvider.notifier)
                        .onTodoDeleted(todo),
                    onTap:
                        () => //Navigator.of(context).pushNamed('/edit_todo', arguments: todo),
                            Navigator.of(context).push(
                      EditTodoPage.route(initialTodo: todo),
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
