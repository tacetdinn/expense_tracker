import 'package:hive_flutter/hive_flutter.dart';
import '../models/expanse_,item.dart';

class HiveDataBase {
  final _myBox = Hive.box("expanse_database");

  void saveData(List<ExpanseItem> allExpanse) {
    List<List<dynamic>> allExpansesFormatted = [];

    for (var expanse in allExpanse) {
      List<dynamic> expanseFormatted = [
        expanse.name,
        expanse.amount,
        expanse.dateTime,
      ];
      allExpansesFormatted.add(expanseFormatted);
    }

    _myBox.put("All_Expanses", allExpansesFormatted);
  }

  List<ExpanseItem> readData() {
    List savedExpanses = _myBox.get("All_Expanses") ?? [];
    List<ExpanseItem> allExpanses = [];

    for (int i = 0; i < savedExpanses.length; i++) {
      String name = savedExpanses[i][0];
      String amount = savedExpanses[i][1];
      DateTime dateTime = savedExpanses[i][2];

      ExpanseItem expanse =
          ExpanseItem(dateTime: dateTime, amount: amount, name: name);
      allExpanses.add(expanse);
    }
    return allExpanses;
  }
}
