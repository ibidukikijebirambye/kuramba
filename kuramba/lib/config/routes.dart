import 'package:flutter/material.dart';

import '../views/settings/main_settings_view.dart';
import '../views/settings/theme_settings_view.dart';
import '../views/challenges_view.dart';
import '../views/achievements_view.dart';
import '../views/statistics_view.dart';
import '../views/data_view.dart';
import '../views/info_view.dart';
import '../views/contact_profile_view.dart';
import '../views/search_view.dart';
import '../views/question_view.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  MainSettingsView.routeName: (context) => MainSettingsView(),
  ThemeSettingsView.routeName: (context) => ThemeSettingsView(),
  ChallengesView.routeName: (context) => ChallengesView(),
  AchievementsView.routeName: (context) => AchievementsView(),
  StatisticsView.routeName: (context) => StatisticsView(),
  InfoView.routeName: (context) => InfoView(),
  ContactProfileView.routeName: (context) => ContactProfileView(),
  DataView.routeName: (context) => DataView(),
  SearchView.routeName: (context) => SearchView(),
  QuestionView.routeName: (context) => QuestionView(),
};
