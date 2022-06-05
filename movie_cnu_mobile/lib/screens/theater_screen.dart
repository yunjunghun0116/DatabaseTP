import 'package:flutter/material.dart';

class TheaterScreen extends StatelessWidget {
  const TheaterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('영화상영관'),
      ),
    );
  }
}
