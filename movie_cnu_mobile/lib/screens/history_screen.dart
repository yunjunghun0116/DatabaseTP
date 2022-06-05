import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final int statusIndex;
  const HistoryScreen({Key? key, required this.statusIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('index : $statusIndex'),),
    );
  }
}
