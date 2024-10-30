import 'package:coin_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
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
                        style:
                            TextStyle(fontFamily: "Poppins", color: background, fontWeight: FontWeight.bold),
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
                SizedBox(height: 20),
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        color: background,
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Container(
                                height: 45,
                                width: 45,
                                color: const Color.fromRGBO(250, 250, 250, 0.2),
                                child: const Icon(FontAwesomeIcons.creditCard,
                                    size: 30, color: primary)),
                          ),
                          title: Text("Food",
                              style: TextStyle(
                                  fontFamily: "Poppins", color: primary)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Today",
                                  style: TextStyle(
                                      fontFamily: "Poppins", color: primary)),
                              Text("Apple Pay",
                                  style: TextStyle(
                                      fontFamily: "Poppins", color: primary))
                            ],
                          ),
                          isThreeLine: true,
                          trailing: Text("\$250",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.red)),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
