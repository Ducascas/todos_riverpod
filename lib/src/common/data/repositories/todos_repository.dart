import 'package:todos_riverpod/src/common/common.dart';

class TodosRepositoryImpl extends TodosRepository {
  TodosRepositoryImpl({
    required TodosApi todosApi,
  }) : _todosApi = todosApi;

  final TodosApi _todosApi;

  @override
  Stream<List<Todo>> getTodos() => _todosApi.getTodos();

  @override
  Future<void> saveTodo(Todo todo) => _todosApi.saveTodo(todo);

  @override
  Future<void> deleteTodo(String id) => _todosApi.deleteTodo(id);

  @override
  Future<int> clearCompleted() => _todosApi.clearCompleted();

  @override
  Future<int> completeAll({required bool isCompleted}) =>
      _todosApi.completeAll(isCompleted: isCompleted);
}
