import 'package:flutter/material.dart';
import 'package:practice_one/expense_page_one.dart';
import 'package:get/get.dart';
import 'package:practice_one/transaction_controller.dart';
// Make sure this matches your file name

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionController controller = Get.put(TransactionController());

    // Shared Colors
    final Color backgroundColor = const Color(0xFF121212);
    final Color surfaceColor = const Color(0xFF1E1E1E);
    final Color accentColor = Colors.amber; // Matches your Add Page

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor, // Seamless look
        elevation: 0,
        title: const Center(
          child: Text(
            "Expense Tracker",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),

      // --- FAB (Matches the Amber theme of the next page) ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Using Get.to to navigate to your Money class
          Get.to(() => const Money());
        },
        backgroundColor: accentColor,
        foregroundColor: Colors.black, // Black icon on Amber looks sharp
        child: const Icon(Icons.add, size: 30),
      ),

      body: Column(
        children: [
          // --- TOP CARD (Available Balance) ---
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Container(
              width: double.infinity,
              height: 170,
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.white10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Available Balance",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Obx(()=>Text(
                    "Rs. ${controller.totalBalance.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 36, // Slightly bigger
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  ),
                ],
              ),
            ),
          ),

          // --- INCOME / EXPENSE ROW ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Income
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00C853).withOpacity(0.2),
                            shape:
                                BoxShape.circle, // Circular icons look modern
                          ),
                          child: const Icon(
                            Icons.arrow_downward,
                            color: Color(0xFF00C853),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Income",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Obx(()=>Text(
                              "Rs ${controller.totalIncome.toStringAsFixed(0)}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                        )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                // Expense
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF5252).withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_upward,
                            color: Color(0xFFFF5252),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Expense",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Obx(()=>Text(
                              "Rs ${controller.totalExpense.toStringAsFixed(0)}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                        ),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // --- RECENT TRANSACTIONS HEADER ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recent Transactions",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Optional: A "See All" button
                TextButton(
                  onPressed: () {},
                  child: Text("See All", style: TextStyle(color: accentColor)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // --- LIST VIEW ---
          Expanded(
  child: Obx(() {
    // 1. Handle Empty State
    if (controller.transactions.isEmpty) {
      return const Center(
        child: Text(
          "No Transactions yet",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    // 2. Return the List
    return ListView.builder(
      itemCount: controller.transactions.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        // Reverse index to show newest first
        int reverseIndex = controller.transactions.length - 1 - index;
        var t = controller.transactions[reverseIndex];

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 8.0,
          ),
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  // --- Icon Box ---
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: t['type'] == 'Income'
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      t['type'] == 'Income'
                          ? Icons.attach_money
                          : Icons.money_off,
                      color: t['type'] == 'Income' ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(width: 15),

                  // --- Text Info (Title & Note) ---
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t['title'], // <--- REAL DATA
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          t['note'], // <--- REAL DATA
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // --- Amount ---
                  Text(
                    "${t['type'] == 'Income' ? '+' : '-'} Rs ${t['amount']}", // <--- REAL DATA
                    style: TextStyle(
                      color:
                          t['type'] == 'Income' ? Colors.green : Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  ),



),



        ],
      ),
    );
  }
}
