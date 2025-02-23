import 'package:flutter/material.dart';

class EnergyHeader extends StatelessWidget {
  const EnergyHeader({
    required this.lineColor,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onClearData,
    required this.onRefresh,
    super.key,
  });

  final Color lineColor;
  final DateTime selectedDate;
  final Function(DateTime?) onDateSelected;
  final VoidCallback onClearData;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          _HeaderTitle(onRefresh: onRefresh),
          const SizedBox(height: 8),
          _DateSelectionRow(
            selectedDate: selectedDate,
            onDateSelected: onDateSelected,
            onClearData: onClearData,
          ),
        ],
      ),
    );
  }
}

class _HeaderTitle extends StatelessWidget {
  const _HeaderTitle({
    required this.onRefresh,
  });

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Energy Monitoring',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: onRefresh,
        ),
      ],
    );
  }
}

class _DateSelectionRow extends StatelessWidget {
  const _DateSelectionRow({
    required this.selectedDate,
    required this.onDateSelected,
    required this.onClearData,
  });

  final DateTime selectedDate;
  final Function(DateTime?) onDateSelected;
  final VoidCallback onClearData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: this.selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              onDateSelected(selectedDate);
            },
            icon: Icon(Icons.calendar_today),
            label: Text(
              selectedDate.toLocal().toIso8601String().split('T').first,
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.clear_all),
          onPressed: onClearData,
          style: IconButton.styleFrom(
            backgroundColor:
                Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
          ),
        ),
      ],
    );
  }
}
