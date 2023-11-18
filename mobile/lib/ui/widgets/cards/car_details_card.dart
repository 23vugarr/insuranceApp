import 'package:flutter/material.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/constants/style/app_text_styles.dart';
import 'package:pasha_insurance/models/data/car_model.dart';
import 'package:pasha_insurance/ui/widgets/helpers/empty_space.dart';

class CarDetailsCard extends StatelessWidget {
  final CarModel carModel;

  const CarDetailsCard({Key? key, required this.carModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: AppColors.forthType,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Car Details', style: AppTextStyles.boldSize24),
            EmptySpace.vertical(16),
            _buildDetailRow('Plate Number', carModel.plateNumber),
            _buildDetailRow('Year', carModel.year?.toString()),
            _buildDetailRow('Model', carModel.model),
            _buildDetailRow('Color', carModel.color),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.body1Size18.copyWith(fontWeight: FontWeight.w500)),
          Text(value ?? 'N/A', style: AppTextStyles.body1Size16),
        ],
      ),
    );
  }
}
