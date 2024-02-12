import 'package:mobx/mobx.dart';
import 'package:spotifyxapp/model/SpotifyItem.dart';
part 'ControllerStore.g.dart';

class ControllerStore = _ControllerStore with _$ControllerStore;

abstract class _ControllerStore with Store {
  @observable
  String tokenapi = "";

  @observable
  List<SpotifyItem> ListOfLib = [];

  @action
  void set_tokenapi(String NewValue) => tokenapi = NewValue;

  @action
  void setItemList(SpotifyItem _item) {
    ListOfLib.add(_item);
  }
}
