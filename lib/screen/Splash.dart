import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:spotifyxapp/assets/globalString.dart';

class Splash extends StatefulWidget {
  // const Splash({Key key}) : super(key: key);

  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  late List<Map<String, dynamic>> ListBoxView = [];
  late List<Map<String, dynamic>> ListBoxViewReleases = [];

  @override
  Widget build(BuildContext context) {
    void _buttonPressed() async {
      var credentials = SpotifyApiCredentials(
          GlobalString.client_id, GlobalString.client_secret);
      print(credentials);
      var spotify = SpotifyApi(credentials);
      print(spotify);

      print('\nArtists:');
      var artists = await spotify.artists.list(['0OdUWJ0sBjDrqHygGUXeCF']);
      artists.forEach((x) => print(x.name));

      print('\nAlbum:');
      var album = await spotify.albums.get('2Hog1V8mdTWKhCYqI5paph');
      print(album.name);

      print('\nAlbum Tracks:');
      var tracks = await spotify.albums.getTracks(album.id!).all();
      tracks.forEach((track) {
        print(track.name);
      });

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
      print('\nUser\'s playlists:');
      var usersPlaylists =
          await spotify.playlists.getUsersPlaylists('superinteressante').all();
      usersPlaylists.forEach((playlist) {
        print(playlist.name);
        print(playlist.description);
      });

      print("\nSearching for \'Metallica\':");
      var search = await spotify.search.get('metallica').first(2);
      print('data search');
      print(search);
      search.forEach((pages) {
        if (pages.items == null) {
          print('Empty items');
        }
        pages.items!.forEach((item) {
          if (item is PlaylistSimple) {
            print('Playlist: \n'
                'id: ${item.id}\n'
                'name: ${item.name}:\n'
                'collaborative: ${item.collaborative}\n'
                'href: ${item.href}\n'
                'trackslink: ${item.tracksLink!.href}\n'
                'owner: ${item.owner}\n'
                'public: ${item.owner}\n'
                'snapshotId: ${item.snapshotId}\n'
                'type: ${item.type}\n'
                'uri: ${item.uri}\n'
                'images: ${item.images!.length}\n'
                '-------------------------------');
          }
          if (item is Artist) {
            print('Artist: \n'
                'id: ${item.id}\n'
                'name: ${item.name}\n'
                'href: ${item.href}\n'
                'type: ${item.type}\n'
                'uri: ${item.uri}\n'
                'popularity: ${item.popularity}\n'
                '-------------------------------');
          }
          if (item is Track) {
            print('Track:\n'
                'id: ${item.id}\n'
                'name: ${item.name}\n'
                'href: ${item.href}\n'
                'type: ${item.type}\n'
                'uri: ${item.uri}\n'
                'isPlayable: ${item.isPlayable}\n'
                'artists: ${item.artists!.length}\n'
                'availableMarkets: ${item.availableMarkets!.length}\n'
                'discNumber: ${item.discNumber}\n'
                'trackNumber: ${item.trackNumber}\n'
                'explicit: ${item.explicit}\n'
                'popularity: ${item.popularity}\n'
                '-------------------------------');
          }
          if (item is AlbumSimple) {
            print('Album:\n'
                'id: ${item.id}\n'
                'name: ${item.name}\n'
                'href: ${item.href}\n'
                'type: ${item.type}\n'
                'uri: ${item.uri}\n'
                'albumType: ${item.albumType}\n'
                'artists: ${item.artists!.length}\n'
                'availableMarkets: ${item.availableMarkets!.length}\n'
                'images: ${item.images!.length}\n'
                'releaseDate: ${item.releaseDate}\n'
                'releaseDatePrecision: ${item.releaseDatePrecision}\n'
                '-------------------------------');
          }
        });
      });

      // await SpotifySdk.connectToSpotifyRemote(
      //     clientId: "ad75e46c095940b4a11dec0ae979de2d",
      //     redirectUrl: "com.example.spotifyxapp://");
      // var accessToken = await SpotifySdk.getAccessToken(
      //     clientId: "ad75e46c095940b4a11dec0ae979de2d",
      //     redirectUrl: "com.example.spotifyxapp://",
      //     scope:
      //         "app-remote-control,user-modify-playback-state,playlist-read-private");
      // print(accessToken);
      // var resultToken = await Posttoken();
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString("TokenAPI", resultToken.access_token);
      // String resultAnth = await Getauthorize();
      // print(resultAnth);
      // prefs.setString('LoginHTML', resultAnth);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => LoginSpotify(htmlContent: resultAnth)));
    }

    List<String> ListImageView = [];
    return Scaffold(
        appBar: AppBar(
          title: Text('Splash Screen'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Text(
              "Welcome to SpotifyXApp!",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            SizedBox(
              height: 45,
            ),
            ElevatedButton(onPressed: _buttonPressed, child: Text('Login!!')),
          ],
        ));
  }
}
