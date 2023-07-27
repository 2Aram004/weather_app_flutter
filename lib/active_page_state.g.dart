// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_page_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ActivePageState on _ActivePageState, Store {
  late final _$activePageAtom =
      Atom(name: '_ActivePageState.activePage', context: context);

  @override
  int get activePage {
    _$activePageAtom.reportRead();
    return super.activePage;
  }

  @override
  set activePage(int value) {
    _$activePageAtom.reportWrite(value, super.activePage, () {
      super.activePage = value;
    });
  }

  late final _$_ActivePageStateActionController =
      ActionController(name: '_ActivePageState', context: context);

  @override
  void changeActivePage(int page) {
    final _$actionInfo = _$_ActivePageStateActionController.startAction(
        name: '_ActivePageState.changeActivePage');
    try {
      return super.changeActivePage(page);
    } finally {
      _$_ActivePageStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
activePage: ${activePage}
    ''';
  }
}
