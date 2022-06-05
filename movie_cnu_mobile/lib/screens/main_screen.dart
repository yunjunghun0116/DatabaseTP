import 'package:flutter/material.dart';
import 'package:movie_cnu_mobile/constants.dart';
import 'package:movie_cnu_mobile/controllers/user_controller.dart';
import 'package:movie_cnu_mobile/screens/history_screen.dart';
import 'package:movie_cnu_mobile/screens/movie_screen.dart';
import 'package:movie_cnu_mobile/screens/theater_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  Widget _getScreen() {
    switch (_currentIndex) {
      case 0:
        return const MovieScreen();
      case 1:
        return const TheaterScreen();
      case 2:
      case 3:
      case 4:
        return HistoryScreen(statusIndex: _currentIndex);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _drawerTile(context, '영화보기', () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                setState(() {
                  _currentIndex = 0;
                });
              }),
              _drawerTile(context, '상영관보기', () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                setState(() {
                  _currentIndex = 1;
                });
              }),
              _drawerTile(context, '예매내역', () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                setState(() {
                  _currentIndex = 2;
                });
              }),
              _drawerTile(context, '취소내역', () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                setState(() {
                  _currentIndex = 3;
                });
              }),
              _drawerTile(context, '지난관람내역', () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                setState(() {
                  _currentIndex = 4;
                });
              }),
              Spacer(),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Text('로그아웃'),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kBlackColor,
        elevation: 1,
        title: const Text('CNU Movie'),
      ),
      body: _getScreen(),
    );
  }
}

ListTile _drawerTile(BuildContext context, String title, Function function) {
  return ListTile(
    title: Text(title),
    hoverColor: kGreyColor,
    onTap: () => function(),
  );
}
