import 'package:coin_manager/controllers/income_analytics_controller.dart';
import 'package:coin_manager/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IncomeAnalyticsScreen extends StatefulWidget {
  const IncomeAnalyticsScreen({super.key});

  @override
  State<IncomeAnalyticsScreen> createState() => _IncomeAnalyticsScreenState();
}

class _IncomeAnalyticsScreenState extends State<IncomeAnalyticsScreen> {
  final IncomeAnalyticsController _incomeAnalyticsController =
      IncomeAnalyticsController();

  // int month = DateTime.now().month;
  // int year = DateTime.now().year;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? "";

  // final List<String> months = [
  //   'January',
  //   'February',
  //   'March',
  //   'April',
  //   'May',
  //   'June',
  //   'July',
  //   'August',
  //   'September',
  //   'October',
  //   'November',
  //   'December'
  // ];

  // void changeMonth(bool isNext) {
  //   setState(() {
  //     if (isNext) {
  //       if (month == 12) {
  //         month = 1;
  //         year++;
  //       } else {
  //         month++;
  //       }
  //     } else {
  //       if (month == 1) {
  //         month = 12;
  //         year--;
  //       } else {
  //         month--;
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     ClipRRect(
            //       borderRadius: BorderRadius.circular(10),
            //       child: Container(
            //         height: 55,
            //         width: 55,
            //         color: const Color.fromRGBO(54, 137, 131, 0.2),
            //         child: IconButton(
            //           onPressed: () {
            //             changeMonth(false);
            //           },
            //           icon: const FaIcon(FontAwesomeIcons.chevronLeft),
            //           iconSize: 30,
            //           color: primary,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       padding: EdgeInsets.all(16.0),
            //       decoration: BoxDecoration(
            //         color: primary,
            //         borderRadius: BorderRadius.circular(8.0),
            //       ),
            //       child: Text(
            //         '${months[month - 1]} $year',
            //         style: TextStyle(
            //             fontFamily: "Poppins",
            //             color: background,
            //             fontWeight: FontWeight.bold),
            //         textAlign: TextAlign.center,
            //       ),
            //     ),
            //     ClipRRect(
            //       borderRadius: BorderRadius.circular(10),
            //       child: Container(
            //         height: 55,
            //         width: 55,
            //         color: const Color.fromRGBO(54, 137, 131, 0.2),
            //         child: IconButton(
            //           onPressed: () {
            //             changeMonth(true);
            //           },
            //           icon: const FaIcon(FontAwesomeIcons.chevronRight),
            //           iconSize: 30,
            //           color: primary,
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: _incomeAnalyticsController
                  .fetchIncomeCategoryData(currentUserId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available.'));
                }

                final incomeChartData = snapshot.data!
                    .map((data) => [data['amount'], data['category']])
                    .toList();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SfCircularChart(
                        series: [
                          DoughnutSeries(
                            innerRadius: "50%",
                            radius: "70%",
                            dataSource: incomeChartData,
                            yValueMapper: (data, _) => data[0],
                            xValueMapper: (data, _) => data[1],
                            explode: true,
                            dataLabelMapper: (data, _) =>
                                '\$ ' + data[0].toString(),
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
                      const SizedBox(height: 20),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: incomeChartData.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              color: background,
                              child: ListTile(
                                title: Text(incomeChartData[index][1],
                                    style: TextStyle(
                                        fontFamily: "Poppins", color: primary)),
                                trailing: Text('\$ ' +
                                    incomeChartData[index][0].toString(),
                                    style: TextStyle(
                                        fontFamily: "Poppins", color: primary)),
                              ),
                            );
                          })
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
