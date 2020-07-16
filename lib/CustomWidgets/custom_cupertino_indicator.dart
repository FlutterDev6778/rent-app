import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class CustomCupertinoIndicator extends StatelessWidget {
  const CustomCupertinoIndicator({
    Key key,
    this.brightness = Brightness.light,
    this.size = 28,
  }) : super(key: key);
  final Brightness brightness;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoTheme.of(context).copyWith(brightness: brightness),
      child: SizedBox(
        width: size,
        height: size,
        child: CupertinoActivityIndicator(
          radius: size / 2,
        ),
      ),
    );
    ;
  }
}
