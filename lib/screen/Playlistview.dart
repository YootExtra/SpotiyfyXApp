import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/spotify.dart';
import 'package:spotifyxapp/assets/GlobalString.dart';
import 'package:spotifyxapp/model/SpotifyItem.dart';
import 'package:spotifyxapp/screen/Trackdetailview.dart';

class Playlistview extends StatefulWidget {
  final PlaylistSimple mapList;

  const Playlistview({Key? key, required this.mapList}) : super(key: key);

  @override
  _Playlistview createState() => _Playlistview();
}

class _Playlistview extends State<Playlistview> {
  TextEditingController editingController = TextEditingController();
  late List<Track> DataList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FeedData();
  }

  Future<void> FeedData() async {
    print(widget.mapList);
    var credentials = SpotifyApiCredentials(
        GlobalString.client_id, GlobalString.client_secret);
    var spotify = SpotifyApi(credentials);
    print('\nAlbum Tracks:');
    print(widget.mapList.id);
    var playlist =
        await spotify.playlists.getTracksByPlaylistId(widget.mapList.id).all();
    List<Track> _tracksimple = [];
    playlist.forEach((track) {
      print(track.id);
      print('track name: ${track.name}');
      track.artists!.forEach((_artis) {
        print('artis name: ${_artis.name}');
      });
      print(track.uri);
      print(track.href);
      _tracksimple.add(track);
    });
    setState(() {
      DataList = _tracksimple;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.mapList.name.toString()),
        ),
        body: SafeArea(
          minimum: EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: DataList.length,
              itemBuilder: (context, index) {
                Track item = DataList[index];
                // bool isInPlaylist = false;
                bool isInPlaylist = _isInPlaylist(item);
                List<Artist>? ListArtists = item.artists;
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Trackdetailview(Currentrack: item)));
                  },
                  leading: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage(item.album!.images![0].url.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text('track name: ${item.name}'),
                  subtitle: Wrap(
                    children: ListArtists!.map((_art) {
                      return Text(' ${_art.name.toString()}');
                    }).toList(),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isInPlaylist ? Icons.star : Icons.star_outline,
                      color:
                          isInPlaylist ? Color.fromARGB(255, 37, 6, 120) : null,
                    ),
                    onPressed: () {
                      _addToPlaylist(item);
                    },
                  ),
                );
              }),
        ));
  }

  bool _isInPlaylist(Track item) {
    try {
      // List<SpotifyItem> playlist = storageDB.getItem("MyPlaylist") ?? [];
      List<SpotifyItem> playlist = GlobalString.StoreDBPlaylist;
      return playlist.any((element) => element.id == item.id);
    } catch (Ex) {
      return false;
    }
  }

  Future<void> _addToPlaylist(Track item) async {
    // List<SpotifyItem> playlist = storageDB.getItem("MyPlaylist") ?? [];
    List<SpotifyItem> playlist = GlobalString.StoreDBPlaylist;
    if (!_isInPlaylist(item)) {
      SpotifyItem _tempItem = SpotifyItem(
          id: item.id.toString(),
          name: item.name.toString(),
          href: item.href.toString(),
          type: item.type.toString(),
          uri: item.uri.toString(),
          albumType: "",
          artists: [],
          availableMarkets: item.album!.availableMarkets ?? [],
          images: item.album!.images ?? [],
          releaseDate: item.album!.releaseDate.toString());
      playlist.add(_tempItem);
    } else {
      playlist.removeWhere((element) => element.id == item.id);
    }
    final SharedPreferences dataLocal = await SharedPreferences.getInstance();
    setState(() {
      GlobalString.StoreDBPlaylist = playlist;
    });
  }
}
