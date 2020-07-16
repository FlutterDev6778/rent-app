import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    Key key,
    @required this.child,
    this.color,
    this.textColor,
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 4.0,
    this.loading = false,
    this.brightness = Brightness.dark,
    this.progressIndicatorSize,
    this.onPressed,
    this.elevation = 5,
    this.borderWidth = 0,
    this.borderColor = Colors.white,
  }) : super(key: key);
  final Widget child;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final double borderRadius;
  final bool loading;
  final Brightness brightness;
  double progressIndicatorSize;
  final VoidCallback onPressed;
  final double elevation;
  final double borderWidth;
  final Color borderColor;

  Widget buildSpinner(BuildContext context) {
    if (progressIndicatorSize == null) progressIndicatorSize = height / 2;
    final ThemeData data = Theme.of(context);
    return CupertinoTheme(
      data: CupertinoTheme.of(context).copyWith(brightness: brightness),
      child: SizedBox(
        width: progressIndicatorSize,
        height: progressIndicatorSize,
        child: CupertinoActivityIndicator(
          radius: progressIndicatorSize / 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth, color: borderColor),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius + 2),
        ),
      ),
      child: RaisedButton(
        elevation: elevation,
        child: loading ? buildSpinner(context) : child,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        color: color,
        disabledColor: color,
        textColor: textColor,
        onPressed: onPressed,
      ),
    );
  }
}
