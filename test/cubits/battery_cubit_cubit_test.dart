import 'package:bloc_test/bloc_test.dart';
import 'package:energy_monitor/cubits/battery/battery_cubit.dart';
import 'package:energy_monitor/cubits/register/down_sampling_register.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBatteryRepository extends Mock implements BatteryRepository {}

void main() {
  late BatteryCubit batteryCubit;
  late MockBatteryRepository mockBatteryRepository;
  final testDate = DateTime(2023, 1, 1);

  final testMonitoringEnergy = MonitoringEnergy(
    timestamp: testDate,
    value: 100,
  );

  setUp(() {
    mockBatteryRepository = MockBatteryRepository();
    batteryCubit = BatteryCubit(
      mockBatteryRepository,
      DataDownSampler(),
    );
  });

  group('BatteryCubit', () {
    test('initial state is correct', () {
      expect(
        batteryCubit.state,
        isA<BatteryState>()
            .having((s) => s.dataState, 'dataState', equals(DataState.none()))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isEmpty)
            .having((s) => s.axisValues, 'axisValues',
                equals(AxisValues.defaultValues()))
            .having((s) => s.unit, 'unit', equals(EnergyUnit.watts)),
      );
    });

    blocTest<BatteryCubit, BatteryState>(
      'emits loading and success states when data is fetched successfully',
      setUp: () {
        when(() => mockBatteryRepository.getBatteryConsumption(any()))
            .thenAnswer((_) async => [testMonitoringEnergy]);
      },
      build: () => batteryCubit,
      act: (cubit) => cubit.fetchData(date: testDate),
      expect: () => [
        isA<BatteryState>()
            .having(
                (s) => s.dataState, 'dataState', equals(DataState.loading()))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isEmpty),
        isA<BatteryState>()
            .having((s) => s.dataState, 'dataState', equals(DataState.full()))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isNotEmpty)
            .having((s) => s.selectedDate, 'selectedDate', equals(testDate)),
      ],
      verify: (_) {
        verify(() => mockBatteryRepository.getBatteryConsumption(testDate))
            .called(1);
      },
    );

    blocTest<BatteryCubit, BatteryState>(
      'emits error state when internet connection fails',
      setUp: () {
        when(() => mockBatteryRepository.getBatteryConsumption(any()))
            .thenThrow(InternetConnectionException());
      },
      build: () => batteryCubit,
      act: (cubit) => cubit.fetchData(date: testDate),
      expect: () => [
        isA<BatteryState>()
            .having(
                (s) => s.dataState, 'dataState', equals(DataState.loading()))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isEmpty),
        isA<BatteryState>()
            .having((s) => s.dataState, 'dataState',
                equals(DataState.error('Internet connection error')))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isEmpty),
      ],
    );

    blocTest<BatteryCubit, BatteryState>(
      'emits error state when data is not found',
      setUp: () {
        when(() => mockBatteryRepository.getBatteryConsumption(any()))
            .thenThrow(DataNotFoundException());
      },
      build: () => batteryCubit,
      act: (cubit) => cubit.fetchData(date: testDate),
      expect: () => [
        isA<BatteryState>()
            .having(
                (s) => s.dataState, 'dataState', equals(DataState.loading()))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isEmpty),
        isA<BatteryState>()
            .having((s) => s.dataState, 'dataState',
                equals(DataState.error('Unable to find relevant data.')))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isEmpty),
      ],
    );

    blocTest<BatteryCubit, BatteryState>(
      'clears data successfully',
      setUp: () {
        when(() => mockBatteryRepository.clearBatteryData())
            .thenAnswer((_) async => {});
      },
      build: () => batteryCubit,
      act: (cubit) => cubit.clearData(),
      expect: () => [
        isA<BatteryState>().having(
            (s) => s.dataState, 'dataState', equals(DataState.loading())),
        isA<BatteryState>()
            .having((s) => s.dataState, 'dataState', equals(DataState.full()))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isEmpty)
            .having((s) => s.axisValues, 'axisValues',
                equals(AxisValues.defaultValues())),
      ],
      verify: (_) {
        verify(() => mockBatteryRepository.clearBatteryData()).called(1);
      },
    );

    blocTest<BatteryCubit, BatteryState>(
      'toggles energy unit successfully',
      build: () => batteryCubit,
      act: (cubit) => cubit.toggleUnit(),
      expect: () => [
        isA<BatteryState>()
            .having((s) => s.unit, 'unit', equals(EnergyUnit.kilowatts)),
      ],
    );
  });
}
