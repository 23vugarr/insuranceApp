import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasha_insurance/constants/strings/app_router_consts.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/constants/style/app_text_styles.dart';
import 'package:pasha_insurance/states/provider/account_state.dart';
import 'package:pasha_insurance/ui/widgets/buttons/primary_button.dart';
import 'package:pasha_insurance/ui/widgets/custom/loading_spinner.dart';
import 'package:pasha_insurance/ui/widgets/helpers/empty_space.dart';
import 'package:provider/provider.dart';

class ReportDamageScreen extends StatefulWidget { // todo: remove!
  final File file;

  const ReportDamageScreen({super.key, required this.file});

  static void open(BuildContext context, {required File file}) {
    context.push(AppRouterConsts.reportDamagedCarPath, extra: file);
  }

  @override
  State<ReportDamageScreen> createState() => _ReportDamageScreenState();
}

class _ReportDamageScreenState extends State<ReportDamageScreen> {
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
          return SizedBox(
            height: MediaQuery.of(context).size.height - (Scaffold.of(context).appBarMaxHeight ?? 0),
            width: MediaQuery.of(context).size.width,
            child: Consumer<AccountState>(
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
                      _buildImageView(),
                      EmptySpace.vertical(16),
                      _buildButton(),
                      EmptySpace.vertical(48),
                    ],
                  ),
                );
              },
            ),
          );
        }
      ),
    );
  }
  
  Widget _buildImageView() {
    return SizedBox(
      height: 500,
      width: MediaQuery.of(context).size.width - 32,
      child: Image.file(widget.file, fit: BoxFit.cover),
    );
  }
  
  Widget _buildButton() {
    return Column(
      children: [
        PrimaryButton(
          label: "Send Report",
          onTap: () {
            // todo: send request to api
          },
        )
      ],
    );
  }
}