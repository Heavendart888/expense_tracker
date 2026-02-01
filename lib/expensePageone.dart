import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Money extends StatelessWidget {
  const Money({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Define your Color Palette here so it's easy to change
    final Color backgroundColor = const Color(0xFF121212); // Very dark grey
    final Color surfaceColor = const Color(0xFF1E1E1E); // Slightly lighter for boxes
    final Color accentColor = Colors.amber; // The "Pop" color
    final Color textColor = Colors.white;

    RxString selectedValue = "1".obs;

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
                color: textColor // White text
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Increased padding for breathability
        child: Column(
          children: [
            
            // --- DROPDOWN ---
            Container(
              alignment: Alignment.center,
              width: double.infinity, // Let it fill width (looks better on mobile)
              height: 55, // Standard touch target height
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: surfaceColor, // Dark box
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: Colors.white10), // Subtle border
              ),
              child: DropdownButtonHideUnderline(
                child: Obx(
                  () => DropdownButton<String>(
                    isExpanded: true,
                    value: selectedValue.value,
                    dropdownColor: surfaceColor, // Makes the popup menu dark too!
                    icon: Icon(Icons.arrow_drop_down, color: accentColor),
                    style: TextStyle(color: textColor, fontSize: 16), // Text style
                    items: [
                      DropdownMenuItem(value: "1", child: Text("Income")),
                      DropdownMenuItem(value: "2", child: Text("Expense")),
                    ],
                    onChanged: (newValue) {
                      if (newValue != null) {
                        selectedValue.value = newValue;
                      }
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- AMOUNT ---
            TextFormField(
              keyboardType: TextInputType.number,
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
                onPressed: () {},
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