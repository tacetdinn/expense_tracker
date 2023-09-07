import 'individual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double friAmount;
  final double thurAmount;
  final double wedAmount;
  final double satAmount;
  final double tueAmount;

  BarData(
      {required this.friAmount,
      required this.monAmount,
      required this.satAmount,
      required this.sunAmount,
      required this.thurAmount,
      required this.tueAmount,
      required this.wedAmount});

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: sunAmount),
      IndividualBar(x: 1, y: monAmount),
      IndividualBar(x: 2, y: tueAmount),
      IndividualBar(x: 3, y: wedAmount),
      IndividualBar(x: 4, y: satAmount),
      IndividualBar(x: 5, y: friAmount),
      IndividualBar(x: 6, y: thurAmount),
    ];
  }
}
