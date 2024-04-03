import 'package:dashboard/src/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(NetworkManager());
    // Get.put(MoneyController());
    // Get.put(PropertyController());
    // Get.put(PropertyLayoutController());
  }
}
