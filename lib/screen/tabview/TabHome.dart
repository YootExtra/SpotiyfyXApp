import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:spotify/spotify.dart';
import 'package:spotifyxapp/assets/GlobalString.dart';
import 'package:spotifyxapp/screen/Playlistview.dart';
import 'package:spotifyxapp/screen/Albunlistview.dart';
import 'package:spotifyxapp/model/SpotifyItem.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  _TabHome createState() => _TabHome();
}

class _TabHome extends State<TabHome> {
  late List<Map<String, dynamic>> ListBoxView = [];
  late List<Map<String, dynamic>> ListBoxViewReleases = [];
  late List<AlbumSimple> ListAlbumReleases = [];
  late List<PlaylistSimple> ListPlaylistFeatured = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feedDataSpotify();
  }

  Future<void> feedDataSpotify() async {
    var credentials = SpotifyApiCredentials(
        GlobalString.client_id, GlobalString.client_secret);
    var spotify = SpotifyApi(credentials);

// print('\nNew Releases');
    var newReleases = await spotify.browse.getNewReleases().first();
    List<Map<String, dynamic>> TempListBoxViewReleases = [];
    List<AlbumSimple> _tempListAlbumReleases = [];
    newReleases.items!.forEach((album) {
      Map<String, dynamic> _tempViewReleases = {
        'id': album.id,
        'name': album.name,
        'images': album.images![0].url
      };
      _tempListAlbumReleases.add(album);
      TempListBoxViewReleases.add(_tempViewReleases);
    });

    // print('\nFeatured Playlist:');
    var featuredPlaylists = await spotify.playlists.featured.all();
    List<Map<String, dynamic>> Tempplaylist = [];
    List<PlaylistSimple> _tempListPlaylistFeatured = [];
    featuredPlaylists.forEach((playlist) {
      _tempListPlaylistFeatured.add(playlist);
    });
    setState(() {
      ListBoxView = Tempplaylist;
      ListBoxViewReleases = TempListBoxViewReleases;
      ListAlbumReleases = _tempListAlbumReleases;
      ListPlaylistFeatured = _tempListPlaylistFeatured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: EdgeInsets.all(10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to SpotifyXApp!",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            SizedBox(
              height: 45,
            ),
            Text(
              'New Releases',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.start,
              selectionColor: const Color.fromARGB(255, 44, 5, 112),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: 250.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: ListAlbumReleases.length,
                      itemBuilder: (BuildContext context, int index) {
                        AlbumSimple mapList = ListAlbumReleases[index];

                        return SizedBox(
                          width: 160,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Albunlistview(mapList: mapList)));
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(mapList
                                                .images![0].url
                                                .toString()))),
                                  ),
                                  Text(
                                    mapList.name.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  // Text(mapList['description'])
                                ]),
                          ),
                        );
                      })),
            ),
            Text(
              'Featured Playlist',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.start,
              selectionColor: const Color.fromARGB(255, 44, 5, 112),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: 250.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: ListPlaylistFeatured.length,
                      itemBuilder: (BuildContext context, int index) {
                        PlaylistSimple mapList = ListPlaylistFeatured[index];

                        return SizedBox(
                            width: 160,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Playlistview(mapList: mapList)));
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(mapList
                                                    .images![0].url
                                                    .toString()))),
                                      ),
                                      Text(
                                        mapList.name.toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ])
                                // Text(mapList['description'])
                                ));
                      })),
            ),
          ],
        ));
  }
}
