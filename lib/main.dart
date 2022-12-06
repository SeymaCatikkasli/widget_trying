import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _items = List.generate(
      20,
      (index) => {
            "id": index,
            "title": "Item $index",
            "content":
                "This is the main content of item $index. It is very long and you have to expand the tile to see it."
          });

  void _removeItem(int id) {
    setState(() {
      _items.removeWhere((element) => element['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 600),
        content: Text('Item with id #$id has been removed')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Expansion Tile')),
        body: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (_, index) {
              final item = _items[index];
              return Card(
                key: PageStorageKey(item['id']),
                color: Colors.grey,
                elevation: 4,
                  child: ExpansionTile(
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      childrenPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      expandedCrossAxisAlignment: CrossAxisAlignment.end,
                    title: Text(item['title'], style: const TextStyle(
                      color: Color.fromARGB(255, 248, 208, 208)
                    ),),
                      children: [
                        Text(item['content'], style: const TextStyle(
                            color: Colors.white
                        )),
                        // This button is used to remove this item
                        IconButton(onPressed:  () => _removeItem(index),
                            icon: const Icon(Icons.delete, color: Colors.redAccent,))
                      ]
                  ),
              );
            }));
  }
}