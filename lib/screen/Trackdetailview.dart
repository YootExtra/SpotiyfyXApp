import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spotify/spotify.dart';
import 'package:spotifyxapp/assets/globalString.dart';
import 'package:http/http.dart' as http;

class Trackdetailview extends StatefulWidget {
  final Track Currentrack;

  const Trackdetailview({Key? key, required this.Currentrack})
      : super(key: key);

  @override
  _Trackdetailview createState() => _Trackdetailview();
}

class _Trackdetailview extends State<Trackdetailview> {
  String _test = "test";
  Future<String> dddd() async {
    return 'ddddsfdsfsdfrsfsifjsefjsefseijfesjfewosjfweoij$_test';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FeedData();
    Track _tempTrack = widget.Currentrack;
    print(_tempTrack.externalIds.toString());
    print(_tempTrack.externalUrls.toString());
    print('href: ${_tempTrack.href.toString()}');
    print(_tempTrack.previewUrl.toString());
    print(_tempTrack.uri.toString());
    print(_tempTrack.explicit.toString());
    print(_tempTrack.popularity.toString());

    // List<Market>? _tempMarget = [];
    // _tempMarget = _tempTrack.availableMarkets;
    // print("_tempMarget");
    // _tempMarget?.forEach((_marget) {
    //   print(_marget.index);
    //   print(_marget.name);
    //   print(_marget.runtimeType);
    //   print(_marget.hashCode);
    // });
  }

  Future<void> FeedData() async {
    var credentials = SpotifyApiCredentials(
        GlobalString.client_id, GlobalString.client_secret);
    var spotify = SpotifyApi(credentials);

    // Track _tempTrack = widget.Currentrack;
    // var resultTrack = await http.get(Uri.parse(_tempTrack.href.toString()));
    // print(resultTrack.body);
    // var playlist = await spotify.tracks.get(_tempTrack.id).
    // print(playlist.type)
  }

  Future<String> formatMilliseconds(int milliseconds) async {
    Duration duration = Duration(milliseconds: milliseconds);
    int seconds = duration.inSeconds % 60;
    int minutes = duration.inMinutes % 60;
    int hours = duration.inHours;

    String hoursStr = (hours < 10) ? '0$hours' : '$hours';
    String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondsStr = (seconds < 10) ? '0$seconds' : '$seconds';

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.Currentrack.name.toString()),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              child: ListView.builder(
                  itemCount: widget.Currentrack.album!.images!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    String _url =
                        widget.Currentrack.album!.images![index].url.toString();
                    return Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(_url), fit: BoxFit.contain)),
                    );
                  }),
              height: 250,
            ),
            Text('track name'),
            Text(
              widget.Currentrack.name.toString(),
              style: TextStyle(fontSize: 22.00),
            ),
            Text('artis name'),
            Wrap(
              children: widget.Currentrack.artists!.map((e) {
                return Text(e.name.toString(),
                    style: TextStyle(fontSize: 22.00));
              }).toList(),
            ),
            Text('duration time'),
            FutureBuilder(
                future: formatMilliseconds(widget.Currentrack.durationMs!),
                builder: (Context, Sanpshot) {
                  return Text(Sanpshot.data.toString(),
                      style: TextStyle(fontSize: 22.00));
                }),
          ],
        ),
      ),
    );
  }
}
