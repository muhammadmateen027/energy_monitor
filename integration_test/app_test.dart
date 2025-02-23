import 'package:databases/databases.dart';
import 'package:energy_api_client/energy_api_client.dart';
import 'package:energy_monitor/app/energy_monitor_app.dart';
import 'package:energy_monitor/cubits/register/down_sampling_register.dart';
import 'package:energy_monitor/pages/pages.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase appDatabase;
  late EnergyApiClient energyApiClient;
  late InternetConnection internetConnection;
  late DataDownSampler dataDownSampler;
  late EnergyRepository energyRepository;
  late Widget app;

  setUp(() {
    appDatabase = AppDatabase();
    energyApiClient = EnergyApiClient();
    internetConnection = InternetConnection();
    dataDownSampler = DataDownSampler();

    energyRepository = EnergyRepository(
      dataPointDao: appDatabase.monitoringDataPointDao,
      apiClient: energyApiClient,
      internetConnection: internetConnection,
    );

    final batteryRepository = energyRepository;
    final houseConsumptionRepository = energyRepository;
    final solarRepository = energyRepository;

    app = EnergyMonitorApp(
      solarRepository: solarRepository,
      houseConsumptionRepository: houseConsumptionRepository,
      batteryRepository: batteryRepository,
      dataDownSampler: dataDownSampler,
    );
  });

  tearDown(() async {
    await appDatabase.close();
  });

  Future<void> pumpAppAndSettle(WidgetTester tester) async {
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();
  }

  group('Energy Monitor App Integration Tests', () {
    testWidgets('Complete app flow test', (tester) async {
      await pumpAppAndSettle(tester);
      await _testInitialSolarPage(tester);
      await _testUnitToggle(tester);
      await _testRefreshFunctionality(tester);
      await _navigateToHouseConsumption(tester);
      await _testDatePicker(tester);
      await _navigateToBattery(tester);
      await _testClearData(tester);
      await _verifyChartComponents(tester);
    });

    testWidgets('Navigation between tabs maintains state', (tester) async {
      await pumpAppAndSettle(tester);

      // Start at Solar
      expect(find.byIcon(Icons.solar_power), findsOneWidget);

      // Switch to House
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();

      // Switch to Battery
      await tester.tap(find.byIcon(Icons.battery_4_bar));
      await tester.pumpAndSettle();

      // Return to Solar
      await tester.tap(find.byIcon(Icons.solar_power));
      await tester.pumpAndSettle();

      // Verify Solar view is restored
      expect(find.byIcon(Icons.solar_power), findsOneWidget);
      expect(find.text('Energy Monitoring'), findsOneWidget);
    });

    testWidgets('Data refresh flow test', (tester) async {
      await pumpAppAndSettle(tester);

      // Test refresh on each tab
      for (var icon in [Icons.solar_power, Icons.home, Icons.battery_4_bar]) {
        await tester.tap(find.byIcon(icon));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.refresh));
        await tester.pumpAndSettle();

        // Verify chart updates
        expect(find.byType(EnergyChartCard), findsOneWidget);
      }
    });

    testWidgets('Unit toggle persistence test', (tester) async {
      await pumpAppAndSettle(tester);

      // Toggle unit on each tab
      for (var icon in [Icons.solar_power, Icons.home, Icons.battery_4_bar]) {
        await tester.tap(find.byIcon(icon));
        await tester.pumpAndSettle();

        await tester.tap(find.text('kWh'));
        await tester.pumpAndSettle();

        // Verify toggle state
        expect(find.text('Watt'), findsOneWidget);
      }
    });
  });
}

Future<void> _testInitialSolarPage(WidgetTester tester) async {
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  expect(find.text('Energy Monitoring'), findsOneWidget);
  expect(find.byIcon(Icons.solar_power), findsOneWidget);
  expect(find.byIcon(Icons.refresh), findsOneWidget);
  expect(find.byIcon(Icons.calendar_today), findsOneWidget);
  expect(find.text('kWh'), findsOneWidget);
  expect(find.text('Watt'), findsOneWidget);
}

Future<void> _testUnitToggle(WidgetTester tester) async {
  await tester.tap(find.text('kWh'));
  await tester.pumpAndSettle();
}

Future<void> _testRefreshFunctionality(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.refresh));
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
}

Future<void> _navigateToHouseConsumption(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.home));
  await tester.pumpAndSettle();
  expect(find.byIcon(Icons.home), findsOneWidget);
}

Future<void> _testDatePicker(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.calendar_today));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Cancel'));
  await tester.pumpAndSettle();
}

Future<void> _navigateToBattery(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.battery_4_bar));
  await tester.pumpAndSettle();
  expect(find.byIcon(Icons.battery_4_bar), findsOneWidget);
}

Future<void> _testClearData(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.clear_all));
  await tester.pumpAndSettle();
}

Future<void> _verifyChartComponents(WidgetTester tester) async {
  expect(find.byType(EnergyHeader), findsOneWidget);
  expect(find.byType(EnergyDataEmpty), findsOneWidget);
}
