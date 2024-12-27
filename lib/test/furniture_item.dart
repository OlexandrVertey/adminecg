import 'package:flutter/material.dart';

import 'furniture.dart';


class FurnitureItem extends StatelessWidget {
  const FurnitureItem({super.key,
    required this.furniture,
  });
  final Furniture furniture;

  @override
  Widget build(BuildContext context) {
    return Draggable<Furniture>(
      feedback: _feedback,
      data: furniture,
      childWhenDragging: _childWhileDragging,
      onDragStarted: () {},
      onDragCompleted: () {},
      onDraggableCanceled: (velocity, offset) {},
      child: _childWhileDragging,
    );
  }

  Widget get _feedback {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 260,
        height: 64,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    furniture.name ?? 'name',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${furniture.price?.representablePrice}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get _childWhileDragging {
    return Card(
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 0,
            child: SizedBox(
              width: 120,
              height: 48,
              child: Text(
                furniture.name ?? 'name 1',
                textAlign: TextAlign.left,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: .18,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 4,
            left: 0,
            child: Text(
              furniture.price?.representablePrice ?? ' furniture.price?.representablePrice',
              textAlign: TextAlign.left,
              overflow: TextOverflow.clip,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );
  }
}
