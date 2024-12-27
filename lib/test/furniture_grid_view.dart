import 'package:adminecg/test/furniture.dart';
import 'package:flutter/material.dart';
import 'furniture_item.dart';

class FurnitureGrid extends StatefulWidget {
  const FurnitureGrid({super.key, required this.furnitures});
  final List<Furniture> furnitures;

  @override
  _FurnitureGridState createState() => _FurnitureGridState();
}

class _FurnitureGridState extends State<FurnitureGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: widget.furnitures.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 166 / 240,
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) => FurnitureItem(
        furniture: widget.furnitures[index],
      ),
    );
  }
}
