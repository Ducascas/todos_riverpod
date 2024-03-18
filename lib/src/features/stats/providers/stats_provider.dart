import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todos_riverpod/src/common/common.dart';

part 'stats_state.dart';

part 'stats_provider.g.dart';

@riverpod
class StatsNotifier extends _$StatsNotifier {
  @override
  StatsState build() => const StatsState();

  late final TodosRepository _todosRepository =
      ref.watch(todosRepositoryProvider);

  Future<void> onSubscriptionRequested() async {
    final todos = _todosRepository.getTodos();

    await todos.listen(
      (todos) => state = state.copyWith(
        status: StatsStatus.success,
        completedTodos: todos.where((todo) => todo.isCompleted).length,
        activeTodos: todos.where((todo) => !todo.isCompleted).length,
      ),
      onError: (_, __) => state = state.copyWith(
        status: StatsStatus.failure,
      ),
    );
  }
}
