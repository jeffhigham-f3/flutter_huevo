import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huevo/core/extension/context.dart';

enum UserGoal {
  haveFun('have_fun'),
  learnFlutterAndFirebase('learn_flutter_and_firebase'),
  buildAppPortfolio('build_app_portfolio'),
  getJob('get_job');

  const UserGoal(this.id);

  static UserGoal? fromId(String? id) {
    if (id == null) {
      return null;
    }

    return UserGoal.values.firstWhereOrNull((goal) => goal.id == id);
  }

  final String id;
}

extension UserGoalEx on UserGoal {
  String getText(BuildContext context) => switch (this) {
    UserGoal.haveFun => context.l10n.goalHaveFun,
    UserGoal.learnFlutterAndFirebase =>
      context.l10n.goalLearnFlutterAndFirebase,
    UserGoal.buildAppPortfolio => context.l10n.goalBuildAppPortfolio,
    UserGoal.getJob => context.l10n.goalGetJob,
  };

  String getDescription(BuildContext context) => switch (this) {
    UserGoal.haveFun => context.l10n.goalHaveFunDescription,
    UserGoal.learnFlutterAndFirebase =>
      context.l10n.goalLearnFlutterAndFirebaseDescription,
    UserGoal.buildAppPortfolio => context.l10n.goalBuildAppPortfolioDescription,
    UserGoal.getJob => context.l10n.goalGetJobDescription,
  };
}
