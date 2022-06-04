import 'package:get/get.dart';

import '../models/user.dart';
import '../services/firebase_services.dart';

class UserController extends GetxController{
  static UserController get to => Get.find();

  User? user;
  final FirebaseService _firebaseService = FirebaseService();
}