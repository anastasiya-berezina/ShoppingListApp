import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/grocery_items.dart';
import 'package:shopping_list_app/screens/new_item.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  void _addItem() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewItem()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List')),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(groceryItems[index].name),
          trailing: Text(
            '${groceryItems[index].quantity}',
            style: const TextStyle(fontSize: 16),
          ),
          leading: Container(
            color: groceryItems[index].category.color,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
