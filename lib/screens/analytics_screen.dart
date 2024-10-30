import 'package:coin_manager/screens/expense_analytics_screen.dart';
import 'package:coin_manager/screens/income_analytics_screen.dart';
import 'package:coin_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Analytics",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: background)),
          backgroundColor: primary,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            onPressed: () {},
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
                          'October 2024',
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
                            onPressed: () {},
                            icon: const FaIcon(FontAwesomeIcons.chevronRight),
                            iconSize: 30,
                            color: primary,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(54, 137, 131, 0.2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: TabBar(
                              unselectedLabelColor: primary,
                              labelColor: background,
                              indicator: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(5)),
                              controller: tabController,
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabs: [
                                Tab(text: 'Income'),
                                Tab(text: 'Expense'),
                              ]),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: TabBarView(controller: tabController, children: [
                    IncomeAnalyticsScreen(),
                    ExpenseAnalyticsScreen()
                  ]))
                ],
              ),
            ),
          ),
        ));
  }
}
