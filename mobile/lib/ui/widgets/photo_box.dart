import 'package:flutter/material.dart';
import 'package:pasha_insurance/constants/strings/assets.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';

class PhotoBox extends StatelessWidget {
  final double size;

  const PhotoBox({super.key, this.size = 60});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Image.asset(Assets.defaultProfilePhoto, fit: BoxFit.contain) // todo: add photo stuff
      ),
    );
  }
}