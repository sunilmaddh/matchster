import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/features/moduls/profile/presentation/pages/location/current_location.dart';
import 'package:matchster/shared/widgets/bar/custom_app_bar.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Premium", onTop: () {}),
      backgroundColor: AppColors.whiteColor,
      body: Column(

        children: [
          
          40.hBox, SubscriptionRow(), 20.hBox, PlanTypeFaqList()],
      ),
    );
  }
}
