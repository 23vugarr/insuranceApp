// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/constants/style/app_text_styles.dart';
import 'package:pasha_insurance/models/data/car_model.dart';
import 'package:pasha_insurance/models/data/report_model.dart';
import 'package:pasha_insurance/models/enum/awareness_level.dart';
import 'package:pasha_insurance/states/provider/report_state.dart';
import 'package:pasha_insurance/ui/screens/report_results_screen.dart';
import 'package:pasha_insurance/ui/widgets/dialog/result/result_dialog.dart';
import 'package:pasha_insurance/ui/widgets/helpers/empty_space.dart';
import 'package:pasha_insurance/utils/toast_notifier.dart';
import 'package:provider/provider.dart';

class TakePhotoBottomPanel extends StatefulWidget {
  final CarModel carModel;

  const TakePhotoBottomPanel({super.key, required this.carModel});

  @override
  State<TakePhotoBottomPanel> createState() => _TakePhotoBottomPanelState();
}

class _TakePhotoBottomPanelState extends State<TakePhotoBottomPanel> {

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppColors.greyTextColor1,
                    borderRadius: BorderRadius.circular(27),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 32),
                child: _buildOptions(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildOptionCard(
            context: context,
            label: "Take a photo",
            icon: Icons.camera_alt_rounded,
            onTap: () => _onTakePhotoTap(context),
          ),
          const Spacer(),
          _buildOptionCard(
            context: context,
            label: "Select a photo",
            icon: Icons.file_upload_rounded,
            onTap: () => _onSelectPhotoTap(context),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({required BuildContext context, required String label, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width / 2 - 32 - 16,
          color: AppColors.thirdType,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: AppColors.white, size: 42),
                EmptySpace.vertical(8),
                Text(label, style: AppTextStyles.body1Size16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSelectPhotoTap(BuildContext context) async {
    final ReportState reportState = Provider.of<ReportState>(context, listen: false);
    final bool isSuccess = await reportState.pickImageFromGalery();
    if (isSuccess) {
      _sendReport(context);
    } else {
      ToastNotifier.showToast(message: "Something went wrong... Please try again later.", awarenessLevel: AwarenessLevel.ERROR);
    }
  }

  void _onTakePhotoTap(BuildContext context) async {
    final ReportState reportState = Provider.of<ReportState>(context, listen: false);
    final bool isSuccess = await reportState.pickImageFromCamera();
    if (isSuccess) {
      _sendReport(context);
    } else {
      ToastNotifier.showToast(message: "Something went wrong... Please try again later.", awarenessLevel: AwarenessLevel.ERROR);
    }
  }

  void _sendReport(BuildContext context) {
    makeResultantRequest<ReportModel?>(
      context: context,
      asyncRequest: Provider.of<ReportState>(context, listen: false).sendReport(context, widget.carModel.id ?? 0),
      isSuccessful: (resp) => resp != null,
      onResult: (success, resp) {
        if (success) {
          ReportResultsScreen.open(context, reportModel: resp!, carModel: widget.carModel);
        } else {
          ToastNotifier.showToast(message: "Something went wrong... Please try again later.", awarenessLevel: AwarenessLevel.ERROR);
        }
      },
    );
  }
}