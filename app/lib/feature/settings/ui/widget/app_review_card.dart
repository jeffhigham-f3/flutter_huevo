import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter_huevo/core/app/constants.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/feature/explore/ui/widget/explore_card.dart';

class AppReviewCard extends StatelessWidget {
  const AppReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ExploreCard(
      title: context.l10n.appReviewTitle,
      content: Text(context.l10n.appReviewDescription),
      action: FilledButton(
        onPressed: () =>
            InAppReview.instance.openStoreListing(appStoreId: appleAppStoreId),
        child: Text(context.l10n.leaveYourReview),
      ),
    );
  }
}
