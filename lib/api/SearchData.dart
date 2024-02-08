import 'package:spotify/spotify.dart';
import 'package:spotifyxapp/assets/GlobalString.dart';
import 'package:spotifyxapp/model/SpotifyItem.dart';

class SearchData {
  static Future<List<SpotifyItem>> search(String query) async {
    if (query == '') {
      return List<SpotifyItem>.empty();
    }
    var credentials = SpotifyApiCredentials(
        GlobalString.client_id, GlobalString.client_secret);
    print(credentials);
    var spotify = SpotifyApi(credentials);

    List<Page<dynamic>> resultsearch =
        await spotify.search.get(query).first(50);
    List<SpotifyItem> resultMap = [];
    print(resultsearch);
    resultsearch.forEach((ItemPages) {
      ItemPages.items!.forEach((_item) {
        if (_item is AlbumSimple) {
          SpotifyItem mapText = SpotifyItem(
            id: _item.id ?? "",
            name: _item.name ?? "",
            href: _item.href ?? "",
            type: _item.type ?? "",
            uri: _item.uri ?? "",
            albumType: _item.albumType.toString(),
            artists: _item.artists![0].name ?? "",
            availableMarkets: _item.availableMarkets![0].name,
            images: _item.images![0].url ?? "",
            releaseDate: _item.releaseDate ?? "",
            releaseDatePrecision: _item.releaseDatePrecision.toString(),
          );
          mapText.id = _item.id!;
          resultMap.add(mapText);
        }
      });
    });
    return resultMap;
    // return await spotify.search.get(query).first(2);
  }
}
