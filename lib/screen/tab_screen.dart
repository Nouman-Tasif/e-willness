import 'package:flutter/material.dart';
import 'package:myproject/screen/calculate_calories.dart';
import 'package:myproject/screen/home_screen.dart';

import 'package:myproject/screen/profile_screen.dart';
import 'package:myproject/screen/records_screen.dart';
import 'package:myproject/viewmodel/tab_viewmodel.dart';
import 'package:provider/provider.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TabScreenViewModel>(
      builder: (context, viewModel, _) {
        return Scaffold(
          body: IndexedStack(
            index: viewModel.selectedTabIndex,
            children:  [
              HomeScreen(),
              CaloriesCalculator(),
              const RecordScreen(),
              const ProfileScreen(), // New tab
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: viewModel.selectedTabIndex,
            onTap: (index) => viewModel.setTabIndex(index),
            type: BottomNavigationBarType.fixed,
            items:  [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/images/calories.png",width: 30,),
                label: 'Calories',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.notifications_sharp),
                label: 'Notification',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}

