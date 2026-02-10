import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../utils/app_colors.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({super.key});

  final List<TransactionModel> transactions = [
    TransactionModel(title: "Salary", date: "18 Apr", amount: 4000, isIncome: true),
    TransactionModel(title: "Groceries", date: "17 Apr", amount: 100, isIncome: false),
    TransactionModel(title: "Rent", date: "15 Apr", amount: 674, isIncome: false),
    TransactionModel(title: "Transport", date: "08 Apr", amount: 4.13, isIncome: false),
    TransactionModel(title: "Food", date: "31 Mar", amount: 70.40, isIncome: false),
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
                    key: const Key('transaction_back_button'),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () { 
                       // Check if can pop, else maybe switch tab? 
                       // Since it's in a tab view, maybe back isn't needed or goes to dashboard?
                       // Design shows back arrow.
                    }, 
                  ),
                  const Text("Transaction", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const Icon(Icons.notifications_outlined, color: Colors.white),
                ],
              ),
            ),
            
            // Total Balance Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: const [
                    Text("Total Balance", style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 8),
                    Text("\$7,783.00", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Income / Expense Cards
            Padding(
               padding: const EdgeInsets.symmetric(horizontal: 24),
               child: Row(
                 children: [
                   Expanded(child: _summaryCard("Income", "\$4,120.00", Colors.blue, Icons.arrow_downward)),
                   const SizedBox(width: 16),
                   Expanded(child: _summaryCard("Expense", "\$1,187.40", Colors.blue, Icons.arrow_upward)), // Design shows Blue for both? Image 3: Left Blue, Right Blue. 
                 ],
               ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                   color: AppColors.scaffoldBg,
                   borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 100),
                  child: Column(
                    children: [
                      // Grouping by Month manually for demo
                       _monthHeader("April"),
                       const SizedBox(height: 16),
                       // Filter april transactions
                       ...transactions.take(4).map((t) => _transactionItem(t)).toList(),
                       
                       const SizedBox(height: 24),
                       _monthHeader("March"),
                       const SizedBox(height: 16),
                         // Filter march transactions
                       ...transactions.skip(4).map((t) => _transactionItem(t)).toList(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String label, String amount, Color color, IconData icon) {
     return Container(
       padding: const EdgeInsets.all(16),
       decoration: BoxDecoration(
         color: color, 
         borderRadius: BorderRadius.circular(20),
       ),
       child: Column(
         children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 4),
            Text(amount, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
         ],
       ),
     );
  }

  Widget _monthHeader(String month) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(month, style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold, fontSize: 16)),
        const Icon(Icons.calendar_today_outlined, color: AppColors.primaryGreen, size: 20),
      ],
    );
  }

  Widget _transactionItem(TransactionModel t) {
      IconData icon = Icons.attach_money;
      if (t.title == 'Salary') icon = Icons.account_balance_wallet_outlined;
      if (t.title == 'Groceries') icon = Icons.shopping_bag_outlined;
      if (t.title == 'Rent') icon = Icons.vpn_key_outlined;
      if (t.title == 'Transport') icon = Icons.directions_bus_outlined;
      if (t.title == 'Food') icon = Icons.restaurant_menu;

      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
            children: [
               Container(
                 height: 50,
                 width: 50,
                 decoration: BoxDecoration(
                   color: Colors.blue.shade100, // Light blue circle
                   shape: BoxShape.circle,
                 ),
                 child: Icon(icon, color: Colors.blue, size: 24),
               ),
               const SizedBox(width: 16),
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      Text(t.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark)),
                      const SizedBox(height: 4),
                      Text("18:27 - April 30", style: TextStyle(color: Colors.blue.shade400, fontSize: 12, fontWeight: FontWeight.w500)), 
                   ],
                 ),
               ),
               
               // Middle Section (Category / Type) - Design shows "Monthly", "Pantry", etc.
               Expanded(
                 child: Text(t.isIncome ? "Monthly" : (t.title == "Groceries" ? "Pantry" : "Rent"), 
                   style: const TextStyle(color: Colors.grey, fontSize: 13),
                   textAlign: TextAlign.center,
                 ),
               ),

               Expanded(
                 child: Text(
                    "${t.isIncome ? "" : "-"}\$${t.amount.toStringAsFixed(2).replaceAll('.', ',')}",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: t.isIncome ? const Color(0xFF0F5050) : Colors.blue, 
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
               ),
            ],
          ),
      );
  }
}
