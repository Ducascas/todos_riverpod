import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_riverpod/src/common/common.dart';
import 'package:todos_riverpod/src/features/todos_overview/todos_overview.dart';

part 'todos_overview_state.dart';

final todosOverviewNotifierProvider =
    StateNotifierProvider<TodosOverviewNotifier, TodosOverviewState>(
  (ref) => TodosOverviewNotifier(
    todosRepository: ref.watch(todosRepositoryProvider),
  ),
);

class TodosOverviewNotifier extends StateNotifier<TodosOverviewState> {
  TodosOverviewNotifier({
    required TodosRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super(const TodosOverviewState());

  final TodosRepository _todosRepository;

  Future<void> onSubscriptionRequested() async {
    // state = state.copyWith(status: () => TodosOverviewStatus.loading);

    final todos = _todosRepository.getTodos();

    await todos.listen(
      (todos) => state = state.copyWith(
        status: () => TodosOverviewStatus.success,
        todos: () => todos,
      ),
      onError: (_, __) => state = state.copyWith(
        status: () => TodosOverviewStatus.failure,
      ),
    );
  }

  Future<void> onTodoCompletionToggled(Todo todo, bool isCompleted) async {
    final newTodo = todo.copyWith(isCompleted: isCompleted);
    await _todosRepository.saveTodo(newTodo);
  }

  Future<void> onTodoDeleted(Todo todo) async {
    state = state.copyWith(lastDeletedTodo: () => todo);
    await _todosRepository.deleteTodo(todo.id);
  }

  Future<void> onUndoDeletionRequested() async {
    assert(
      state.lastDeletedTodo != null,
      'Last deleted todo can not be null.',
    );
    final todo = state.lastDeletedTodo!;
    state = state.copyWith(lastDeletedTodo: () => null);
    await _todosRepository.saveTodo(todo);
  }

  void onFilterChanged(TodosViewFilter filter) {
    state = state.copyWith(filter: () => filter);
  }

  Future<void> onToggleAllRequested() async {
    final areAllCompleted = state.todos.every((todo) => todo.isCompleted);
    await _todosRepository.completeAll(isCompleted: !areAllCompleted);
  }

  Future<void> onClearCompletedRequested() async {
    await _todosRepository.clearCompleted();
  }
}
