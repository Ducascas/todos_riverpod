import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todos_riverpod/src/common/common.dart';
import 'package:todos_riverpod/src/features/todos_overview/todos_overview.dart';

part 'todos_overview_state.dart';

part 'todos_overview_provider.g.dart';

@riverpod
class TodosOverviewNotifier extends _$TodosOverviewNotifier {
  @override
  TodosOverviewState build() => const TodosOverviewState();

  late final TodosRepository _todosRepository =
      ref.watch(todosRepositoryProvider);

  Future<void> onSubscriptionRequested() async {
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
