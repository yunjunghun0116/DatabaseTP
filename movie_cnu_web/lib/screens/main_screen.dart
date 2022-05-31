import 'package:flutter/material.dart';
import 'package:movie_cnu_web/constants.dart';
import 'package:movie_cnu_web/screens/customer_screen.dart';
import 'package:movie_cnu_web/screens/movie_screen.dart';
import 'package:movie_cnu_web/screens/reserve_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSplashBackgroundColor,
      body: Column(
        children: [
          TabBar(
            labelColor: kBlackColor,
            unselectedLabelColor: kGreyColor,
            controller: _tabController,
            tabs: [
              Container(
                height: 80,
                alignment: Alignment.center,
                child: const Text(
                  '영화조회',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 80,
                alignment: Alignment.center,
                child: const Text(
                  '회원조회',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 80,
                alignment: Alignment.center,
                child: const Text(
                  '예매조회',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                MovieScreen(),
                CustomerScreen(),
                ReserveScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
