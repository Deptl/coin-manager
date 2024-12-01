import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_manager/screens/settings_screen.dart';
import 'package:coin_manager/utils/colors.dart';
import 'package:coin_manager/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? firstName;
  String? lastName;
  bool isLoading = true;

  User? user = FirebaseAuth.instance.currentUser;

  double totalIncome = 0.0;
  double totalExpense = 0.0;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user?.uid)
          .get();

      setState(() {
        firstName = userData['firstName'] ?? '';
        lastName = userData['lastName'] ?? '';
        isLoading = false;
      });
    }
  }

  Stream<Map<String, dynamic>> getTransactionsStream() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(user?.uid)
        .collection('Transaction')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((querySnapshot) {
      totalIncome = 0.0;
      totalExpense = 0.0;

      List<Map<String, dynamic>> transactions = querySnapshot.docs.map((doc) {
        final data = doc.data();
        final double amount = (data['amount'] as num).toDouble();
        final String transactionType = data['type'] ?? '';

        if (transactionType == 'Income') {
          totalIncome += amount;
        } else if (transactionType == 'Expense') {
          totalExpense += amount;
        }

        return data;
      }).toList();

      return {
        'transactions': transactions,
        'totals': {
          'income': totalIncome,
          'expense': totalExpense,
        },
      };
    });
  }

  Stream<List<Map<String, dynamic>>> getRecentTransactions() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(user?.uid)
        .collection('Transaction')
        .orderBy('createdAt', descending: true)
        .limit(5)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  String formatDate(String isoString) {
  // Parse the ISO string to a DateTime object
  DateTime utcDateTime = DateTime.parse(isoString);

  // Convert to local time
  DateTime localDateTime = utcDateTime.toLocal();

  // Format the DateTime to the desired format
  return DateFormat('MMMM d, yyyy').format(localDateTime);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        body: SafeArea(
            child: SingleChildScrollView(
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
                              left: 335,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 50,
                                  width: 45,
                                  color:
                                      const Color.fromRGBO(250, 250, 250, 0.2),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SettingsScreen()));
                                    },
                                    icon: const FaIcon(FontAwesomeIcons.gear),
                                    iconSize: 30,
                                    color: background,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20, left: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.greetings,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Poppins",
                                          color: background)),
                                  !isLoading
                                      ? Text("$firstName  $lastName",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontFamily: "Poppins",
                                              color: background,
                                              fontWeight: FontWeight.bold))
                                      : Text("")
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
                    child: StreamBuilder<Map<String, dynamic>>(
                      stream: getTransactionsStream(),
                      builder: (context, snapshot){
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }

                        if (!snapshot.hasData) {
                          return Center(child: Text('No data available.'));
                        }

                        final data = snapshot.data!;
                        final totals = data['totals'] as Map<String, double>;
                        final income = totals['income'] ?? 0.0;
                        final expense = totals['expense'] ?? 0.0;
                        final balance = income - expense;
                        return Row(
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Total Balance",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              color: background)),
                                      Text("\$${balance.toStringAsFixed(2)}",
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
                                                        FontAwesomeIcons
                                                            .arrowDown,
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
                                          Text("\$${income.toStringAsFixed(2)}",
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
                                          Text("\$${expense.toStringAsFixed(2)}",
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
                      );
                      },
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
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: getRecentTransactions(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text('No transactions found for this month.'));
                    }

                    final transactions = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = transactions[index];
                          return Card(
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
                                  Text(
                                      formatDate(
                                          transaction["createdAt"] ?? ""),
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
                                      color: transaction["type"] ==
                                              "Income"
                                          ? incomeColor
                                          : expenseColor)),
                            ),
                          );
                        });
                  },
                ),
              )
            ],
          ),
        )));
  }
}
