import 'package:coin_manager/screens/add_transaction_screen.dart';
import 'package:coin_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          showModalBottomSheet(context: context, builder: (BuildContext context){
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
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 15,
            itemBuilder: (context, index) {
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
                          color: const Color.fromRGBO(250, 250, 250, 0.2),
                          child: const Icon(FontAwesomeIcons.creditCard,
                              size: 30, color: primary)),
                    ),
                    title: Text("Salary",
                        style:
                            TextStyle(fontFamily: "Poppins", color: primary)),
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
                    trailing: Text("\$10,000",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: const Color.fromARGB(255, 90, 180, 90))),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
