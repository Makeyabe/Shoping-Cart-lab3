import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // เพิ่มการนำเข้า intl

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int total = 0;

  void updateTotal(int amount, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        total += amount;
      } else if (total >= amount) {
        total -= amount;
      }
    });
  }

  void clearTotal() {
    setState(() {
      total = 0;
    });
    ShoppingItemState.clearAllItems();
  }

  String formatCurrency(int amount) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Shopping Cart"),
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ShoppingItem(
                    title: "iPad",
                    price: 19000,
                    onUpdate: updateTotal,
                  ),
                  ShoppingItem(
                    title: "iPad mini",
                    price: 23000,
                    onUpdate: updateTotal,
                  ),
                  ShoppingItem(
                    title: "iPad Air",
                    price: 29000,
                    onUpdate: updateTotal,
                  ),
                  ShoppingItem(
                    title: "iPad Pro",
                    price: 39000,
                    onUpdate: updateTotal,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  formatCurrency(total),
                  style: const TextStyle(fontSize: 30),
                ),
                const Text(
                  "บาท",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: clearTotal,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        const Color(0xFF33FFF1), // เปลี่ยนสีปุ่มเป็น #33FFF1
                  ),
                  child: const Text("Clear"),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

class ShoppingItem extends StatefulWidget {
  final String title;
  final int price;
  final Function(int amount, bool isIncrement) onUpdate;

  ShoppingItem({
    required this.title,
    required this.price,
    required this.onUpdate,
  });

  @override
  State<ShoppingItem> createState() => ShoppingItemState();
}

class ShoppingItemState extends State<ShoppingItem> {
  static List<ShoppingItemState> _allItems = [];
  int count = 0;

  ShoppingItemState() {
    _allItems.add(this);
  }

  static void clearAllItems() {
    for (var item in _allItems) {
      item.clearItem();
    }
  }

  void clearItem() {
    setState(() {
      count = 0;
    });
  }

  void increment() {
    setState(() {
      count++;
    });
    widget.onUpdate(widget.price, true);
  }

  void decrement() {
    if (count > 0) {
      setState(() {
        count--;
      });
      widget.onUpdate(widget.price, false);
    }
  }

  String formatCurrency(int amount) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(fontSize: 28),
                  ),
                  Text("${formatCurrency(widget.price)} บาท")
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: decrement,
                  icon: const Icon(Icons.remove),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  count.toString(),
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: increment,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
