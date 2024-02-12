import 'package:flutter/material.dart';
import 'package:spotifyxapp/assets/GlobalString.dart';
import 'package:spotifyxapp/screen/tabview/TabHome.dart';
import 'package:spotifyxapp/screen/tabview/TabSearch.dart';
import 'package:spotifyxapp/screen/tabview/TabLibrary.dart';

class Maintab extends StatefulWidget {
  @override
  _MaintabState createState() => _MaintabState();
}

class _MaintabState extends State<Maintab> {
  int _currentIndex = 0;
  // final List<Widget> _screens = [
  //   TabHome(),
  //   TabSearch(), // Pass reload callback
  //   TabLibrary(
  //     dataParams: GlobalString.StoreDBPlaylist,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          // appBar: AppBar(
          // bottom: TabBar(tabs: [
          //   Tab(icon: Icon(Icons.home)),
          //   Tab(icon: Icon(Icons.search)),
          //   Tab(icon: Icon(Icons.library_books))
          // ]),
          // title: Text("SpotifyXApp")),
          bottomNavigationBar: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.all(10.0),
              // labelColor: Colors.purple,
              // indicatorColor: Colors.purple,
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.home,
                  size: 30,
                )),
                Tab(
                    icon: Icon(
                  Icons.search,
                  size: 30,
                )),
                Tab(
                    icon: Icon(
                  Icons.library_books,
                  size: 30,
                ))
              ]),
          body: TabBarView(children: [TabHome(), TabSearch(), TabLibrary()]),
        ));
    // return MaterialApp(
    //   title: 'Flutter TabView Example',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: Scaffold(
    //     body: IndexedStack(
    //       index: _currentIndex,
    //       children: _screens,
    //     ),
    //     bottomNavigationBar: BottomNavigationBar(
    //       currentIndex: _currentIndex,
    //       onTap: (index) {
    //         setState(() {
    //           _currentIndex = index;
    //         });
    //       },
    //       items: [
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.home),
    //           label: 'Home',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.search),
    //           label: 'Search',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.library_books),
    //           label: 'Profile',
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
