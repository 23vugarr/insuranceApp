import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pasha_insurance/constants/style/app_text_styles.dart';
import 'package:pasha_insurance/ui/widgets/helpers/empty_space.dart';

class ReportResultCard extends StatelessWidget {
  final String title;
  final List<int> imageBytes;

  const ReportResultCard({super.key, required this.title, required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: AppTextStyles.header1Style),
        EmptySpace.vertical(8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            // color: AppColors.thirdType.withOpacity(0.9),
            width: MediaQuery.of(context).size.width - 2 * 16, //?
            child: Image.memory(Uint8List.fromList(imageBytes), fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}