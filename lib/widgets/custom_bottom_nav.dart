import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE3FBEF), // Light green background
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navItem(Icons.home_outlined, 0),
          _navItem(Icons.bar_chart_outlined, 1), // Using bar chart icon for analytics/transactions
          _centerButton(),
          _navItem(Icons.layers_outlined, 2), // Categories
          _navItem(Icons.person_outline, 3), // Profile
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    final bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: isSelected
            ? const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent, // Or a subtle highlight if needed
              )
            : null,
        child: Icon(
          icon,
          size: 28,
          color: isSelected ? AppColors.textDark : Colors.grey.shade500,
        ),
      ),
    );
  }

  Widget _centerButton() {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
        color: AppColors.primaryGreen,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(Icons.swap_horiz, color: Colors.white, size: 30),
    );
  }
}
