import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_riverpod/src/common/common.dart';

part 'edit_todo_state.dart';

final editTodoNotifierProvider =
    StateNotifierProvider<EditTodoNotifier, EditTodoState>(
  (ref) => EditTodoNotifier(
    // initialTodo: todo,
    todosRepository: ref.watch(todosRepositoryProvider),
  ),
);

class EditTodoNotifier extends StateNotifier<EditTodoState> {
  EditTodoNotifier({
    required TodosRepository todosRepository,
    // required Todo? initialTodo,
  })  : _todosRepository = todosRepository,
        super(const EditTodoState(
            // initialTodo: initialTodo,
            // title: initialTodo?.title ?? '',
            // description: initialTodo?.description ?? '')
            ));

  final TodosRepository _todosRepository;

  void onTitleChanged(String title) {
    state = state.copyWith(title: title);
  }

  void onDescriptionChanged(String description) {
    state = state.copyWith(description: description);
  }

  Future<void> onSubmitted() async {
    // state = state.copyWith(
    //   status: EditTodoStatus.loading,
    // );

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
