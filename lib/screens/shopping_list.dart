import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/grocery_items.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List')),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(groceryItems[index].name),
          trailing: Text('${groceryItems[index].quantity}', style: const TextStyle(fontSize: 16)),
          leading: Container(
            color: groceryItems[index].category.color,
            width: 24,
            height: 24,
          ),
        ),
      )
    );
  }
}
