import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotifyxapp/api/SearchData.dart';
import 'package:spotifyxapp/model/SpotifyItem.dart';
import 'package:spotifyxapp/assets/GlobalString.dart';
import 'package:spotifyxapp/screen/tabview/TabLibrary.dart';

class TabSearch extends StatefulWidget {
  const TabSearch({Key? key}) : super(key: key);

  @override
  _TabSearchState createState() => _TabSearchState();
}

class _TabSearchState extends State<TabSearch> {
  List<SpotifyItem> listData = [];
  final LocalStorage storageDB = LocalStorage('SpotifyXDB.json');
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _onSearchTextChanged,
              controller: editingController,
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listData.length,
              itemBuilder: (context, index) {
                SpotifyItem item = listData[index];
                // bool isInPlaylist = false;
                bool isInPlaylist = _isInPlaylist(item);

                return ListTile(
                  leading: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(item.images),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text('Album Name: ${item.name}'),
                  subtitle: Text('Artist Name: ${item.artists}'),
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
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onSearchTextChanged(String value) async {
    List<SpotifyItem> result = await SearchData.search(value);
    setState(() {
      listData = result;
    });
  }

  bool _isInPlaylist(SpotifyItem item) {
    try {
      // List<SpotifyItem> playlist = storageDB.getItem("MyPlaylist") ?? [];
      List<SpotifyItem> playlist = GlobalString.StoreDBPlaylist;
      return playlist.any((element) => element.id == item.id);
    } catch (Ex) {
      return false;
    }
  }

  Future<void> _addToPlaylist(SpotifyItem item) async {
    // List<SpotifyItem> playlist = storageDB.getItem("MyPlaylist") ?? [];
    List<SpotifyItem> playlist = GlobalString.StoreDBPlaylist;
    if (!_isInPlaylist(item)) {
      playlist.add(item);
    } else {
      playlist.removeWhere((element) => element.id == item.id);
    }
    final SharedPreferences dataLocal = await SharedPreferences.getInstance();
    setState(() {
      GlobalString.StoreDBPlaylist = playlist;
      dataLocal.setString('DBPlatlist', jsonEncode(playlist));
      // TabLibrary(dataParams: playlist);
      // storageDB.setItem("MyPlaylist", playlist);
    });
  }
}
