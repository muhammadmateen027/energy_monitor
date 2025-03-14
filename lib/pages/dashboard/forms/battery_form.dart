import 'package:energy_monitor/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_energy_form.dart';

class BatteryForm extends StatelessWidget {
  const BatteryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseEnergyForm(
      create: (context) => BlocProvider.of<BatteryCubit>(context),
      lineColor: Colors.blue,
    );
  }
}
