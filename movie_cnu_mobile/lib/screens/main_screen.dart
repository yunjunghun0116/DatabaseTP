import 'package:flutter/material.dart';
import 'package:movie_cnu_mobile/controllers/user_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(UserController.to.user!.name);
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
