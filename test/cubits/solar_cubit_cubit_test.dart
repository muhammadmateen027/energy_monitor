import 'package:bloc_test/bloc_test.dart';
import 'package:energy_monitor/cubits/register/down_sampling_register.dart';
import 'package:energy_monitor/cubits/solar/solar_cubit.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSolarRepository extends Mock implements SolarRepository {}

void main() {
  late SolarCubit solarCubit;
  late MockSolarRepository mockRepository;
  final testDate = DateTime(2023, 1, 1);

  final testMonitoringEnergy = MonitoringEnergy(
    timestamp: testDate,
    value: 100,
  );

  setUp(() {
    mockRepository = MockSolarRepository();
    solarCubit = SolarCubit(mockRepository, DataDownSampler());
  });

  group('SolarCubit', () {
    test('initial state is correct', () {
      expect(
        solarCubit.state,
        isA<SolarState>()
            .having((s) => s.dataState, 'dataState', equals(DataState.none()))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isEmpty)
            .having((s) => s.axisValues, 'axisValues',
                equals(AxisValues.defaultValues()))
            .having((s) => s.unit, 'unit', equals(EnergyUnit.watts)),
      );
    });

    blocTest<SolarCubit, SolarState>(
      'emits loading and success states when data is fetched successfully',
      setUp: () {
        when(() => mockRepository.getSolarGeneration(any()))
            .thenAnswer((_) async => [testMonitoringEnergy]);
      },
      build: () => solarCubit,
      act: (cubit) => cubit.fetchData(date: testDate),
      expect: () => [
        isA<SolarState>()
            .having(
                (s) => s.dataState, 'dataState', equals(DataState.loading()))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isEmpty),
        isA<SolarState>()
            .having((s) => s.dataState, 'dataState', equals(DataState.full()))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isNotEmpty)
            .having((s) => s.selectedDate, 'selectedDate', equals(testDate)),
      ],
    );

    blocTest<SolarCubit, SolarState>(
      'emits error state when internet connection fails',
      setUp: () {
        when(() => mockRepository.getSolarGeneration(any()))
            .thenThrow(InternetConnectionException());
      },
      build: () => solarCubit,
      act: (cubit) => cubit.fetchData(date: testDate),
      expect: () => [
        isA<SolarState>().having(
            (s) => s.dataState, 'dataState', equals(DataState.loading())),
        isA<SolarState>().having((s) => s.dataState, 'dataState',
            equals(DataState.error('Internet connection error'))),
      ],
    );

    blocTest<SolarCubit, SolarState>(
      'clears data successfully',
      setUp: () {
        when(() => mockRepository.clearSolarData()).thenAnswer((_) async => {});
      },
      build: () => solarCubit,
      act: (cubit) => cubit.clearData(),
      expect: () => [
        isA<SolarState>().having(
            (s) => s.dataState, 'dataState', equals(DataState.loading())),
        isA<SolarState>()
            .having((s) => s.dataState, 'dataState', equals(DataState.full()))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isEmpty),
      ],
    );
  });
}
