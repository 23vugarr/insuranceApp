import 'package:pasha_insurance/app.dart';
import 'package:flutter/material.dart';

import 'config/main_configurations.dart';

Future<void> main() async {
  await MainConfigurations.configure();
  
  runApp(const PashaInsurance());
}