import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasha_insurance/constants/strings/app_router_consts.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/constants/style/app_text_styles.dart';
import 'package:pasha_insurance/models/data/car_model.dart';
import 'package:pasha_insurance/models/data/report_model.dart';
import 'package:pasha_insurance/states/provider/account_state.dart';
import 'package:pasha_insurance/ui/screens/select_accident_location_screen.dart';
import 'package:pasha_insurance/ui/widgets/buttons/primary_button.dart';
import 'package:pasha_insurance/ui/widgets/cards/car_details_card.dart';
import 'package:pasha_insurance/ui/widgets/cards/report_result_card.dart';
import 'package:pasha_insurance/ui/widgets/helpers/empty_space.dart';
import 'package:pasha_insurance/ui/widgets/text_fields/comment_field.dart';
import 'package:provider/provider.dart';

class ReportResultsScreen extends StatefulWidget {
  final ReportModel reportModel;
  final CarModel carModel;

  const ReportResultsScreen({super.key, required this.reportModel, required this.carModel});

  static void open(BuildContext context, {required ReportModel reportModel, required CarModel carModel}) {
    context.push(AppRouterConsts.reportResultsPath, extra: {
      'reportModel': reportModel.toJson(),
      'carModel': carModel.toJson()
    });
  }

  @override
  State<ReportResultsScreen> createState() => _ReportResultsScreenState();
}

class _ReportResultsScreenState extends State<ReportResultsScreen> {
  final TextEditingController _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountState>(
      builder: (context, userState, _) {
        return Scaffold(
          backgroundColor: AppColors.forthType,
          body: _buildBody(),
        );
      },
    );
  } 

  Widget _buildBody() {
    return Scaffold( 
      appBar: AppBar(title: const Text("Report results", style: AppTextStyles.headline2Size20)),
      body: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                EmptySpace.vertical(16),
                if (widget.reportModel.damages != null) ...[
                  _buildDamages(),
                  EmptySpace.vertical(16),
                ],
                if (widget.reportModel.scratches != null) ...[
                  _buildScratches(),
                  EmptySpace.vertical(16),
                ],
                if (widget.reportModel.car_parts != null) ...[
                  _buildCarParts(),
                  EmptySpace.vertical(16),
                ],
                if (widget.reportModel.overlayed_image != null) ...[
                  _buildOverlayedImage(),
                  EmptySpace.vertical(16),
                ],
                _buildCarDetails(),
                EmptySpace.vertical(16),
                _buildCommentSection(),
                EmptySpace.vertical(16),
                _buildButtons(),
                EmptySpace.vertical(48),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildDamages() {
    return ReportResultCard(title: "Damages", imageBytes: widget.reportModel.damages!);
  }
  
  Widget _buildScratches() {
    return ReportResultCard(title: "Scratches", imageBytes: widget.reportModel.scratches!);
  }
  
  Widget _buildCarParts() {
    return ReportResultCard(title: "Car parts", imageBytes: widget.reportModel.car_parts!);
  }
  
  Widget _buildOverlayedImage() {
    return ReportResultCard(title: "Overlayed image", imageBytes: widget.reportModel.overlayed_image!);
  }
  
  Widget _buildCommentSection() {
    return CommentField(controller: _commentTextController);
  }

  Widget _buildButtons() {
    return Column(
      children: [
        PrimaryButton(
          label: "Confirm",
          onTap: () => _confirmReport(callEvacuator: false),
        ),
        EmptySpace.vertical(16),
        PrimaryButton(
          label: "Confirm and call Evacuator",
          onTap: () => _confirmReport(callEvacuator: true),
        ),
        EmptySpace.vertical(16),
        PrimaryButton(
          label: "Cancel",
          color: AppColors.white,
          textColor: AppColors.primary,
          onTap: () => context.pop(),
        ),
      ],
    );
  }

  void _confirmReport({required bool callEvacuator}) {
    SelectAccidentLocationScreen.open(context, needToCallEvacuator: callEvacuator);
  }
  
  Widget _buildCarDetails() {
    return CarDetailsCard(carModel: widget.carModel);
  }
}