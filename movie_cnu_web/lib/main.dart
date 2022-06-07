import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_cnu_web/controllers/movie_controller.dart';
import 'package:movie_cnu_web/controllers/reserve_controller.dart';
import 'package:movie_cnu_web/controllers/user_manage_controller.dart';
import 'package:movie_cnu_web/screens/login_screen.dart';
import 'package:movie_cnu_web/screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDW_ZJZdPsiw0PyvJCa5wiOLRejNpiaJew",
        authDomain: "cnumovie-f27ec.firebaseapp.com",
        projectId: "cnumovie-f27ec",
        storageBucket: "cnumovie-f27ec.appspot.com",
        messagingSenderId: "515690828931",
        appId: "1:515690828931:web:70ddbc3f039d7fa87377b6",
        measurementId: "G-HC4YSYB8X4"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(MovieController());
        Get.put(UserManageController());
        Get.put(ReserveController());
      }),
      home: const LoginScreen(),
    );
  }
}
