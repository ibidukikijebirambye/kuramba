import 'package:flutter/material.dart';
import 'custom_card.dart';

class ContactFlowerpowerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AsyncSnapshot userSnapshot =
        ModalRoute.of(context).settings.arguments;

    return CustomCard(
      onTap: () {},
      child: userSnapshot.connectionState == ConnectionState.waiting
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Row(
                children: [
                  Icon(
                    //Icons.eco,
                    Icons.filter_vintage,
                    //Icons.local_florist,
                    size: 50.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 30.0),
                  Text(
                    '12345',
                    style: TextStyle(fontSize: 30.0),
                  )
                ],
              ),
            ),
    );
  }
}
