import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pasha_insurance/constants/strings/assets.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/constants/style/app_text_styles.dart';
import 'package:pasha_insurance/models/data/car_model.dart';
import 'package:pasha_insurance/models/data/report_model.dart';
import 'package:pasha_insurance/ui/screens/car_details_screen.dart';
import 'package:pasha_insurance/ui/screens/report_results_screen.dart';
import 'package:pasha_insurance/ui/screens/select_accident_location_screen.dart';
import 'package:pasha_insurance/ui/widgets/helpers/empty_space.dart';

class CarCard extends StatelessWidget {
  final CarModel carModel;

  const CarCard({super.key, required this.carModel});

  final double _iconSized = 72;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onCardTap(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: AppColors.thirdType.withOpacity(0.9),
          width: MediaQuery.of(context).size.width - 2 * 16, //?
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Assets.carIcon, color: AppColors.white, height: _iconSized, width: _iconSized),
                    EmptySpace.horizontal(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(carModel.model ?? "-", style: AppTextStyles.header1Style),
                        Text(carModel.plateNumber ?? "-", style: AppTextStyles.headline1Size24),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(carModel.year?.toString() ?? "-", style: AppTextStyles.body1Size16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onCardTap(BuildContext context) {
    CarDetailsScreen.open(context, carModel: carModel);
  }
}