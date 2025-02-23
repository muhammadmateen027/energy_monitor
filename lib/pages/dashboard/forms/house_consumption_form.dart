import 'package:energy_monitor/cubits/cubits.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_energy_form.dart';

class HouseConsumptionForm extends StatelessWidget {
  const HouseConsumptionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseEnergyForm(
      create: (context) =>
          HouseConsumptionCubit(context.read<HouseConsumptionRepository>())
            ..fetchData(),
      lineColor: Colors.green,
    );
  }
}
