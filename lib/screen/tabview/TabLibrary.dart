import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:spotifyxapp/model/SpotifyItem.dart';
import 'package:spotifyxapp/assets/GlobalString.dart';

class TabLibrary extends StatefulWidget {
  // final List<SpotifyItem> dataParams; // Define the parameter

  // const TabLibrary({Key? key, required this.dataParams}) : super(key: key);

  @override
  _TabLibraryState createState() => _TabLibraryState();
}

class _TabLibraryState extends State<TabLibrary> {
  List<SpotifyItem> listData = [];

  final LocalStorage storageDB = LocalStorage('SpotifyXDB.json');

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if the tab is being opened again and reload data
    if (ModalRoute.of(context)!.isCurrent) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    await storageDB.ready;
    setState(() {
      listData = List<SpotifyItem>.from(
          GlobalString.StoreDBPlaylist); // Initialize listData with dataParams
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Library',
              style: TextStyle(
                  fontSize: 30, color: Color.fromARGB(255, 23, 14, 91)),
            ),
          ),
          Expanded(
            child: listData.isEmpty
                ? Center(
                    child: Text('Your playlist is empty.'),
                  )
                : ListView.builder(
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      SpotifyItem currentItem = listData[index];

                      return ListTile(
                        leading: Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(currentItem.images),
                            ),
                          ),
                        ),
                        title: Text('Album Name: ${currentItem.name}'),
                        subtitle: Text('Artist Name: ${currentItem.artists}'),
                        trailing: IconButton(
                          onPressed: () {
                            _removeFromPlaylist(currentItem);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _removeFromPlaylist(SpotifyItem item) {
    setState(() {
      listData.remove(item);
      GlobalString.StoreDBPlaylist = listData;
      // LocalStorage('SpotifyXDB.json').setItem('MyPlaylist', listData);
    });
  }
}
