// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ControllerStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ControllerStore on _ControllerStore, Store {
  late final _$tokenapiAtom =
      Atom(name: '_ControllerStore.tokenapi', context: context);

  @override
  String get tokenapi {
    _$tokenapiAtom.reportRead();
    return super.tokenapi;
  }

  @override
  set tokenapi(String value) {
    _$tokenapiAtom.reportWrite(value, super.tokenapi, () {
      super.tokenapi = value;
    });
  }

  late final _$_ControllerStoreActionController =
      ActionController(name: '_ControllerStore', context: context);

  @override
  void set_tokenapi(String NewValue) {
    final _$actionInfo = _$_ControllerStoreActionController.startAction(
        name: '_ControllerStore.set_tokenapi');
    try {
      return super.set_tokenapi(NewValue);
    } finally {
      _$_ControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tokenapi: ${tokenapi}
    ''';
  }
}
