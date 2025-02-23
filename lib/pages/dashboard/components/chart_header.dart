import 'package:flutter/material.dart';

import '../../../models/models.dart';
import 'components.dart';

class ChartHeader extends StatelessWidget {
  const ChartHeader({
    required this.lineColor,
    required this.unit,
    required this.onUnitToggle,
    super.key,
  });

  final Color lineColor;
  final EnergyUnit unit;
  final VoidCallback onUnitToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Energy Consumption',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: lineColor,
                ),
          ),
          Container(
            decoration: BoxDecoration(
              color: lineColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                UnitToggleButton(
                  text: 'kWh',
                  isSelected: unit.isKilowatts,
                  onPressed: onUnitToggle,
                  color: lineColor,
                ),
                UnitToggleButton(
                  text: 'Watt',
                  isSelected: unit.isWatts,
                  onPressed: onUnitToggle,
                  color: lineColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
