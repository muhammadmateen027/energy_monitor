import 'package:energy_monitor/cubits/cubits.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_energy_form.dart';

class SolarForm extends StatelessWidget {
  const SolarForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseEnergyForm(
      create: (context) =>
          SolarCubit(context.read<SolarRepository>())..fetchData(),
      lineColor: Colors.red,
    );
  }
}
