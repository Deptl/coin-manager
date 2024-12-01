import 'dart:async';

import 'package:coin_manager/controllers/budget_controller.dart';
import 'package:coin_manager/models/budget_model.dart';
import 'package:coin_manager/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final BudgetController _budgetController = BudgetController();
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? "";
  BudgetModel? currentBudget;
  double totalExpense = 0;
  ////////////////////////
  StreamSubscription<List<Map<String, dynamic>>>? _expenseSubscription;

  @override
  void initState() {
    super.initState();
    _fetchBudgetForMonth();
    _subscribeToExpenseStream();
  }

  @override
  void dispose() {
    // Cancel the stream subscription to prevent memory leaks
    _expenseSubscription?.cancel();
    super.dispose();
  }

  ///////////////////////////////////
  void _subscribeToExpenseStream() {
    _expenseSubscription = _budgetController
        .getExpenseTransactionsStream(
      userId: currentUserId,
      month: month,
      year: year,
    )
        .listen((transactions) {
      double total = transactions.fold<double>(
        0.0,
        (sum, transaction) {
          final amount = transaction["amount"];
          if (amount is num) {
            return sum + amount.toDouble();
          } else {
            debugPrint('Invalid transaction amount: $amount');
            return sum;
          }
        },
      );

      if (mounted) {
        setState(() {
          totalExpense = total;
        });
      }
    }, onError: (error) {
      debugPrint('Error calculating total expense: $error');
    });
  }

  Future<void> _fetchBudgetForMonth() async {
    final budget = await _budgetController.getBudget(
      userId: currentUserId,
      month: "${months[month - 1]} $year",
    );
    if (mounted) {
      setState(() {
        currentBudget = budget;
      });
    }
  }

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

    _fetchBudgetForMonth();
    _expenseSubscription?.cancel();
    _subscribeToExpenseStream();
  }

  // void _calculateTotalExpense() {
  //   _budgetController
  //       .getExpenseTransactionsStream(
  //     userId: currentUserId,
  //     month: month,
  //     year: year,
  //   )
  //       .listen((transactions) {
  //     double total = transactions.fold<double>(
  //       0.0,
  //       (sum, transaction) {
  //         final amount = transaction["amount"];
  //         if (amount is num) {
  //           return sum + amount.toDouble();
  //         } else {
  //           debugPrint('Invalid transaction amount: $amount');
  //           return sum;
  //         }
  //       },
  //     );

  //     setState(() {
  //       totalExpense = total;
  //     });
  //   }, onError: (error) {
  //     debugPrint('Error calculating total expense: $error');
  //   });
  // }

  String formatDate(String isoString) {
    // Parse the ISO string to a DateTime object
    DateTime utcDateTime = DateTime.parse(isoString);

    // Convert to local time
    DateTime localDateTime = utcDateTime.toLocal();

    // Format the DateTime to the desired format
    return DateFormat('MMMM d, yyyy').format(localDateTime);
  }

  Future<void> _showAddBudgetDialog() async {
    final TextEditingController amountController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Budget'),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "Enter budget amount"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (amountController.text.isNotEmpty) {
                  double amount = double.parse(amountController.text);

                  await _budgetController.addBudget(
                    userId: currentUserId,
                    month: "${months[month - 1]} $year",
                    amount: amount,
                  );

                  await _fetchBudgetForMonth();
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Text('Set Budget',
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
                SizedBox(height: 20),
                currentBudget == null
                    ? Center(
                        child: ElevatedButton(
                          onPressed: _showAddBudgetDialog,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primary),
                          child: const Text('Set Budget',
                              style: TextStyle(
                                  fontFamily: "Poppins", color: background)),
                        ),
                      )
                    : Column(
                        children: [
                          CircularPercentIndicator(
                            radius: 120.0,
                            lineWidth: 13.0,
                            animation: true,
                            percent: (totalExpense / currentBudget!.amount!)
                                .clamp(0.0, 1.0),
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    "\$" +
                                        (currentBudget!.amount! - totalExpense)
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: secondary,
                                        fontSize: 25)),
                                Text("Balance",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: secondary,
                                        fontSize: 15)),
                                Text("Budget: \$${currentBudget!.amount}",
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
                          StreamBuilder<List<Map<String, dynamic>>>(
                              stream: _budgetController
                                  .getExpenseTransactionsStream(
                                      userId: currentUserId,
                                      month: month,
                                      year: year),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }

                                if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Text(
                                      "No expense transactions found");
                                }

                                final transactions = snapshot.data!;
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: transactions.length,
                                    itemBuilder: (context, index) {
                                      final transaction = transactions[index];
                                      return Card(
                                        elevation: 3,
                                        color: background,
                                        child: ListTile(
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            child: Container(
                                                height: 45,
                                                width: 45,
                                                color: const Color.fromRGBO(
                                                    250, 250, 250, 0.2),
                                                child: const Icon(
                                                    FontAwesomeIcons.creditCard,
                                                    size: 30,
                                                    color: primary)),
                                          ),
                                          title: Text(
                                              transaction["category"] ?? "",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: primary)),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(transaction["account"] ?? "",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: primary)),
                                              Text(
                                                  formatDate(transaction[
                                                          "createdAt"] ??
                                                      ""),
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: primary))
                                            ],
                                          ),
                                          isThreeLine: true,
                                          trailing: Text(
                                              "\$" +
                                                  transaction["amount"]
                                                      .toString(),
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.red)),
                                        ),
                                      );
                                    });
                              })
                        ],
                      )
              ],
            ),
          ),
        ));
  }
}
