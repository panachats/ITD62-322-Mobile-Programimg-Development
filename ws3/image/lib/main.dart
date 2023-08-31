import 'package:flutter/material.dart';

import 'contact.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<Widget> getnerate(int count) {
    List<Widget> textWidget = [];
    for (var i = 0; i < count; i++) {
      ListTile item = ListTile(
        leading: Text("$i",
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
        title: Text("Title $i"),
        subtitle: Text("Sub $i"),
        trailing: Icon(Icons.navigate_next_rounded),
        onTap: () {},
      );
      textWidget.add(item);
    }
    return textWidget;
  }

  @override
  Widget build(BuildContext context) {
    Contact contact = Contact(
        "Panachat",
        "0644561415",
        "https://cdn-icons-png.flaticon.com/128/837/837560.png",
        "images/01.png");
    List<Contact> contactList = [
      contact,
      Contact(
          "ChatAiam",
          "0844561415",
          "https://cdn-icons-png.flaticon.com/128/837/837560.png",
          "images/01.png"),
      Contact(
          "AiamChat",
          "0744561415",
          "https://cdn-icons-png.flaticon.com/128/837/837560.png",
          "images/01.png")
    ];
    return Scaffold(
      appBar: AppBar(title: Text("Contact List")),
      // body: ListView(children: getnerate(100)),
      body: ListView.builder(
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          Contact item = contactList[index];
          return ListTile(
            leading: Image.network(item.iTcon),
            title: Text(item.name),
            subtitle: Text(item.phoneNumber),
            trailing: Image.asset(item.aIcon),
            onTap: () {},
          );
        },
      ),
    );
  }
}
