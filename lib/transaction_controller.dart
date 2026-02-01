import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class TransactionController extends GetxController {
  final box = GetStorage();
  var transactions = <Map>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (box.read('tx_list') != null) {
      List<dynamic> savedList = box.read('tx_list');
      List<Map<String, dynamic>> correctList = List<Map<String, dynamic>>.from(
        savedList,
      );
      transactions.assignAll(correctList);
    }
  }

  void addTransaction(Map transaction) {
    transactions.add(transaction);
    box.write('tx_list', transactions);
  }

  void deleteTransaction(int index) {
    transactions.removeAt(index);
    box.write('tx_list', transactions);
  }

  //Math Logic
  // 1. Calculate Total Income
  double get totalIncome {
    return transactions.where((t) => t['type'] == 'Income')
    // We add <double> here to tell Dart: "The result is definitely a double"
    .fold<double>(0.0, (double sum, item) {
      // We use .toString() to ensure we don't crash if the value is already a number
      return sum + (double.tryParse(item['amount'].toString()) ?? 0.0);
    });
  }

  // 2. Calculate Total Expense
  double get totalExpense {
    return transactions.where((t) => t['type'] == 'Expense').fold<double>(0.0, (
      double sum,
      item,
    ) {
      return sum + (double.tryParse(item['amount'].toString()) ?? 0.0);
    });
  }

  double get totalBalance => totalIncome - totalExpense;
}
