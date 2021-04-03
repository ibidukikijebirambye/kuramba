import 'package:flutter/material.dart';

import 'custom_card.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData iconData;
  final String routeName;

  CategoryCard({
    @required this.title,
    @required this.iconData,
    @required this.routeName,
  });

  void selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () => selectCategory(context),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 3,
              child: Icon(
                iconData,
                size: 40,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
