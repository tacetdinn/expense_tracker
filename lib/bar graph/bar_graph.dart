import 'package:expanse_tracker/bar%20graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double friAmount;
  final double wedAmount;
  final double thurAmount;
  final double tueAmount;
  final double satAmount;
  final double monAmount;
  const MyBarGraph(
      {super.key,
      required this.maxY,
      required this.sunAmount,
      required this.wedAmount,
      required this.tueAmount,
      required this.thurAmount,
      required this.satAmount,
      required this.monAmount,
      required this.friAmount});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        friAmount: friAmount,
        monAmount: monAmount,
        satAmount: satAmount,
        sunAmount: sunAmount,
        thurAmount: thurAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount);

    myBarData.initializeBarData();

    return BarChart(BarChartData(
      maxY: maxY,
      minY: 0,
      titlesData: FlTitlesData(
        show: true,
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
            sideTitles:
                SideTitles(showTitles: true, getTitlesWidget: getBottomTitles)),
      ),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: myBarData.barData
          .map((data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: Colors.grey[800],
                      width: 35,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: maxY,
                        color: Colors.grey[200],
                      )),
                ],
              ))
          .toList(),
    ));
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14);

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        "Mon",
        style: style,
      );
      break;
    case 1:
      text = const Text(
        "Tue",
        style: style,
      );
      break;
    case 2:
      text = const Text(
        "Wed",
        style: style,
      );
      break;
    case 3:
      text = const Text(
        "Thur",
        style: style,
      );
      break;
    case 4:
      text = const Text(
        "Fri",
        style: style,
      );
      break;
    case 5:
      text = const Text(
        "Sat",
        style: style,
      );
      break;
    case 6:
      text = const Text(
        "Sun",
        style: style,
      );
      break;
    default:
      text = const Text(
        "data",
        style: style,
      );
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
