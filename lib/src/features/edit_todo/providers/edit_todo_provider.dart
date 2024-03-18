import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todos_riverpod/src/common/common.dart';

part 'edit_todo_state.dart';

part 'edit_todo_provider.g.dart';

@riverpod
class EditTodoNotifier extends _$EditTodoNotifier {
  @override
  EditTodoState build() => const EditTodoState();

  late final TodosRepository _todosRepository =
      ref.watch(todosRepositoryProvider);

  void onTitleChanged(String title) {
    state = state.copyWith(title: title);
  }

  void onDescriptionChanged(String description) {
    state = state.copyWith(description: description);
  }

  Future<void> onSubmitted() async {
    state = state.copyWith(
      status: EditTodoStatus.loading,
    );

    final todo = (state.initialTodo ?? Todo(title: '')).copyWith(
      title: state.title,
      description: state.description,
    );

    try {
      await _todosRepository.saveTodo(todo);
      state = state.copyWith(status: EditTodoStatus.success);
    } catch (e) {
      state = state.copyWith(status: EditTodoStatus.failure);
    }
  }
}
