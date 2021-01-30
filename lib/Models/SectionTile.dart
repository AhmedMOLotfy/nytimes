import 'package:flutter/material.dart';

class SectionTile extends StatelessWidget {
  final IconData icon;
  final String text;
  SectionTile({@required this.text, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
    );
  }
}
