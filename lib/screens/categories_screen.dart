import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  final List<Map<String, dynamic>> categories = [
    {"name": "Food", "icon": Icons.restaurant}, // Image 4 shows fork/knife
    {"name": "Transport", "icon": Icons.directions_bus_outlined},
    {"name": "Medicine", "icon": Icons.medication_outlined}, // Pill icon
    {"name": "Groceries", "icon": Icons.shopping_bag_outlined},
    {"name": "Rent", "icon": Icons.vpn_key_outlined},
    {"name": "Gifts", "icon": Icons.card_giftcard},
    {"name": "Savings", "icon": Icons.savings_outlined},
    {"name": "Entertainment", "icon": Icons.confirmation_number_outlined}, // Ticket icon
    {"name": "More", "icon": Icons.add},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   IconButton(
                     key: const Key('categories_back_button'),
                     icon: const Icon(Icons.arrow_back, color: Colors.white),
                     onPressed: () {}, // Navigation logic
                   ),
                   const Text("Categories", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                   const Icon(Icons.notifications_outlined, color: Colors.white),
                 ],
               ),
            ),
             // Summary Section similar to Transaction but simpler?
             // Image 4 shows the same Balance/Expense Summary at the top as dashboard/transaction
             // Let's replicate the Balance/Expense header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   _balanceInfo(label: "Total Balance", amount: "\$7,783.00"),
                   Container(width: 1, height: 40, color: Colors.white24),
                   _balanceInfo(label: "Total Expense", amount: "-\$1,187.40", isExpense: true),
                ],
              ),
            ),
            const SizedBox(height: 10),
             // Progress Bar
            Padding(
               padding: const EdgeInsets.symmetric(horizontal: 24),
               child: Column(
                  children: [
                    Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3E3E), // Darker green/black 
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text("30%", style: TextStyle(color: Colors.white, fontSize: 12)),
                          ),
                          const Expanded(
                            child: Center(
                                child: Text("\$20,000.00", style: TextStyle(color: Colors.white, fontSize: 12)),
                            )
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                            Icon(Icons.check_box_outlined, color: Colors.black54, size: 16),
                            SizedBox(width: 6),
                            Text("30% Of Your Expenses, Looks Good.", style: TextStyle(color: Colors.black54, fontSize: 11)),
                        ],
                      )
                    ),
                  ],
               ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: const BoxDecoration(
                  color: AppColors.scaffoldBg,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 24,
                    childAspectRatio: 0.8, // Adjust for height
                  ),
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return Column(
                      children: [
                         Container(
                           height: 80,
                           width: 80,
                           decoration: BoxDecoration(
                             color: const Color(0xFF65A4FF), // Light Blue
                             borderRadius: BorderRadius.circular(24),
                           ),
                           child: Icon(cat["icon"], size: 36, color: Colors.white),
                         ),
                         const SizedBox(height: 8),
                         Text(cat["name"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textDark)),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _balanceInfo({required String label, required String amount, bool isExpense = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Row(
           children: [
             Icon(isExpense ? Icons.arrow_outward : Icons.account_balance_wallet_outlined, 
                  color: Colors.black54, size: 14),
             const SizedBox(width: 4),
             Text(label, style: const TextStyle(color: Color(0xFF0F5050), fontSize: 12)), // Dark green text
           ],
         ),
         const SizedBox(height: 4),
         Text(amount, style: TextStyle(color: isExpense ? Colors.blue : Colors.white, fontSize: 22, fontWeight: FontWeight.bold)), // Expense Blue matches Image 4
      ],
    );
  }
}
