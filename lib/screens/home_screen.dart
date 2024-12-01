import 'package:coin_manager/screens/analytics_screen.dart';
import 'package:coin_manager/screens/budget_screen.dart';
import 'package:coin_manager/screens/dashboard_screen.dart';
import 'package:coin_manager/screens/goal_screen.dart';
import 'package:coin_manager/screens/transactions_screen.dart';
import 'package:coin_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabItems = [
    DashboardScreen(),
    TransactionsScreen(),
    AnalyticsScreen(),
    BudgetScreen(),
    GoalScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabItems[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primary,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: background,
        unselectedItemColor: background,
        selectedLabelStyle:
            TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: TextStyle(fontFamily: "Poppins", fontSize: 10),
        items: [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.nfcDirectional, color: background),
              label: "Dashboard",
              backgroundColor: background),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.file, color: background),
              label: "Transac.",
              backgroundColor: background),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.chartBar, color: background),
              label: "Analytics",
              backgroundColor: background),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.dollarSign, color: background),
              label: "Budget",
              backgroundColor: background),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.bullseye, color: background),
              label: "Goal",
              backgroundColor: background)
        ],
      ),
    );
  }
}