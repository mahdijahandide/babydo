import 'package:get/get.dart';

class BookController extends GetxController {
  RxBool acceptTerm = false.obs;
  DateTime startOfPeriod = DateTime.now().subtract(const Duration(days: 10));
  DateTime endOfPeriod = DateTime.now().add(const Duration(days: 10));
  DateTime selectedDate = DateTime.now().add(const Duration(days: 10));
}
