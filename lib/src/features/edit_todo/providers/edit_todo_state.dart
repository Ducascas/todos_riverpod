
part of 'edit_todo_provider.dart';

enum EditTodoStatus { initial, loading, success, failure }

extension EditTodoStatusX on EditTodoStatus {
  bool get isLoadingOrSuccess => [
        EditTodoStatus.loading,
        EditTodoStatus.success,
      ].contains(this);
}

final class EditTodoState extends Equatable {
  const EditTodoState({
    this.status = EditTodoStatus.initial,
    this.initialTodo,
    this.title = '',
    this.description = '',
  });

  final EditTodoStatus status;
  final Todo? initialTodo;
  final String title;
  final String description;

  bool get isNewTodo => initialTodo == null;

  EditTodoState copyWith({
    EditTodoStatus? status,
    Todo? initialTodo,
    String? title,
    String? description,
  }) {
    return EditTodoState(
      status: status ?? this.status,
      initialTodo: initialTodo ?? this.initialTodo,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [status, initialTodo, title, description];
}


// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'edit_todo_state.freezed.dart';

// @freezed
// class EditTodoState with _$EditTodoState {
//   const factory EditTodoState.initial() = _Initial;
//   const factory EditTodoState.titleChanged(String title) = _TitleChanged;
//   const factory EditTodoState.descriptionChanged(String description) =
//       _DescriptionChanged;
//   const factory EditTodoState.submitted(String title, String description) =
//       _Submitted;
//   const factory EditTodoState.failure(String errorMessage) = _Failure;
// }