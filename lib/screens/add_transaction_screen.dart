import 'package:coin_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  bool _isIncome = true;

  final List<String> incomeCategory = [
    "Salary",
    "Bonus",
    "Allowance",
    "Interest",
    "Other"
  ];

  final List<String> expenseCategory = [
    "Food",
    "Social",
    "Transport",
    "Health",
    "Education",
    "Other"
  ];

  final List<String> incomeAccountType = ["Bank Account", "Cash", "Other"];

  final List<String> expenseAccountType = [
    "Bank Account",
    "Cash",
    "Apple Pay",
    "Google Pay",
    "Creadit Card"
  ];

  String? selectedCategory;
  String? selectedAccountType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("Add Transaction",
                    style: TextStyle(
                        fontFamily: "Poppins", color: secondary, fontSize: 22)),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _isIncome = true;
                            selectedCategory = null;
                            selectedAccountType = null;
                          });
                        },
                        child: Text("Income",
                            style: TextStyle(
                                fontFamily: "Poppins", color: secondary)),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: _isIncome ? Colors.green : primary,
                            width: 2,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        )),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _isIncome = false;
                            selectedCategory = null;
                            selectedAccountType = null;
                          });
                        },
                        child: Text("Expense",
                            style: TextStyle(
                                fontFamily: "Poppins", color: secondary)),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: !_isIncome ? Colors.red : primary,
                            width: 2,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
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
                      style: TextStyle(fontFamily: "Poppins", color: secondary),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          final amountSnackbar = SnackBar(
                              content: Text("Please Enter Amount",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: secondary)));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(amountSnackbar);
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 55,
                      width: 55,
                      color: const Color.fromRGBO(54, 137, 131, 0.2),
                      child: IconButton(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.camera),
                        iconSize: 30,
                        color: primary,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 55,
                      width: 55,
                      color: const Color.fromRGBO(54, 137, 131, 0.2),
                      child: IconButton(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.image),
                        iconSize: 30,
                        color: primary,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Category",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primary,
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
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
                items: (_isIncome ? incomeCategory : expenseCategory)
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style:
                            TextStyle(fontFamily: "Poppins", color: secondary)),
                  );
                }).toList(),
                isExpanded: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please select a Category",
                            style: TextStyle(
                                fontFamily: "Poppins", color: secondary))));
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Account",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primary,
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
                value: selectedAccountType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedAccountType = newValue;
                  });
                },
                items: (_isIncome ? incomeAccountType : expenseAccountType)
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style:
                            TextStyle(fontFamily: "Poppins", color: secondary)),
                  );
                }).toList(),
                isExpanded: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please select an account",
                            style: TextStyle(
                                fontFamily: "Poppins", color: secondary))));
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    // if (_formKey.currentState!.validate()) {}
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomeScreen()),
                    // );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: primary),
                  child: Text("Add Transaction",
                      style:
                          TextStyle(fontFamily: "Poppins", color: background)))
            ],
          ),
        ),
      ),
    );
  }
}
