import 'package:coin_manager/controllers/transaction_controller.dart';
import 'package:coin_manager/screens/add_transaction_screen.dart';
import 'package:coin_manager/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TransactionController _transactionController = TransactionController();
  final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? "";

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
    if (mounted) {
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
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('MMMM d, yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text("Transactions",
            style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: background)),
        backgroundColor: primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return AddTransactionScreen();
              });
        },
        child: Icon(
          FontAwesomeIcons.plus,
          color: background,
        ),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
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
                      color: Color.fromRGBO(54, 137, 131, 0.2),
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
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: _transactionController.getTransactionsStream(
                    userId: currentUserId, month: month, year: year),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No transactions found.'));
                  }

                  final transactions = snapshot.data!;
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Card(
                            elevation: 3,
                            color: background,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
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
                              title: Text(transaction["category"] ?? "",
                                  style: TextStyle(
                                      fontFamily: "Poppins", color: primary)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(transaction["account"] ?? "",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: primary)),
                                  Text(formatDate(transaction["createdAt"]),
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: primary))
                                ],
                              ),
                              isThreeLine: true,
                              trailing: Text(
                                  "\$" + transaction["amount"].toString(),
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: transaction["type"] == "Income"
                                          ? incomeColor
                                          : expenseColor)),
                            ),
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
