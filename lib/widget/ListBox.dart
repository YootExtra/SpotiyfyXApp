import 'package:flutter/material.dart';

class ListBox extends StatefulWidget {
  final List<Map<String, dynamic>> listdata;

  ListBox({required this.listdata});

  @override
  _ListBox createState() => _ListBox();
}

class _ListBox extends State<ListBox> {
  late List<Map<String, dynamic>> _listdata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listdata = widget.listdata;
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Horizontal List';
    // return Column(children: [
    //   listdata.expand((_item) => {
    // Map<String, dynamic> mapList = _item;
    // String name = mapList['name'];
    // String description = mapList['description'];

    // return ListTile(
    //   title: Text('Name: $name'),
    //   subtitle: Text('Age: $description'),
    // );

    //   })
    // ]);
    return Container(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _listdata.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> mapList = _listdata[index];
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
                            image:
                                DecorationImage(image: NetworkImage(imageUrl))),
                      ),
                      Text(
                        mapList['name'],
                        style: TextStyle(fontSize: 18),
                      ),
                    ]),
              );
            }));
  }
}
