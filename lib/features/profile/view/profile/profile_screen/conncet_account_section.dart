import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/widgets/add_instagram_card.dart';
import 'package:matchster/features/profile/widgets/add_spotify_card.dart';

class ConnectAccountsSection extends StatelessWidget {
  const ConnectAccountsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.labelLarge(
            AppStrings.connectAccounts,
            fontWeight: FontWeight.w700,
          ),
          CommonText.labelMedium(
            AppStrings.buildYourConnectionMore,
            fontWeight: FontWeight.w300,
          ),
          5.hBox,
          AddInstagramCard(),
          30.hBox,
          AddSpotifyCard(),
        ],
      ),
    );
  }
}
