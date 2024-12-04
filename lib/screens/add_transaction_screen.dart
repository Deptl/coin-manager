import 'dart:io';

import 'package:coin_manager/controllers/transaction_controller.dart';
import 'package:coin_manager/utils/colors.dart';
import 'package:coin_manager/utils/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TransactionController _transactionController = TransactionController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  bool _isIncome = true;
  bool _isLoading = false;
  String? selectedCategory;
  String? selectedAccountType;

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
    "Rent",
    "Bills",
    "Utilities"
    "Other"
  ];

  final List<String> incomeAccountType = ["Bank Account", "Cash", "Other"];

  final List<String> expenseAccountType = [
    "Bank Account",
    "Cash",
    "Apple Pay",
    "Google Pay",
    "Credit Card"
  ];

  //Code for Scannoning reciept using OCR

  File? _image;
  String? _totalAmount;

  final textRecognizer = TextRecognizer();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      if (mounted) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
      _recognizeTextFromImage(_image!);
    }
  }

  Future<void> _pickImageFormGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (mounted) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
      _recognizeTextFromImage(_image!);
    }
  }

  Future<void> _recognizeTextFromImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final recognizedText = await textRecognizer.processImage(inputImage);
    String totalAmount = _extractTotalAmount(recognizedText.text);
    if (mounted) {
      setState(() {
        _totalAmount = totalAmount;
        _amountController.text = _totalAmount ?? "";
      });
    }
  }

  String _extractTotalAmount(String text) {
    // Regex pattern to match any number with two decimal places
    final RegExp amountPattern = RegExp(r'\d+\.\d{2}');

    // Split the recognized text into lines
    List<String> lines = text.split('\n');

    // Step 1: Try to find the line that contains the word "TOTAL" (case-insensitive)
    for (int i = lines.length - 1; i >= 0; i--) {
      String line = lines[i].trim();

      // Check if the line contains the word "TOTAL" or similar variants
      if (line.toLowerCase().contains('total')) {
        // Find the first matching number (amount) on the same line
        final match = amountPattern.firstMatch(line);
        if (match != null) {
          return match.group(0)!; // Return the total amount found
        }
      }
    }

    // Step 2: If no "TOTAL" is found, search the last all lines for the largest amount
    double highestAmount = 0.0;

    for (int i = lines.length - 1; i >= 0; i--) {
      String line = lines[i].trim();

      // Find all amounts in the line
      final matches = amountPattern.allMatches(line);
      for (var match in matches) {
        double value = double.parse(match.group(0)!);
        // Keep track of the highest value found
        if (value > highestAmount) {
          highestAmount = value;
        }
      }
    }
    return highestAmount > 0.0
        ? highestAmount.toStringAsFixed(2)
        : 'Total not found';
  }

  @override
  void dispose() {
    textRecognizer.close();
    super.dispose();
  }

  void _addTransaction() async {
    if (!mounted)
      return; // Check if the widget is still mounted before calling setState
    setState(() {
      _isLoading = true;
    });
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) {
      Toast.showToast("No user is LoggedIn");
      if (mounted) {
        // Check if the widget is still mounted before calling setState
        setState(() {
          _isLoading = false;
        });
      }
      return;
    }
    if (selectedCategory == null || selectedAccountType == null) {
      Toast.showToast("Plaese select category and account");
      if (mounted) {
        // Check if the widget is still mounted before calling setState
        setState(() {
          _isLoading = false;
        });
      }
      return;
    }
    try {
      await _transactionController.addTransaction(
          userId: currentUserId,
          type: _isIncome ? "Income" : "Expense",
          amount: double.tryParse(_amountController.text) ?? 0.0,
          category: selectedCategory ?? "",
          account: selectedAccountType ?? "",
          createdAt: DateTime.now());
      if (mounted) {
        // Check if the widget is still mounted before calling setState
        setState(() {
          _isLoading = false;
        });
      }
      Toast.showToast("Transaction Added Successfully");

      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      print(e);
    }
  }

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
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            if (mounted) {
                              // Check if the widget is still mounted before calling setState
                              setState(() {
                                _isIncome = true;
                                selectedCategory = null;
                                selectedAccountType = null;
                              });
                            }
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
                            if (mounted) {
                              // Check if the widget is still mounted before calling setState
                              setState(() {
                                _isIncome = false;
                                selectedCategory = null;
                                selectedAccountType = null;
                              });
                            }
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
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
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
                          Toast.showToast("Please enter amount");
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
                        onPressed: _pickImageFromCamera,
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
                        onPressed: _pickImageFormGallery,
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
                    Toast.showToast("Plaese select a category");
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
                    Toast.showToast("Please select an account");
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _isLoading
                  ? SpinKitThreeBounce(
                      color: primary,
                      size: 40.0,
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _addTransaction();
                        } else {
                          Toast.showToast("Error Adding Transaction");
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: primary),
                      child: Text("Add Transaction",
                          style: TextStyle(
                              fontFamily: "Poppins", color: background)))
            ],
          ),
        ),
      ),
    );
  }
}
