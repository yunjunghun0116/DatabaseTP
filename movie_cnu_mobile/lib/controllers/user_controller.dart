import 'package:get/get.dart';

import '../models/user.dart';
import '../services/firebase_services.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  User? user;
  final FirebaseService _firebaseService = FirebaseService();

  Future<bool> registerUser(String id, Map<String, dynamic> userInfo) async {
    bool result = await _firebaseService.registerUser(id, userInfo);
    if (result) {
      user = User.fromJson(userInfo);
      update();
    }
    return result;
  }

  Future<bool> loginUser(String email, String password) async {
    User? result = await _firebaseService.loginUser(email, password);
    if (result != null) {
      user = result;
      update();
      return true;
    }
    return false;
  }

  Future<void> signOut()async {
    user = null;
    update();
  }
}
