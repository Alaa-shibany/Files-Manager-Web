import 'package:hive_flutter/hive_flutter.dart';
import 'package:files_manager/core/config/model_abstract.dart';

class CashManager {
  static Future<dynamic> getCashedData({required String key}) async {
    final box = Hive.box('cash_box');
    if (box.isOpen) {
      //Get the data depend on the key
      final data = await box.get(key);
      if (data == null) {
        //Return -1 mean No data

        return -1;
      }
      return data;
    } else {
      //Return -1 mean No data
      return -1;
    }
  }

  static List<T> getItemsInSecondListOnly<T extends ModelAbstract>(
      List<T> list1, List<T> list2) {
    // Extract the ids from list1 for comparison
    final list1Ids = list1.map((item) => item.id).toSet();

    // Return the items from list2 where the id is not in list1
    final List<T> compareList =
        list2.where((item) => !list1Ids.contains(item.id)).toList();

    print('The comparedListResult is => $compareList');
    return compareList;
  }

  static Future<bool> saveCashedData(
      {required String key, required dynamic data}) async {
    final box = Hive.box('cash_box');
    if (box.isOpen) {
      await box.put(key, data);
      if (box.get(key) == null) {
        //Return false mean failed to save
        return false;
      }
      //Return true mean success to save
      return true;
    } else {
      //Return false mean failed to save
      return false;
    }
  }
}
