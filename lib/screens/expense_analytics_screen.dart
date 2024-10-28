import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExpenseAnalyticsScreen extends StatefulWidget {
  const ExpenseAnalyticsScreen({super.key});

  @override
  State<ExpenseAnalyticsScreen> createState() => _ExpenseAnalyticsScreenState();
}

class _ExpenseAnalyticsScreenState extends State<ExpenseAnalyticsScreen> {

  List expenseChartData = [
    [300, "Food"],
    [150, "Social"],
    [60, "Transport"],
    [100, "Health"],
    [720, "Education"],
    [20, "Other"]
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
                    dataSource: expenseChartData,
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
      )
    );
  }
}