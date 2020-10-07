import 'package:flutter/material.dart';

class AnimatedStyleText extends StatefulWidget {
  final String text;
  final TextStyle initialStyle;
  final TextStyle finalStyle;

  AnimatedStyleText(this.text,
      {@required this.initialStyle, @required this.finalStyle});

  @override
  _AnimatedStyleTextState createState() => _AnimatedStyleTextState();
}

class _AnimatedStyleTextState extends State<AnimatedStyleText> {
  TextStyle _currentStyle;

  _start() async {
    setState(() {
      _currentStyle = widget.finalStyle;
    });
  }

  @override
  void initState() {
    _currentStyle = widget.initialStyle;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _start();
    });
    return Container(
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 1000),
        style: _currentStyle,
        curve: Curves.decelerate,
        child: Text(widget.text),
      ),
    );
  }
}
