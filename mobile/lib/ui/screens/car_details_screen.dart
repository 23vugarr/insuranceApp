import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasha_insurance/constants/strings/app_router_consts.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/constants/style/app_text_styles.dart';
import 'package:pasha_insurance/models/data/car_model.dart';
import 'package:pasha_insurance/states/provider/account_state.dart';
import 'package:pasha_insurance/ui/widgets/buttons/primary_button.dart';
import 'package:pasha_insurance/ui/widgets/cards/car_card.dart';
import 'package:pasha_insurance/ui/widgets/cards/car_details_card.dart';
import 'package:pasha_insurance/ui/widgets/custom/custom_modal_bottom_sheet.dart';
import 'package:pasha_insurance/ui/widgets/custom/loading_spinner.dart';
import 'package:pasha_insurance/ui/widgets/helpers/empty_space.dart';
import 'package:pasha_insurance/ui/widgets/panels/take_photo_bottom_panel.dart';
import 'package:provider/provider.dart';

class CarDetailsScreen extends StatefulWidget {
  final CarModel carModel;

  const CarDetailsScreen({super.key, required this.carModel});

  static void open(BuildContext context, {required CarModel carModel}) {
    context.push(AppRouterConsts.carDetailsPath, extra: carModel.toJson());
  }

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {

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
      appBar: AppBar(title: const Text("Car Details", style: AppTextStyles.headline2Size20)),
      body: Builder(
        builder: (context) {
          return Consumer<AccountState>(
            builder: (context, userState, _) {
              if (userState.isLoading) {
                return const LoadingSpinner();
              } else if (userState.userModel == null) {
                return const Center(child: Text("User is not loaded!", style: AppTextStyles.body1Size16));
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    EmptySpace.vertical(16),
                    _buildCard(),
                    EmptySpace.vertical(16),
                    _buildCarInfo(),
                    EmptySpace.vertical(16),
                    _buildButtons(),
                    EmptySpace.vertical(48),
                  ],
                ),
              );
            },
          );
        }
      ),
    );
  }
  
  Widget _buildCard() {
    return Center(child: IgnorePointer(child: CarCard(carModel: widget.carModel)));
  }
  
  Widget _buildCarInfo() {
    return CarDetailsCard(carModel: widget.carModel);
  }
  
  Widget _buildButtons() {
    return Column(
      children: [
        PrimaryButton(
          label: "Report damage",
          onTap: () {
            showCustomModalBottomSheet(
              context: context, 
              builder: (context) {
                return TakePhotoBottomPanel(carModel: widget.carModel);
              },
              backgroundColor: AppColors.white.withOpacity(0.8),
            );
          },
        )
      ],
    );
  }
}