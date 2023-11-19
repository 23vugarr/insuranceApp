import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/constants/style/app_text_styles.dart';
import 'package:pasha_insurance/states/provider/account_state.dart';
import 'package:pasha_insurance/states/provider/car_state.dart';
import 'package:pasha_insurance/ui/widgets/cards/car_card.dart';
import 'package:pasha_insurance/ui/widgets/custom/loading_spinner.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routePath = '/home';

  const HomeScreen({super.key});

  static void open(BuildContext context) {
    context.go(routePath);
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AccountState>(context, listen: false).fetchMe();
      Provider.of<CarState>(context, listen: false).fetchMyCars();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountState>(
      builder: (context, userState, _) {
        return Scaffold(
          backgroundColor: AppColors.forthType,
          body: _buildBody()
        );
      },
    );
  }

  Widget _buildBody() {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome, ${Provider.of<AccountState>(context, listen: false).userModel?.name ?? ""}", style: AppTextStyles.headline2Size20)),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // EmptySpace.vertical(24),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 16),
                      //   child: Text("Welcome, ${userState.userModel!.name}", style: AppTextStyles.header1Style),
                      // ),
                      // EmptySpace.vertical(64),
                      _buildCarSlider(),
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
  
  Widget _buildCarSlider() {
    return Consumer<CarState>(
      builder: (context, carState, _) {
        if (carState.isLoading) {
          return const LoadingSpinner();
        } else if (carState.carList?.isEmpty ?? true) {
          return const Text("No cars");
        }
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: ListView.builder(
              itemCount: carState.carList?.length ?? 0,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CarCard(carModel: carState.carList![index]),
                );
              },
            ),
          ),
        );
      },
    );
  }
}