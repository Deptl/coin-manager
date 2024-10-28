import 'package:coin_manager/screens/analytics_screen.dart';
import 'package:coin_manager/screens/budget_screen.dart';
import 'package:coin_manager/screens/dashboard_screen.dart';
import 'package:coin_manager/screens/goal_screen.dart';
import 'package:coin_manager/screens/transactions_screen.dart';
import 'package:coin_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: tabViewItems(),
      items: navBarsItems(),
      backgroundColor: primary,
    );
  }
}

List<Widget> tabViewItems() {
  return [
    DashboardScreen(),
    TransactionsScreen(),
    AnalyticsScreen(),
    BudgetScreen(),
    GoalScreen()
  ];
}

List<PersistentBottomNavBarItem> navBarsItems() {
  return [
    PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.nfcDirectional),
        title: "Dash",
        textStyle: TextStyle(fontFamily: "Poppins"),
        activeColorPrimary: background,
        inactiveColorPrimary: background),
    PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.file),
        title: "Transac",
        textStyle: TextStyle(fontFamily: "Poppins"),
        activeColorPrimary: background,
        inactiveColorPrimary: background),
    PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.chartBar),
        title: "Analytics",
        textStyle: TextStyle(fontFamily: "Poppins"),
        activeColorPrimary: background,
        inactiveColorPrimary: background),
    PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.dollarSign),
        title: "Budget",
        textStyle: TextStyle(fontFamily: "Poppins"),
        activeColorPrimary: background,
        inactiveColorPrimary: background),
    PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.bullseye),
        title: "Goal",
        textStyle: TextStyle(fontFamily: "Poppins"),
        activeColorPrimary: background,
        inactiveColorPrimary: background),
  ];
}
