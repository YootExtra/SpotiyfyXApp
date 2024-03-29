import 'package:spotify/spotify.dart';

class SpotifyItem {
  String id;
  String name;
  String href;
  String type;
  String uri;
  String albumType;
  List<ArtistSimple> artists;
  List<Market> availableMarkets;
  List<Image> images;
  String releaseDate;

  SpotifyItem({
    required this.id,
    required this.name,
    required this.href,
    required this.type,
    required this.uri,
    required this.albumType,
    required this.artists,
    required this.availableMarkets,
    required this.images,
    required this.releaseDate,
  });

  // factory SpotifyItem.fromJson(Map<String, dynamic> json) {
  //   return SpotifyItem(
  //       id: json['id'],
  //       name: json['name'],
  //       href: json['href'],
  //       type: json['type'],
  //       uri: json['uri'],
  //       albumType: json['albumType'],
  //       artists: json['artists'],
  //       availableMarkets: json['availableMarkets'],
  //       images: json['images'],
  //       releaseDate: json['releaseDate'],
  //       releaseDatePrecision: json['releaseDatePrecision']);
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'href': href,
  //     'type': type,
  //     'uri': uri,
  //     'albumType': albumType,
  //     'artists': artists,
  //     'availableMarkets': availableMarkets,
  //     'images': images,
  //     'releaseDate': releaseDate,
  //     'releaseDatePrecision': releaseDatePrecision
  //   };
  // }
}
