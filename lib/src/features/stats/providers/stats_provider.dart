import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todos_riverpod/src/common/common.dart';

part 'stats_state.dart';

final statsProvider = StateNotifierProvider<StatsNotifier, StatsState>((ref) =>
    StatsNotifier(todosRepository: ref.watch(todosRepositoryProvider)));

class StatsNotifier extends StateNotifier<StatsState> {
  StatsNotifier({
    required TodosRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super(const StatsState());

  final TodosRepository _todosRepository;

  Future<void> onSubscriptionRequested() async {
    // state = state.copyWith(status: StatsStatus.loading);
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
