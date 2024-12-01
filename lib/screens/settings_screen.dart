import 'package:coin_manager/screens/expense_category_screen.dart';
import 'package:coin_manager/screens/income_category_screen.dart';
import 'package:coin_manager/screens/login_screen.dart';
import 'package:coin_manager/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isToggled = false;

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to Logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    ).then((result) async {
      if (result == true) {
        await FirebaseAuth.instance.signOut();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Action canceled.')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",
            style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: background)),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("Personal Information",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Poppins", color: secondary)),
            ),
            Divider(
              color: primary,
            ),
            Text("Deep Patel",
                style: TextStyle(
                    fontSize: 15, fontFamily: "Poppins", color: secondary)),
            SizedBox(height: 5),
            Text("dpatel312@gmail.com",
                style: TextStyle(
                    fontSize: 15, fontFamily: "Poppins", color: secondary)),
            SizedBox(height: 20),
            Center(
              child: Text("Add Sections",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Poppins", color: secondary)),
            ),
            Divider(
              color: primary,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IncomeCategoryScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add Category for Income",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Poppins",
                          color: secondary)),
                  FaIcon(FontAwesomeIcons.chevronRight)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExpenseCategoryScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add Category for Expense",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Poppins",
                          color: secondary)),
                  FaIcon(FontAwesomeIcons.chevronRight)
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text("System Settings",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Poppins", color: secondary)),
            ),
            Divider(
              color: primary,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark Mode",
                    style: TextStyle(
                        fontSize: 15, fontFamily: "Poppins", color: secondary)),
                Switch(
                  value: isToggled,
                  onChanged: (value) {
                    setState(() {
                      isToggled = value;
                    });
                  },
                  activeColor: Colors.grey,
                  inactiveThumbColor: primary,
                ),
              ],
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                _showConfirmationDialog(context);
              },
              child: Text("Logout",
                  style: TextStyle(
                      fontSize: 15, fontFamily: "Poppins", color: secondary)),
            ),
          ],
        ),
      ),
    );
  }
}
