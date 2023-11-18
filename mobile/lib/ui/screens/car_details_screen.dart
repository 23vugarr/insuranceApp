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
      appBar: AppBar(title: Text("Car Details")),
      body: SingleChildScrollView(
        child: Consumer<AccountState>(
          builder: (context, userState, _) {
            if (userState.isLoading) {
              return const LoadingSpinner();
            } else if (userState.userModel == null) {
              return const Center(child: Text("User is not loaded!", style: AppTextStyles.body1Size16));
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height - (Scaffold.of(context).appBarMaxHeight ?? 0),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EmptySpace.vertical(16),
                    _buildCard(),
                    EmptySpace.vertical(16),
                    _buildCarInfo(),
                    const Spacer(),
                    _buildButtons(),
                    EmptySpace.vertical(48),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildCard() {
    return Center(child: CarCard(carModel: widget.carModel));
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
                return TakePhotoBottomPanel(carId: widget.carModel.id ?? 0);// todo: change
              },
              backgroundColor: AppColors.lightGreyColor,
            );
          },
        )
      ],
    );
  }
}