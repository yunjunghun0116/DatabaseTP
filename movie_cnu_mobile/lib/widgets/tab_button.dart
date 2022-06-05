import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String text;
  const TabButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      child: Text(text),
    );
  }
}
