import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'multi_select_provider.g.dart';

@riverpod
class MultiSelectNotifier extends _$MultiSelectNotifier {
  @override
  Set<String> build() {
    return {};
  }

  void toggle(String id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state, id};
    }
  }

  void selectAll(List<String> ids) {
    state = Set.from(ids);
  }

  void clear() {
    state = {};
  }
}
