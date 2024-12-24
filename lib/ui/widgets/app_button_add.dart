import 'package:flutter/material.dart';

class AppButtonAdd extends StatelessWidget {
  const AppButtonAdd({
    super.key,
    required this.text,
    this.width = 172,
    required this.onTap,
  });

  final String text;
  final double? width;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 48,
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xff0A4E74),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          border: Border.all(color: const Color(0xff0A4E74), width: 1.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const Icon(Icons.add, color: Colors.white,)
          ],
        ),
      ),
    );
  }
}
