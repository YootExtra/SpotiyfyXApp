import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/spotify.dart';
import 'package:spotifyxapp/assets/GlobalString.dart';
import 'package:spotifyxapp/model/SpotifyItem.dart';

class Albunlistview extends StatefulWidget {
  final AlbumSimple mapList;

  const Albunlistview({Key? key, required this.mapList}) : super(key: key);

  @override
  _Albunlistview createState() => _Albunlistview();
}

class _Albunlistview extends State<Albunlistview> {
  TextEditingController editingController = TextEditingController();
  late List<TrackSimple> DataList = [];
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
    var albumlist =
        await spotify.albums.getTracks(widget.mapList.id.toString()).all();
    List<TrackSimple> _tracksimple = [];
    albumlist.forEach((_track) {
      print(_track.id);
      print('track name: ${_track.name}');
      _track.artists!.forEach((_artis) {
        print('artis name: ${_artis.name}');
      });
      print(_track.uri);
      print(_track.href);
      _tracksimple.add(_track);
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
                TrackSimple item = DataList[index];
                // bool isInPlaylist = false;
                bool isInPlaylist = _isInPlaylist(item);
                List<Artist>? ListArtists = item.artists;
                return ListTile(
                  leading: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            widget.mapList.images![0].url.toString()),
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

  bool _isInPlaylist(TrackSimple item) {
    try {
      // List<SpotifyItem> playlist = storageDB.getItem("MyPlaylist") ?? [];
      List<TrackSimple> playlist = GlobalString.StoreDBTrackSimplelist;
      return playlist.any((element) => element.id == item.id);
    } catch (Ex) {
      return false;
    }
  }

  Future<void> _addToPlaylist(TrackSimple item) async {
    // List<SpotifyItem> playlist = storageDB.getItem("MyPlaylist") ?? [];
    List<TrackSimple> playlist = GlobalString.StoreDBTracklist;
    if (!_isInPlaylist(item)) {
      playlist.add(item);
    } else {
      playlist.removeWhere((element) => element.id == item.id);
    }
    final SharedPreferences dataLocal = await SharedPreferences.getInstance();
    setState(() {
      GlobalString.StoreDBTrackSimplelist = playlist;
      dataLocal.setString('DBTracklist', jsonEncode(playlist));
      // TabLibrary(dataParams: playlist);
      // storageDB.setItem("MyPlaylist", playlist);
    });
  }
}
