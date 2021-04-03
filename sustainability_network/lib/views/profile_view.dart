import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/current_user_provider.dart';

import 'achievements_view.dart';
import 'challenges_view.dart';
import 'statistics_view.dart';
import 'data_view.dart';

import '../widgets/cards/category_card.dart';

class ProfileView extends StatelessWidget {
  final List<Map<String, Object>> _categories = [
    {
      'title': 'Challenges',
      'iconData': Icons.grade_rounded,
      'routeName': ChallengesView.routeName,
    },
    {
      'title': 'Achievements',
      'iconData': Icons.military_tech_rounded,
      'routeName': AchievementsView.routeName,
    },
    {
      'title': 'Statistics',
      'iconData': Icons.insights_rounded,
      'routeName': StatisticsView.routeName,
    },
    {
      'title': 'Data',
      'iconData': Icons.engineering_rounded,
      'routeName': DataView.routeName,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return Consumer<CurrentUserProvider>(
      builder: (context, userProvider, _) {
        return SafeArea(
          child: ListView(
            children: [
              Container(
                height: _mediaQuery.size.width * 0.7,
                width: _mediaQuery.size.width * 0.7,
                margin: EdgeInsets.all(
                  _mediaQuery.size.width * 0.15,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    Theme.of(context).primaryColor.withOpacity(0.8),
                    Theme.of(context).primaryColor,
                  ]),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sustainability Index',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '54321',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 40,
                ),
                child: Text(
                  '${userProvider.user.username}',
                  textAlign: TextAlign.center,
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(
                  20,
                ),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) => CategoryCard(
                  title: _categories[index]['title'],
                  iconData: _categories[index]['iconData'],
                  routeName: _categories[index]['routeName'],
                ),
                itemCount: _categories.length,
              ),
            ],
          ),
        );
      },
    );
  }
}