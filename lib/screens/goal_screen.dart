import 'package:coin_manager/controllers/goal_controller.dart';
import 'package:coin_manager/models/goal_model.dart';
import 'package:coin_manager/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final GoalController _goalController = GoalController();
  final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? "";
  GoalModel? currentGoal;
  double totalSaved = 0;

  Future<void> _fetchGoal() async {
    final goalStream = _goalController.getGoalsStream(userId: currentUserId);

    goalStream.first.then((goalList) {
      if (goalList.isNotEmpty) {
        setState(() {
          currentGoal = goalList.first;
        });
      } else {
        setState(() {
          currentGoal = null;
        });
      }
    }).catchError((error) {
      debugPrint("Error fetching goals: $error");
    });
  }

  Future<void> _showAddGoalDialog() async {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Savings Goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: "Enter goal amount"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "Enter a name"),
              ),
            ],
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

                  await _goalController.addGoal(
                    userId: currentUserId,
                    goalAmount: amount,
                    goalName: nameController.text,
                  );

                  await _fetchGoal();
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
          title: Text('Savings Goal',
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: background)),
        ),
        floatingActionButton: currentGoal != null
            ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                            title: Center(child: Text("Add Money to Goal")),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Form(
                                    child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: "Amount",
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: secondary,
                                            width: 2.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: primary,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: secondary),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          final amountSnackbar = SnackBar(
                                              content: Text(
                                                  "Please Enter Amount",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: secondary)));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(amountSnackbar);
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: "Note",
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: secondary,
                                            width: 2.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: primary,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: secondary),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          final amountSnackbar = SnackBar(
                                              content: Text(
                                                  "Please Enter Amount",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: secondary)));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(amountSnackbar);
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: primary),
                                        child: Text("Add",
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                color: background)))
                                  ],
                                )),
                              )
                            ],
                          ));
                },
                child: Icon(
                  FontAwesomeIcons.plus,
                  color: background,
                ),
                backgroundColor: primary,
              )
            : null,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: currentGoal == null
                  ? Center(
                      child: ElevatedButton(
                        onPressed: _showAddGoalDialog,
                        style:
                            ElevatedButton.styleFrom(backgroundColor: primary),
                        child: const Text(
                          'Set Goal',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: background,
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Center(
                          child: Text(currentGoal!.goalName!,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  color: secondary,
                                  fontSize: 25)),
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
                              Text("Goal: \$${currentGoal!.goalAmount}",
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
                                  title: Text("Salary",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: primary)),
                                  trailing: Text("\$250",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: primary)),
                                ),
                              );
                            }),
                      ],
                    ),
            ),
          ),
        ));
  }
}
