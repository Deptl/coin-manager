import 'package:coin_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Text('Budget',
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: background)),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: 0.7,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("1000",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: secondary,
                                fontSize: 25)),
                        Text("Balance",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: secondary,
                                fontSize: 15)),
                        Text("Budget: 2000",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: secondary,
                                fontSize: 15)),
                      ],
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: primary,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
