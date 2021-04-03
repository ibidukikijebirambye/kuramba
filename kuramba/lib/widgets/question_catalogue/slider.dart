import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {

  int _value = 6;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Slider(
            value: _value.toDouble(),
            min: 0.0,
            max: 10.0,
            divisions: 10,
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Theme.of(context).accentColor,
            label: _value.toString(),
            onChanged: (double newValue) {
              setState(() {
                _value = newValue.round();
              });
              },
            ),
    );
  }
}
