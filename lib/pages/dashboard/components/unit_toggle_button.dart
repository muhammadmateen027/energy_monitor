import 'package:flutter/material.dart';

class UnitToggleButton extends StatelessWidget {
  const UnitToggleButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
    required this.color,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
