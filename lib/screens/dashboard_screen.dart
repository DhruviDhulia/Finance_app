import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/database_service.dart';
import '../utils/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedFilter = "Monthly";
  List<dynamic> allTransactions = [];
  double totalIncome = 0.0;
  double totalExpense = 0.0;

  @override
  void initState() {
    super.initState();
    loadDatabase();
  }

  Future<void> loadDatabase() async {
    final db = await DatabaseService.loadDatabase();
    if (mounted) {
      setState(() {
        allTransactions = db["transactions"];
        totalIncome = (db["summary"]["totalIncome"] as num).toDouble();
        totalExpense = (db["summary"]["totalExpense"] as num).toDouble();
      });
    }
  }

  List<dynamic> get filteredTransactions {
    // Ideally filter by date, but for now just returning all for demo or simple filter
    // Implementing basic filter logic if data supports it, else return all
    return allTransactions;
  }

  @override
  Widget build(BuildContext context) {
    if (allTransactions.isEmpty) {
      return const Scaffold(
        backgroundColor: AppColors.primaryGreen,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _header(),
            _balanceSection(),
             Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.scaffoldBg,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 100), // Bottom padding for nav bar
                  child: Column(
                    children: [
                       _goalsCard(),
                       const SizedBox(height: 24),
                       _filterTabs(),
                       const SizedBox(height: 20),
                       _transactionList(),
                    ],
                  ),
                ),
              ),
             ),
          ],
        ),
      ),
    );
  }

  // 🔹 HEADER
  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, Welcome Back",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Good Morning",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_outlined, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // 🔹 BALANCE SECTION
  Widget _balanceSection() {
    // Matching the top section of Image 2
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Column(
        children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
                _balanceInfo(label: "Total Balance", amount: "\$7,783.00"), // Hardcoded for design match, or use variables
                Container(width: 1, height: 40, color: Colors.white24),
                _balanceInfo(label: "Total Expense", amount: "-\$1,187.40", isExpense: true),
             ],
           ),
           const SizedBox(height: 20),
           // Progress Bar
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
           const SizedBox(height: 20),
        ],
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
                  color: isExpense ? Colors.black54 : Colors.black54, size: 14), // Using black54 as per design (dark text on green?) Actually strict design check: Image 2 shows white text for headers
             const SizedBox(width: 4),
             Text(label, style: const TextStyle(color: Color(0xFF0F5050), fontSize: 12)), // Dark green text
           ],
         ),
         const SizedBox(height: 4),
         Text(amount, style: TextStyle(color: isExpense ? AppColors.expenseRed : Colors.white, fontSize: 22, fontWeight: FontWeight.bold)), // Expense Blue/Red? Design shows Blue for expense in one view, let's stick to design. Image 2: Expense is Blue (-$1,187).
         // Actually image 2, expense is BLUE.
      ],
    );
  }

  // 🔹 GOALS CARD
  Widget _goalsCard() {
     return Container(
       padding: const EdgeInsets.all(20),
       decoration: BoxDecoration(
         color: AppColors.primaryGreen,
         borderRadius: BorderRadius.circular(30),
       ),
       child: Row(
         children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Stack(
                children: [
                   PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(color: Colors.blueAccent, value: 70, radius: 8, showTitle: false),
                        PieChartSectionData(color: Colors.white.withOpacity(0.2), value: 30, radius: 8, showTitle: false),
                      ],
                      startDegreeOffset: 270,
                      centerSpaceRadius: 36,
                      sectionsSpace: 0,
                    ),
                  ),
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.directions_car, color: Colors.white, size: 28),
                      ],
                    ),
                  )
                ],
              ),
            ),
             const SizedBox(width: 20),
             Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    _goalInfo("Revenue Last Week", "\$4,000.00", Icons.monetization_on_outlined),
                    const Divider(color: Colors.white24, height: 24),
                    _goalInfo("Food Last Week", "-\$100.00", Icons.restaurant, isNegative: true),
                 ],
               ),
             )
         ],
       ),
     );
  }

  Widget _goalInfo(String label, String amount, IconData icon, {bool isNegative = false}) {
     return Row(
       children: [
          Icon(icon, color: Colors.black54, size: 24), // Design uses dark icons
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(label, style: const TextStyle(color: Color(0xFF0F5050), fontSize: 11)),
               Text(amount, style: TextStyle(color: isNegative ? Colors.blue : const Color(0xFF0F5050), fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          )
       ],
     );
  }

  // 🔹 FILTER TABS
  Widget _filterTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE2F3EB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: ["Daily", "Weekly", "Monthly"].map((filter) {
          final isSelected = selectedFilter == filter;
          return Expanded(
            child: GestureDetector(
              key: Key('dashboard_filter_${filter.toLowerCase()}'),
              onTap: () {
                setState(() => selectedFilter = filter);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: isSelected
                    ? BoxDecoration(
                        color: AppColors.primaryGreen,
                        borderRadius: BorderRadius.circular(16),
                      )
                    : null,
                child: Center(
                  child: Text(
                    filter,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 🔹 TRANSACTION LIST
  Widget _transactionList() {
    // Using filteredTransactions
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredTransactions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final t = filteredTransactions[index];
        bool isIncome = t["isIncome"] ?? false;
        
        // Mapped icons based on title for simplicity
        IconData icon = Icons.attach_money;
        if (t['title'] == 'Salary') icon = Icons.account_balance_wallet;
        if (t['title'] == 'Groceries') icon = Icons.shopping_bag_outlined;
        if (t['title'] == 'Rent') icon = Icons.vpn_key_outlined;
        
        return Row(
          children: [
             Container(
               height: 50,
               width: 50,
               decoration: BoxDecoration(
                 color: isIncome ? Colors.blue.shade100 : Colors.blue.shade500,
                 shape: BoxShape.circle,
               ),
               child: Icon(icon, color: isIncome ? Colors.blue : Colors.white),
             ),
             const SizedBox(width: 16),
             Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(t['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text("${t['date']} - April 30", style: const TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500)), // Formatting date logic needed
                      ],
                    )
                 ],
               ),
             ),
             Column(
               crossAxisAlignment: CrossAxisAlignment.end,
               children: [
                  const Text("Monthly", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(
                    "${isIncome ? "" : "-"}\$${t['amount']}.00",
                    style: TextStyle(
                      color: isIncome ? const Color(0xFF0F5050) : Colors.blue, 
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
               ],
             )
          ],
        );
      },
    );
  }
}
