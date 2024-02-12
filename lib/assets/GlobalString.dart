import 'package:spotify/spotify.dart';
import 'package:spotifyxapp/model/SpotifyItem.dart';

class GlobalString {
  static String client_id = 'ad75e46c095940b4a11dec0ae979de2d';
  static String client_secret = '9a4368ad1a744da9bae821357493adcf';
  static List<SpotifyItem> StoreDBPlaylist = [];
  static List<Track> StoreDBTracklist = [];
  static List<TrackSimple> StoreDBTrackSimplelist = [];
}
