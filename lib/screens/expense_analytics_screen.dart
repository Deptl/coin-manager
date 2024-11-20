import 'package:coin_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

int month = DateTime.now().month;
  int year = DateTime.now().year;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  void changeMonth(bool isNext) {
    setState(() {
      if (isNext) {
        if (month == 12) {
          month = 1;
          year++;
        } else {
          month++;
        }
      } else {
        if (month == 1) {
          month = 12;
          year--;
        } else {
          month--;
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 55,
                    width: 55,
                    color: const Color.fromRGBO(54, 137, 131, 0.2),
                    child: IconButton(
                      onPressed: () {
                        changeMonth(false);
                      },
                      icon: const FaIcon(FontAwesomeIcons.chevronLeft),
                      iconSize: 30,
                      color: primary,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${months[month - 1]} $year',
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: background,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 55,
                    width: 55,
                    color: const Color.fromRGBO(54, 137, 131, 0.2),
                    child: IconButton(
                      onPressed: () {
                        changeMonth(true);
                      },
                      icon: const FaIcon(FontAwesomeIcons.chevronRight),
                      iconSize: 30,
                      color: primary,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SfCircularChart(
                series: [
                  DoughnutSeries(
                    innerRadius: "50%",
                    radius: "70%",
                    dataSource: expenseChartData,
                    yValueMapper: (data, _) => data[0],
                    xValueMapper: (data, _) => data[1],
                    explode: true,
                    dataLabelMapper: (data, _) => '\$ ' + data[0].toString(),
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(fontFamily: "Poppins"),
                        labelPosition: ChartDataLabelPosition.outside),
                  ),
                ],
                legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    orientation: LegendItemOrientation.horizontal,
                    textStyle: TextStyle(fontFamily: "Poppins"),
                    iconHeight: 20,
                    iconWidth: 20),
              ),
            ),
          ],
        ),
      )
    );
  }
}