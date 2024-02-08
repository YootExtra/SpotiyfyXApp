import 'package:mobx/mobx.dart';

part 'ControllerStore.g.dart';

class ControllerStore = _ControllerStore with _$ControllerStore;

abstract class _ControllerStore with Store {
  @observable
  String tokenapi = "";

  @action
  void set_tokenapi(String NewValue) => tokenapi = NewValue;
}
