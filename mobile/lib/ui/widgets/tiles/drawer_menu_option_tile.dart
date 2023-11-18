import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/constants/style/app_text_styles.dart';
import 'package:pasha_insurance/ui/widgets/helpers/empty_space.dart';

class DrawerMenuOptionTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  const DrawerMenuOptionTile({super.key,
    required this.title, 
    required this.iconPath,
    this.onTap,
    this.padding = const EdgeInsets.fromLTRB(16, 8, 0, 8),
  });

  final double iconSize = 20;

  @override
  Widget build(BuildContext context) {  // todo: maybe add some effects on tapping event
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(iconPath, height: 20, width: iconSize, color: AppColors.darkGreyColor),
            EmptySpace.horizontal(16),
            Text(title, style: AppTextStyles.body1Size16),
          ],
        ),
      ),
    );
  }
}