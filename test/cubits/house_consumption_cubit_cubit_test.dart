import 'package:bloc_test/bloc_test.dart';
import 'package:energy_monitor/cubits/house_consumption/house_consumption_cubit.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHouseConsumptionRepository extends Mock
    implements HouseConsumptionRepository {}

void main() {
  group('HouseConsumptionCubit', () {
    late HouseConsumptionCubit houseConsumptionCubit;
    late MockHouseConsumptionRepository mockRepository;
    final testDate = DateTime(2023, 1, 1);

    final testMonitoringEnergy = MonitoringEnergy(
      timestamp: testDate,
      value: 100,
    );

    setUp(() {
      mockRepository = MockHouseConsumptionRepository();
      houseConsumptionCubit = HouseConsumptionCubit(mockRepository);
    });

    test('initial state is correct', () {
      final initialState = HouseConsumptionState.initial(DateTime.now());
      expect(
        houseConsumptionCubit.state,
        isA<HouseConsumptionState>()
            .having((s) => s.dataState, 'dataState', equals(DataState.none()))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isEmpty)
            .having((s) => s.axisValues, 'axisValues',
                equals(AxisValues.defaultValues()))
            .having((s) => s.unit, 'unit', equals(EnergyUnit.watts)),
      );
    });

    blocTest<HouseConsumptionCubit, HouseConsumptionState>(
      'emits loading and success states when data is fetched successfully',
      setUp: () {
        when(() => mockRepository.getHouseConsumption(any()))
            .thenAnswer((_) async => [testMonitoringEnergy]);
      },
      build: () => houseConsumptionCubit,
      act: (cubit) => cubit.fetchData(date: testDate),
      expect: () => [
        isA<HouseConsumptionState>()
            .having(
                (s) => s.dataState, 'dataState', equals(DataState.loading()))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isEmpty),
        isA<HouseConsumptionState>()
            .having((s) => s.dataState, 'dataState', equals(DataState.full()))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isNotEmpty)
            .having((s) => s.selectedDate, 'selectedDate', equals(testDate)),
      ],
    );

    blocTest<HouseConsumptionCubit, HouseConsumptionState>(
      'emits error state when internet connection fails',
      setUp: () {
        when(() => mockRepository.getHouseConsumption(any()))
            .thenThrow(InternetConnectionException());
      },
      build: () => houseConsumptionCubit,
      act: (cubit) => cubit.fetchData(date: testDate),
      expect: () => [
        isA<HouseConsumptionState>().having(
            (s) => s.dataState, 'dataState', equals(DataState.loading())),
        isA<HouseConsumptionState>().having((s) => s.dataState, 'dataState',
            equals(DataState.error('Internet connection error'))),
      ],
    );

    blocTest<HouseConsumptionCubit, HouseConsumptionState>(
      'clears data successfully',
      setUp: () {
        when(() => mockRepository.clearHouseData()).thenAnswer((_) async => {});
      },
      build: () => houseConsumptionCubit,
      act: (cubit) => cubit.clearData(),
      expect: () => [
        isA<HouseConsumptionState>().having(
            (s) => s.dataState, 'dataState', equals(DataState.loading())),
        isA<HouseConsumptionState>()
            .having((s) => s.dataState, 'dataState', equals(DataState.full()))
            .having((s) => s.monitoringPoints, 'monitoringPoints', isEmpty),
      ],
    );
  });
}
