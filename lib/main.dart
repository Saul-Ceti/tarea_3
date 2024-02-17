import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tarea_3/data/data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu demo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = -1;

  late Map<String, dynamic> platillos;

  @override
  void initState() {
    super.initState();
    platillos = jsonDecode(PLATILLOS);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu demo'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "Explore the restaurant's delicious menu items below!",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: platillos.length,
              itemBuilder: (context, index) {
                final platillo = platillos.values.elementAt(index);
                return ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      platillo['image'],
                      width: 50.0,
                      height: 50.0,
                    ),
                  ),
                  title: Text(platillo['name']),
                  subtitle: Text(platillo['description']),
                  selected: _selectedIndex == index,
                  selectedTileColor: Colors.blue,
                  onTap: () {
                    setState(() {
                      _selectedIndex = _selectedIndex == index ? -1 : index;
                    });
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showDeliveryDialog(context, _getSelectedItem());
                },
                child: const Text("Delivery"),
              ),
              ElevatedButton(
                onPressed: () {
                  _showPickUpDialog(context, _getSelectedItem());
                },
                child: const Text("Pick up"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  dynamic _getSelectedItem() {
    if (_selectedIndex != -1) {
      return platillos.values.elementAt(_selectedIndex);
    }
    return null;
  }

  void _showDeliveryDialog(BuildContext context, dynamic selectedItem) {
    String title = "Delivery";
    String content =
        selectedItem != null ? selectedItem['name'] : "Selecciona un platillo primero";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showPickUpDialog(BuildContext context, dynamic selectedItem) {
    String title = "Pick up";
    String content =
        selectedItem != null ? selectedItem['name'] : "Selecciona un platillo primero";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}