import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_state.dart';

part 'home_provider.g.dart';

// final homeNotifierProvider = StateNotifierProvider<HomeNotifier, HomeState>(
//   (ref) => HomeNotifier(),
// );

// class HomeNotifier extends StateNotifier<HomeState> {
//   HomeNotifier() : super(const HomeState());

//   void setTab(HomeTab tab) => state = HomeState(tab: tab);
// }

@riverpod
class HomeNotifier extends _$HomeNotifier {
  @override
  HomeState build() => HomeState();

  void setTab(HomeTab tab) => state = HomeState(tab: tab);
}
