import 'package:get/get.dart';

import '../models/user.dart';
import '../services/firebase_services.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  User? user;
  final FirebaseService _firebaseService = FirebaseService();

  Future<bool> registerUser(String id, Map<String, dynamic> userInfo) async {
    try {
      bool result = await _firebaseService.registerUser(id, userInfo);
      if(result){
        user = User.fromJson(userInfo);
      }
      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
