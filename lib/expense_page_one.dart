import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_one/transaction_controller.dart';

class Money extends StatelessWidget {
  const Money({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Find the Brain (Controller)
    // Get.find() would look for an existing one, but here we use Get.put()
    // to create it if it doesn't exist yet.

    TransactionController controller = Get.put(TransactionController());

    // 2. Setup "Text Recorders"
    // These allow us to read what the user types into the boxes.
    TextEditingController amountController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    TextEditingController noteController = TextEditingController();

    // 3. Setup a Variable for the Dropdown
    // .obs means "Watch this variable for changes"
    RxString selectedType = "Income".obs;

    // 1. Define your Color Palette here so it's easy to change
    final Color backgroundColor = const Color(0xFF121212); // Very dark grey
    final Color surfaceColor = const Color(
      0xFF1E1E1E,
    ); // Slightly lighter for boxes
    final Color accentColor = Colors.amber; // The "Pop" color
    final Color textColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0, // Removes shadow for a cleaner look
        backgroundColor: backgroundColor, // Matches body
        title: Center(
          child: Text(
            "Add New",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: textColor, // White text
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ), // Increased padding for breathability
        child: Column(
          children: [
            // --- DROPDOWN ---
            Container(
              alignment: Alignment.center,
              width:
                  double.infinity, // Let it fill width (looks better on mobile)
              height: 55, // Standard touch target height
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: surfaceColor, // Dark box
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: Colors.white10), // Subtle border
              ),
              child: DropdownButtonHideUnderline(
                // Obx is needed because the dropdown changes based on 'selectedType'
                child: Obx(
                  () => DropdownButton<String>(
                    isExpanded: true,
                    value: selectedType.value,
                    dropdownColor:
                        surfaceColor, // Makes the popup menu dark too!
                    icon: Icon(Icons.arrow_drop_down, color: accentColor),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                    ), // Text style
                    items: [
                      DropdownMenuItem(value: "Income", child: Text("Income")),
                      DropdownMenuItem(
                        value: "Expense",
                        child: Text("Expense"),
                      ),
                    ],
                    onChanged: (newValue) {
                      if (newValue != null) {
                        selectedType.value = newValue;
                      }
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- AMOUNT ---
            TextFormField(
              controller: amountController, //   <--- Connect the recorder
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(color: textColor), // User types in white
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.currency_rupee, color: accentColor),
                filled: true,
                fillColor: surfaceColor,
                hintText: "Amount",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- TITLE ---
            TextFormField(
              controller: titleController, //   <--- Connect the recorder
              keyboardType: TextInputType.text,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.title, color: accentColor),
                filled: true,
                fillColor: surfaceColor,
                hintText: "Title",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- NOTE ---
            TextFormField(
              controller: noteController, //   <--- Connect the recorder
              keyboardType: TextInputType.text,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.note, color: accentColor),
                filled: true,
                fillColor: surfaceColor,
                hintText: "Note",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor, // Amber button
                  foregroundColor: Colors.black, // Black text on Amber
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                onPressed: () {
                  // --- THE LOGIC ---

                  // A. Check if amount is empty (Validation)
                  if (amountController.text.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Please enter an amount",
                      backgroundColor: Colors.white,
                      colorText: Colors.red,
                    );
                    return; //Stop Here
                  }
                  if (double.tryParse(amountController.text) == null) {
                    Get.snackbar(
                      "Error",
                      "Please enter a valid number (no letters!)",
                      backgroundColor: Colors.white,
                      colorText: Colors.red,
                    );
                    return;
                  }

                  // B. Create the Data Packet (Map)
                  final newTransactions = {
                    'type': selectedType.value,
                    'amount': amountController.text,
                    'title': titleController.text,
                    'note': noteController.text,
                    'date': DateTime.now().toString(),
                  };

                  // C. Send to Controller
                  controller.addTransaction(newTransactions);
                  // D. Go back to previous screen
                  Get.back();
                },
                child: const Text(
                  "Add Transaction",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
