import 'package:mobx/mobx.dart';

part 'active_page_state.g.dart';

class ActivePageState = _ActivePageState with _$ActivePageState;

abstract class _ActivePageState with Store {
  @observable
  int activePage = 0;

  @action
  void changeActivePage(int page) {
    activePage = page;
  }
}
