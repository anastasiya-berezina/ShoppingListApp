import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/screens/new_item.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<GroceryItem> _currentGroceryItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
      'flutter-demo-35f54-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      //error handling
      setState(() {
        _isLoading = false;
        _error = 'Failed to load items. Please try again later.';
      });
      return;
    }

    final Map<String, dynamic> listData = json.decode(response.body);

    final List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
            (catItem) => catItem.value.title == item.value['category'],
          )
          .value;
      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: int.parse(item.value['quantity']),
          category: category,
        ),
      );
    }
    setState(() {
      _currentGroceryItems = loadedItems;
      _isLoading = false;
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (context) => const NewItem()),
    );

    if (newItem == null) {
      return;
    }
    setState(() {
      _currentGroceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    final index = _currentGroceryItems.indexOf(item);
    setState(() {
      _currentGroceryItems.remove(item);
    });

    final url = Uri.https(
      'flutter-demo-35f54-default-rtdb.firebaseio.com',
      'shopping-list/${item.id}.json',
    );

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        _currentGroceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No items added yet.', style: TextStyle(fontSize: 18)),
    );

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      content = Center(
        child: Text(_error!, style: const TextStyle(fontSize: 18)),
      );
    }

    if (_currentGroceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _currentGroceryItems.length,
        itemBuilder: (context, index) {
          final item = _currentGroceryItems[index];
          return Dismissible(
            key: ValueKey(item.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: const Color.fromARGB(57, 244, 67, 54),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.delete, color: Colors.red),
            ),
            onDismissed: (direction) {
              final removedItem = item;
              _removeItem(item);

              final messenger = ScaffoldMessenger.of(context);
              messenger.clearSnackBars();
              messenger.showSnackBar(
                SnackBar(
                  content: Text('Removed ${removedItem.name}'),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
            child: ListTile(
              title: Text(item.name),
              trailing: Text(
                '${item.quantity}',
                style: const TextStyle(fontSize: 16),
              ),
              leading: Container(
                color: item.category.color,
                width: 24,
                height: 24,
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List')),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
      body: content,
    );
  }
}
