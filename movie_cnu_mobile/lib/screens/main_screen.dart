import 'package:flutter/material.dart';
import 'package:movie_cnu_mobile/constants.dart';
import 'package:movie_cnu_mobile/controllers/user_controller.dart';
import 'package:movie_cnu_mobile/screens/history_screen.dart';
import 'package:movie_cnu_mobile/screens/login_screen.dart';
import 'package:movie_cnu_mobile/screens/movie_screen.dart';
import 'package:movie_cnu_mobile/screens/search_screen.dart';

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
      case 2:
      case 3:
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
              _drawerTile(context, '예매내역', () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                setState(() {
                  _currentIndex = 1;
                });
              }),
              _drawerTile(context, '취소내역', () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                setState(() {
                  _currentIndex = 2;
                });
              }),
              _drawerTile(context, '지난관람내역', () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                setState(() {
                  _currentIndex = 3;
                });
              }),
              const Spacer(),
              _drawerTile(context, '로그아웃', () async {
                var navigator = Navigator.of(context);
                await UserController.to.signOut();
                navigator.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }), (route) => false);
              }),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kBlackColor,
        elevation: 1,
        title: const Text('CNU Movie'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SearchScreen();
            })),
            icon: const Icon(Icons.search_outlined),
          ),
        ],
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
