import 'package:get/get.dart';
import 'package:movie_cnu_web/models/reserve.dart';
import '../services/firebase_service.dart';

class ReserveController extends GetxController{
  static ReserveController get to => Get.find();

  final FirebaseService _firebaseService = FirebaseService();

  Future<List<Reserve>> getReserveList()async{
    return await _firebaseService.getReserveList();
  }

  Future<void> cancelReserve(String reserveId)async{
    await _firebaseService.cancelReserve(reserveId);
  }
}