import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:spotify/spotify.dart';
import 'package:spotifyxapp/assets/GlobalString.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  _TabHome createState() => _TabHome();
}

class _TabHome extends State<TabHome> {
  late List<Map<String, dynamic>> ListBoxView = [];
  late List<Map<String, dynamic>> ListBoxViewReleases = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feedDataSpotify();
  }

  void feedDataSpotify() async {
    var credentials = SpotifyApiCredentials(
        GlobalString.client_id, GlobalString.client_secret);
    var spotify = SpotifyApi(credentials);

// print('\nNew Releases');
    var newReleases = await spotify.browse.getNewReleases().first();
    List<Map<String, dynamic>> TempListBoxViewReleases = [];
    newReleases.items!.forEach((album) {
      Map<String, dynamic> _tempViewReleases = {
        'id': album.id,
        'name': album.name,
        'images': album.images![0].url
      };
      TempListBoxViewReleases.add(_tempViewReleases);
    });

    // print('\nFeatured Playlist:');
    var featuredPlaylists = await spotify.playlists.featured.all();
    List<Map<String, dynamic>> Tempplaylist = [];
    featuredPlaylists.forEach((playlist) {
      Map<String, dynamic> _Tempplaylist = {
        'id': playlist.id,
        'name': playlist.name,
        'description': playlist.description,
        'images': playlist.images![0].url
      };
      Tempplaylist.add(_Tempplaylist);
    });
    setState(() {
      ListBoxView = Tempplaylist;
      ListBoxViewReleases = TempListBoxViewReleases;
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
                      itemCount: ListBoxViewReleases.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> mapList =
                            ListBoxViewReleases[index];
                        String imageUrl = mapList["images"];

                        return SizedBox(
                          width: 160,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(imageUrl))),
                                ),
                                Text(
                                  mapList['name'],
                                  style: TextStyle(fontSize: 18),
                                ),
                                // Text(mapList['description'])
                              ]),
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
                      itemCount: ListBoxView.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> mapList = ListBoxView[index];
                        String imageUrl = mapList["images"];

                        return SizedBox(
                          width: 160,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(imageUrl))),
                                ),
                                Text(
                                  mapList['name'],
                                  style: TextStyle(fontSize: 18),
                                ),
                                // Text(mapList['description'])
                              ]),
                        );
                      })),
            ),
          ],
        ));
  }
}
