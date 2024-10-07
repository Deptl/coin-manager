import 'package:coin_manager/utils/colors.dart';
import 'package:coin_manager/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: const BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 25,
                            left: 350,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 50,
                                width: 45,
                                color: const Color.fromRGBO(250, 250, 250, 0.2),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const FaIcon(FontAwesomeIcons.user),
                                  iconSize: 30,
                                  color: background,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20, left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Strings.welcomeMessage,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Poppins",
                                        color: background)),
                                Text(Strings.name,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: "Poppins",
                                        color: background,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 170,
                        width: 320,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 47, 125, 121),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Total Balance",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          color: background)),
                                  Text("\$12,456",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: background))
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            child: Container(
                                                height: 20,
                                                width: 20,
                                                color: const Color.fromRGBO(
                                                    250, 250, 250, 0.2),
                                                child: const Icon(
                                                    FontAwesomeIcons.arrowDown,
                                                    size: 10,
                                                    color: background)),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text("Income",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 15,
                                                  color: background))
                                        ],
                                      ),
                                      Text("\$2345",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              color: background))
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            child: Container(
                                                height: 20,
                                                width: 20,
                                                color: const Color.fromRGBO(
                                                    250, 250, 250, 0.2),
                                                child: const Icon(
                                                    FontAwesomeIcons.arrowUp,
                                                    size: 10,
                                                    color: background)),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text("Expense",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 15,
                                                  color: background))
                                        ],
                                      ),
                                      Text("\$345",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              color: background))
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10),
              child: Text("Recent Transactions",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: secondary)),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      color: primary,
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                              height: 45,
                              width: 45,
                              color: const Color.fromRGBO(250, 250, 250, 0.2),
                              child: const Icon(FontAwesomeIcons.creditCard,
                                  size: 30, color: background)),
                        ),
                        title: Text("Salary",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: background)),
                        subtitle: Text("Today",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: background)),
                        trailing: Text("\$10,000",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: const Color.fromARGB(255, 12, 255, 21))),
                      ),
                    );
                  }),
            )
          ],
        )));
  }
}
