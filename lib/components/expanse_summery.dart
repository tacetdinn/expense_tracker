import 'package:expanse_tracker/bar%20graph/bar_graph.dart';
import 'package:expanse_tracker/data/expanse_data.dart';
import 'package:expanse_tracker/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpanseSummery extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpanseSummery({super.key, required this.startOfWeek});

  double calculateMax(
      ExpanseData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpanseSummery()[sunday] ?? 0,
      value.calculateDailyExpanseSummery()[monday] ?? 0,
      value.calculateDailyExpanseSummery()[tuesday] ?? 0,
      value.calculateDailyExpanseSummery()[wednesday] ?? 0,
      value.calculateDailyExpanseSummery()[thursday] ?? 0,
      value.calculateDailyExpanseSummery()[friday] ?? 0,
      value.calculateDailyExpanseSummery()[saturday] ?? 0,
    ];

    values.sort();
    max = values.last * 1.1;
    return max == 0 ? 100 : max;
  }

  String calculateWeekTotal(
    ExpanseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculateDailyExpanseSummery()[sunday] ?? 0,
      value.calculateDailyExpanseSummery()[monday] ?? 0,
      value.calculateDailyExpanseSummery()[tuesday] ?? 0,
      value.calculateDailyExpanseSummery()[wednesday] ?? 0,
      value.calculateDailyExpanseSummery()[thursday] ?? 0,
      value.calculateDailyExpanseSummery()[friday] ?? 0,
      value.calculateDailyExpanseSummery()[saturday] ?? 0,
    ];

    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String sunday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 6)));
    return Consumer<ExpanseData>(
        builder: (context, value, child) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Text(
                        "Week Total:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                          "\$${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: MyBarGraph(
                      maxY: calculateMax(value, sunday, monday, tuesday,
                          wednesday, thursday, friday, saturday),
                      sunAmount:
                          value.calculateDailyExpanseSummery()[sunday] ?? 0,
                      wedAmount:
                          value.calculateDailyExpanseSummery()[monday] ?? 0,
                      tueAmount:
                          value.calculateDailyExpanseSummery()[tuesday] ?? 0,
                      thurAmount:
                          value.calculateDailyExpanseSummery()[wednesday] ?? 0,
                      satAmount:
                          value.calculateDailyExpanseSummery()[thursday] ?? 0,
                      monAmount:
                          value.calculateDailyExpanseSummery()[friday] ?? 0,
                      friAmount:
                          value.calculateDailyExpanseSummery()[saturday] ?? 0),
                ),
              ],
            ));
  }
}
