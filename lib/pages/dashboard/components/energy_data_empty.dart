import 'package:flutter/material.dart';

class EnergyDataEmpty extends StatelessWidget {
  const EnergyDataEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('📊', style: TextStyle(fontSize: 64)),
          Text(
            'No energy data available',
            style: theme.textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
