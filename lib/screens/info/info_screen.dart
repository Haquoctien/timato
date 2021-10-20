import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("App info"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Author"),
            subtitle: Text("Hà Quốc Tiến"),
          ),
          Divider(),
          ListTile(
            title: Text("Version"),
            subtitle: Text("1.0.0"),
          ),
          Divider(),
        ],
      ),
    );
  }
}
