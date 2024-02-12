import 'package:spotify/spotify.dart';
import 'package:spotifyxapp/assets/GlobalString.dart';
import 'package:spotifyxapp/model/SpotifyItem.dart';

class SearchData {
  static Future<AlbumSimple> searchAlbum(String query) async {
    if (query == '') {
      return AlbumSimple();
    }
    var credentials = SpotifyApiCredentials(
        GlobalString.client_id, GlobalString.client_secret);
    print(credentials);
    var spotify = SpotifyApi(credentials);

    AlbumSimple resultsearch = await spotify.albums.get(query);

    return resultsearch;
  }

  static Future<Track> searchTrack(String query) async {
    if (query == '') {
      return Track();
    }
    var credentials = SpotifyApiCredentials(
        GlobalString.client_id, GlobalString.client_secret);
    print(credentials);
    var spotify = SpotifyApi(credentials);

    Track resultsearch = await spotify.tracks.get(query);

    return resultsearch;
    // return await spotify.search.get(query).first(2);
  }

  static Future<List<SpotifyItem>> search(String query) async {
    if (query == '') {
      return List<SpotifyItem>.empty();
    }
    var credentials = SpotifyApiCredentials(
        GlobalString.client_id, GlobalString.client_secret);
    print(credentials);
    var spotify = SpotifyApi(credentials);

    var resultsearch = await spotify.search.get(query).first(50);
    List<SpotifyItem> resultMap = [];
    print(resultsearch);
    resultsearch.forEach((ItemPages) {
      // print(ItemPages);
      ItemPages.items!.forEach((_item) {
        print(_item.type);
        if (_item is AlbumSimple) {
          SpotifyItem mapText = SpotifyItem(
              id: _item.id ?? "",
              name: _item.name ?? "",
              href: _item.href ?? "",
              type: _item.type ?? "",
              uri: _item.uri ?? "",
              albumType: _item.albumType.toString(),
              artists: _item.artists ?? [],
              availableMarkets: _item.availableMarkets ?? [],
              // availableMarkets: _item.availableMarkets![0].name,
              images: _item.images ?? [],
              releaseDate: _item.releaseDate ?? "");
          mapText.id = _item.id!;
          resultMap.add(mapText);
        }
      });
    });
    return resultMap;
    // return await spotify.search.get(query).first(2);
  }
}
