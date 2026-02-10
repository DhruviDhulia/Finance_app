import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';
import '../utils/app_colors.dart';
import 'dashboard_screen.dart';
import 'transaction_screen.dart';
import 'categories_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    TransactionScreen(), // Make sure these are const if possible or stateful
    CategoriesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen, 
      // Background logic might need to be in each screen if they differ significantly, 
      // but for floating nav, having it here helps.
      // Actually, Dashboard covers full screen, so we need to stack the nav.
      
      body: Stack(
        children: [
          _screens[_currentIndex],
          
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNav(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
