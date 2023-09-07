import 'package:expanse_tracker/data/hive_database.dart';
import 'package:expanse_tracker/datetime/date_time_helper.dart';
import 'package:expanse_tracker/models/expanse_,item.dart';
import 'package:flutter/foundation.dart';

class ExpanseData extends ChangeNotifier {
  List<ExpanseItem> overallExpanseList = [];

  List<ExpanseItem> getAllExpanseList() {
    return overallExpanseList;
  }

  final db = HiveDataBase();
  void prepareData() {
    if (db.readData().isNotEmpty) {
      overallExpanseList = db.readData();
    }
  }

  // add new expanse

  void addNewExpanse(ExpanseItem newExpanse) {
    overallExpanseList.add(newExpanse);

    notifyListeners();
    db.saveData(overallExpanseList);
  }

  // delete expanse

  void deleteExpanse(ExpanseItem expanse) {
    overallExpanseList.remove(expanse);

    notifyListeners();
    db.saveData(overallExpanseList);
  }

  String getDayTime(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thur";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";

      default:
        return "";
    }
  }

  DateTime startOfWeekDay() {
    DateTime? startOfWeek;

    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getDayTime(today.subtract(Duration(days: i))) == "Sun") {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  Map<String, double> calculateDailyExpanseSummery() {
    Map<String, double> dailyExpanseSummery = {};

    for (var expanse in overallExpanseList) {
      String date = convertDataTimeToString(expanse.dateTime);
      double amount = double.parse(expanse.amount);

      if (dailyExpanseSummery.containsKey(date)) {
        double currentAmount = dailyExpanseSummery[date]!;
        currentAmount += amount;
        dailyExpanseSummery[date] = currentAmount;
      } else {
        dailyExpanseSummery.addAll({date: amount});
      }
    }
    return dailyExpanseSummery;
  }
}
