import 'package:todos_riverpod/src/common/common.dart';

enum TodosViewFilter { all, activeOnly, completedOnly }

extension TodosViewFilterX on TodosViewFilter {
  bool apply(Todo todo) {
    switch (this) {
      case TodosViewFilter.all:
        return true;
      case TodosViewFilter.activeOnly:
        return !todo.isCompleted;
      case TodosViewFilter.completedOnly:
        return todo.isCompleted;
    }
  }

  Iterable<Todo> applyAll(Iterable<Todo> todos) {
    return todos.where(apply);
  }
}

// final todoListFilter = StateProvider((_) => TodosViewFilter.all);


// final filteredTodos = Provider<List<Todo>>((ref) {
//   final filter = ref.watch(todoListFilter);
//   final todos = ref.watch(todoListProvider);

//   switch (filter) {
//     case TodoListFilter.completed:
//       return todos.where((todo) => todo.completed).toList();
//     case TodoListFilter.active:
//       return todos.where((todo) => !todo.completed).toList();
//     case TodoListFilter.all:
//       return todos;
//   }
// });