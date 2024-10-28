import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IncomeAnalyticsScreen extends StatefulWidget {
  const IncomeAnalyticsScreen({super.key});

  @override
  State<IncomeAnalyticsScreen> createState() => _IncomeAnalyticsScreenState();
}

class _IncomeAnalyticsScreenState extends State<IncomeAnalyticsScreen> {
  List incomeChartData = [
    [7000, "Salary"],
    [1000, "Bonus"],
    [300, "Allowance"],
    [100, "Intrest"],
    [720, "Other"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 650,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              elevation: 5,
              child: SfCircularChart(
                series: [
                  DoughnutSeries(
                    innerRadius: "50%",
                    radius: "70%",
                    dataSource: incomeChartData,
                    yValueMapper: (data, _) => data[0],
                    xValueMapper: (data, _) => data[1],
                    explode: true,
                    dataLabelMapper: (data, _) => 'CAD ' + data[0].toString(),
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(fontFamily: "Poppins"),
                        labelPosition: ChartDataLabelPosition.outside),
                  ),
                ],
                legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    orientation: LegendItemOrientation.vertical,
                    textStyle: TextStyle(fontFamily: "Poppins"),
                    iconHeight: 20,
                    iconWidth: 20),
              )),
        ),
      ),
    );
  }
}
