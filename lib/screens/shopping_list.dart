import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/grocery_items.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/screens/new_item.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final List<GroceryItem> _currentGroceryItems = [];

  void _addItem() {
    Navigator.push<GroceryItem?>(
      context,
      MaterialPageRoute(builder: (context) => const NewItem()),
    ).then((newItem) {
      if (newItem == null) {
        return;
      }
      setState(() {
        _currentGroceryItems.add(newItem);
      });
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _currentGroceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget noItemsContent = const Center(
      child: Text(
        'No items added yet.',
        style: TextStyle(fontSize: 18),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List')),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
      body: _currentGroceryItems.isEmpty
          ? noItemsContent
          : ListView.builder(
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
                    final removedIndex = index;
                    setState(() {
                      _currentGroceryItems
                          .removeWhere((e) => e.id == removedItem.id);
                    });

                    final messenger = ScaffoldMessenger.of(context);
                    messenger.clearSnackBars();
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text('Removed ${removedItem.name}'),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            setState(() {
                              final insertIndex = removedIndex <=
                                      _currentGroceryItems.length
                                  ? removedIndex
                                  : _currentGroceryItems.length;
                              _currentGroceryItems.insert(
                                  insertIndex, removedItem);
                            });
                          },
                        ),
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
            ),
    );
  }
}
