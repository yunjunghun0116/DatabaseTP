import 'package:get/get.dart';
import 'package:movie_cnu_web/models/user.dart';
import '../services/firebase_service.dart';

class UserManageController extends GetxController{
  static UserManageController get to => Get.find();

  final FirebaseService _firebaseService = FirebaseService();

  Future<List<User>> getUserList()async{
    return await _firebaseService.getUserList();
  }
}