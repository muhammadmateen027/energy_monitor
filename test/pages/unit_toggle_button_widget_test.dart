import 'package:energy_monitor/pages/dashboard/components/unit_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UnitToggleButton', () {
    testWidgets('renders correctly and handles tap', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: UnitToggleButton(
            text: 'kWh',
            isSelected: true,
            onPressed: () => tapped = true,
            color: Colors.blue,
          ),
        ),
      );

      expect(find.text('kWh'), findsOneWidget);
      await tester.tap(find.text('kWh'));
      expect(tapped, true);
    });
  });
}
