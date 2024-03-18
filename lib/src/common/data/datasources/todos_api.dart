import 'package:todos_riverpod/src/common/common.dart';

abstract class TodosApi {
  const TodosApi();

  Stream<List<Todo>> getTodos();

  Future<void> saveTodo(Todo todo);

  Future<void> deleteTodo(String id);

  Future<int> clearCompleted();

  Future<int> completeAll({required bool isCompleted});
}

/// Error thrown when a [Todo] with a given id is not found.
class TodoNotFoundException implements Exception {}
