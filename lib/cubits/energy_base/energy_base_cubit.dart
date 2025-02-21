import 'package:bloc/bloc.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:equatable/equatable.dart';

import '../register/down_sampling_register.dart';

part 'energy_base_state.dart';

abstract class EnergyBaseCubit<T extends EnergyBaseState> extends Cubit<T>
    with DownSamplingRegister {
  EnergyBaseCubit(super.initialState);

  Future<void> fetchData(DateTime date);

  void toggleUnit() {
    final newUnit =
        state.unit.isWatts ? EnergyUnit.kilowatts : EnergyUnit.watts;

    emit(
      state.copyWith(
        unit: newUnit,
        monitoringPoints: state.monitoringPoints
            .map((entry) => entry.copyWith(newUnit))
            .toList(),
      ) as T,
    );
  }
}
