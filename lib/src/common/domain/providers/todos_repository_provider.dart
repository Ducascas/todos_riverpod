import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_riverpod/src/common/common.dart';

part 'todos_repository_provider.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) =>
    throw UnimplementedError();

@Riverpod(keepAlive: true)
TodosApi localStorageTodosApi(LocalStorageTodosApiRef ref) 
{
    // final SharedPreferences sharedPreferences =
    //    SharedPreferences.getInstance().then((value) => value);

  return LocalStorageTodosApi(
        sharedPreferences: ref.watch(sharedPreferencesProvider));
}
   

@Riverpod(keepAlive: true)
TodosRepository todosRepository(TodosRepositoryRef ref) =>
    TodosRepositoryImpl(todosApi: ref.watch(localStorageTodosApiProvider));




// final todosRepositoryProvider = Provider<TodosRepository>((ref) {
//   final todosApi = ref.watch(localStorageTodosApiProvider);
//   return TodosRepositoryImpl(todosApi: todosApi);
// });

// final todosApiProvider = Provider.family<TodosApi, SharedPreferences>(
//   (_, sharedPreferences) =>
//       LocalStorageTodosApi(sharedPreferences: sharedPreferences),
// );

// final sharedPreferencesProvider =
//     FutureProvider<SharedPreferences>((ref) async {
//   return SharedPreferences.getInstance();
// });

