import 'package:coin_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Text('Goal',
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
                    percent: 0.5,
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
                        Text("Target: 2000",
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
