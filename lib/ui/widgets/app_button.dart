import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading,
    this.isActive = true,
    this.width = 500,
  });

  final String text;
  final Function() onTap;
  final bool? isLoading;
  final bool isActive;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 56,
        width: width,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xff0A4E74) : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          border: Border.all(color: const Color(0xff0A4E74), width: 1.3),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: isActive ? Colors.white : const Color(0xff0A4E74),
          ),
        ),
      ),
    );
  }
}
