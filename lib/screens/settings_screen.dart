import 'package:coin_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isToggled = false;
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
            Text("John Doe",
                style: TextStyle(
                    fontSize: 15, fontFamily: "Poppins", color: secondary)),
            SizedBox(height: 5),
            Text("jdoe2334@gmail.com",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Add Categories for Income",
                    style: TextStyle(
                        fontSize: 15, fontFamily: "Poppins", color: secondary)),
                FaIcon(FontAwesomeIcons.arrowRight)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Add Categories for Expense",
                    style: TextStyle(
                        fontSize: 15, fontFamily: "Poppins", color: secondary)),
                FaIcon(FontAwesomeIcons.arrowRight)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Add Accounts for Income",
                    style: TextStyle(
                        fontSize: 15, fontFamily: "Poppins", color: secondary)),
                FaIcon(FontAwesomeIcons.arrowRight)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Add Accounts for Expense",
                    style: TextStyle(
                        fontSize: 15, fontFamily: "Poppins", color: secondary)),
                FaIcon(FontAwesomeIcons.arrowRight)
              ],
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
            Text("Logout",
                style: TextStyle(
                    fontSize: 15, fontFamily: "Poppins", color: secondary)),
          ],
        ),
      ),
    );
  }
}
