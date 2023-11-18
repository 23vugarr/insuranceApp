import 'package:flutter/material.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/models/local/drawer_menu_options.dart';
import 'package:pasha_insurance/ui/widgets/helpers/empty_space.dart';
import 'package:pasha_insurance/ui/widgets/photo_box.dart';
import 'package:pasha_insurance/ui/widgets/tiles/drawer_menu_option_tile.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
    // final bool shouldFetchUserInfo = context.read<UserCubit>().state is UserEmpty;
    // if (shouldFetchUserInfo) {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     context.read<UserCubit>().fetchMe();
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.white, boxShadow: [
        BoxShadow(
          color: AppColors.darkGreyColor, blurRadius: 2, spreadRadius: 0)
      ]),
      child: SizedBox()
      // BlocConsumer<UserCubit, UserState>(
      //   listenWhen: (previous, current) => current is UserLoadingFailed && previous is UserLoaded,
      //   listener: (previous, current) => ToastNotifier.showToast(message: "Failed to get user information!"),
      //   buildWhen: (previous, current) => current is! UserLoadingFailed || !(current is UserLoaded && previous is UserLoadingFailed),  //?
      //   builder: (context, state) {
      //     if (state is UserLoading) {
      //       return const LoadingSpinner();
      //     } 
      //     return _buildBody(state);
      //   },
      // ),
    );
  }

  // Widget _buildBody(UserState state) {
  //   return Column(
  //     children: [
  //       _buildHeader(state),
  //       if (state is UserLoaded) _buildDrawerMenuOptions()
  //     ],
  //   );
  // }

  // Widget _buildHeader(UserState state) {
  Widget _buildHeader() {
    // const Color textColor = AppColors.darkestGreyColor;

    return Container(
      color: AppColors.secondary,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PhotoBox(),
            EmptySpace.vertical(8),
            // Text(state is UserLoaded ? state.userModel.name! : "NO DATA", style: AppTextStyles.body1Size18.copyWith(color: textColor)),
            // Text(state is UserLoaded ? formatRawPhoneNumber(state.userModel.phoneNumber!) : "NO DATA", style: AppTextStyles.captionSize12.copyWith(color: textColor)),
            // Text(state is UserLoaded ? state.userModel.phoneNumber.toString() : "NO DATA", style: AppTextStyles.captionSize12.copyWith(color: textColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerMenuOptions() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        itemCount: DrawerMenuOptions.menuOptions.length,
        itemBuilder: (context, index) {
          final DrawerMenuOption menuOption = DrawerMenuOptions.menuOptions[index];
          return DrawerMenuOptionTile(
            title: menuOption.title, 
            iconPath: menuOption.iconPath,
            onTap: () {
              // todo: open corresponging page
            },
          );
        },
      ),
    );
  }
}