import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/data/categories.dart';

final groceryItems = [
  GroceryItem(
    id: '1',
    name: 'Milk',
    quantity: 1,
    category: categories[Categories.dairy]!,
  ),
  GroceryItem(
    id: '2',
    name: 'Bananas',
    quantity: 5,
    category: categories[Categories.fruit]!,
  ),
  GroceryItem(
    id: '3',
    name: 'Beef Steak',
    quantity: 2,
    category: categories[Categories.meat]!,
  ),
  GroceryItem(
    id: '4',
    name: 'Apples',
    quantity: 4,
    category: categories[Categories.fruit]!,
  ),
  GroceryItem(
    id: '5',
    name: 'Carrots',
    quantity: 6,
    category: categories[Categories.vegetables]!,
  ),
  GroceryItem(
    id: '6',
    name: 'Bread',
    quantity: 1,
    category: categories[Categories.carbs]!,
  ),
];
