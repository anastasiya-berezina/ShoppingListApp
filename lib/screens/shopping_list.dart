import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/dummy_items.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List')),
      body: Column(
        children: [
          for (final item in groceryItems) 
          Container(
            width: double.infinity,
            height: 50,   
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: item.category.color,
                ),
                const SizedBox(width: 15),
                Text(item.name),
                const Spacer(),
                Text('${item.quantity}'),
              ]             
            ),
          )
        ],
      ),
    );
  }
}
