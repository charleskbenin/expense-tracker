import 'package:expense_tracker/src/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:expense_tracker/src/features/expense/presentation/screens/expense_screen.dart';
import 'package:expense_tracker/src/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/view_models/base_view.dart';
import '../view_models/bottom_nav_view_model.dart';
import '../widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _widgetOptions = const <Widget>[
    DashBoardScreen(),
    ExpenseScreen(),
    SettingsScreen()
  ];


  void onTap(int index) async{
    final bottomNavProvider = context.read<BottomNavViewModel>();

    bottomNavProvider.selectNavTab = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BaseView<BottomNavViewModel>(
            builder: (context, bottomNavProvider, child) => _widgetOptions.elementAt(bottomNavProvider.getSelectedNavTab)
        ),
      ),
      bottomNavigationBar: BaseView<BottomNavViewModel>(
        builder: (context, bottomNavProvider, child) => HomeBottomNavigationBar(
          currentIndex: bottomNavProvider.getSelectedNavTab,
          onTap: onTap,
        ),
      ),
    );
  }

}