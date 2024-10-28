import 'package:coin_manager/screens/expense_analytics_screen.dart';
import 'package:coin_manager/screens/income_analytics_screen.dart';
import 'package:coin_manager/utils/colors.dart';
import 'package:flutter/material.dart';

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
