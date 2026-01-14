import 'package:flutter/material.dart';

class ShoppingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: const Center(
        child: Text('Your shopping list is empty.'),
      ),
    );
  }
}