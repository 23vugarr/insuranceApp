import 'package:flutter/material.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';

class LoadingSpinner extends StatelessWidget {
  final double size;

  const LoadingSpinner({super.key,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(height: size, width: size, 
      child: const CircularProgressIndicator(
        color: AppColors.secondary,
        strokeWidth: 5,
      ),
    ),
    );
  }
}
