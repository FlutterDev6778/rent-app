import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key key,
    this.initialValue,
    @required this.width,
    @required this.height,
    this.fixedHeightState = true,
    this.prefixIcons = const [],
    this.suffixIcons = const [],
    this.isPrefixIconOutofField = false,
    this.isSuffixIconOutofField = false,
    this.iconSpacing = 10,
    this.label = "",
    this.labelFontSize,
    this.labelColor,
    this.labelSpacing = 10,
    this.border = const Border(bottom: BorderSide(width: 1, color: Colors.black)),
    this.errorBorder = const Border(bottom: BorderSide(width: 1, color: Colors.red)),
    this.borderRadius = 0,
    this.textFontSize = 20,
    this.textColor = Colors.black,
    this.hintText = "",
    this.hintTextFontSize,
    this.hintTextColor = Colors.grey,
    this.contentHorizontalPadding = 5,
    this.contentVerticalPadding = 5,
    this.textAlign = TextAlign.left,
    this.keyboardType = TextInputType.text,
    this.validatorHandler,
    this.onSaveHandler,
    this.fillColor = Colors.white,
    this.autovalidate = false,
    this.obscureText = false,
    this.autofocus = false,
    this.controller,
    this.onChangeHandler,
    this.onTapHandler,
    this.onFieldSubmittedHandler,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.done,
    this.readOnly = false,
    this.errorStringFontSize,
    this.inputFormatters,
    this.focusNode,
  }) : super(key: key);
  final String initialValue;
  final double width;
  final double height;
  final bool fixedHeightState;

  final List<Widget> prefixIcons;
  final List<Widget> suffixIcons;
  final bool isPrefixIconOutofField;
  final bool isSuffixIconOutofField;
  final double iconSpacing;
  final String label;
  final double labelFontSize;
  final Color labelColor;
  final double labelSpacing;
  final Border border;
  final Border errorBorder;
  final double borderRadius;
  final double contentHorizontalPadding;
  final double contentVerticalPadding;

  final double textFontSize;
  final Color textColor;
  final String hintText;
  final Color hintTextColor;
  double hintTextFontSize;
  final Color fillColor;

  double errorStringFontSize;
  final focusNode;

  final TextAlign textAlign;
  final TextInputType keyboardType;

  final bool autovalidate;
  final bool obscureText;
  final Function validatorHandler;
  final Function onSaveHandler;
  final TextEditingController controller;
  final Function onChangeHandler;
  final Function onTapHandler;
  final Function onFieldSubmittedHandler;
  final bool autofocus;
  final int maxLines;
  final TextInputAction textInputAction;
  final bool readOnly;
  final inputFormatters;

  @override
  Widget build(BuildContext context) {
    BorderSide hideBorderSide = BorderSide(width: 0, color: fillColor);
    if (errorStringFontSize == null) errorStringFontSize = textFontSize * 0.8;

    return Material(
      color: fillColor,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CustomTextFormFieldProvider()),
        ],
        child: Consumer<CustomTextFormFieldProvider>(
          builder: (context, customTextFormFieldProvider, _) {
            Widget prefixIcon = SizedBox();
            Widget suffixIcon = SizedBox();
            if (prefixIcons.length != 0 && customTextFormFieldProvider.isValidated) {
              prefixIcon = prefixIcons[0];
            } else if (prefixIcons.length != 0 && !customTextFormFieldProvider.isValidated) {
              prefixIcon = prefixIcons.length == 2 ? prefixIcons[1] : prefixIcons[0];
            }

            if (suffixIcons.length != 0 && customTextFormFieldProvider.isValidated) {
              suffixIcon = suffixIcons[0];
            } else if (suffixIcons.length != 0 && !customTextFormFieldProvider.isValidated) {
              suffixIcon = suffixIcons.length == 2 ? suffixIcons[1] : suffixIcons[0];
            }

            return Container(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  (isPrefixIconOutofField) ? prefixIcon : SizedBox(),
                  (isPrefixIconOutofField && prefixIcons.length != 0) ? SizedBox(width: iconSpacing) : SizedBox(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        (label != "")
                            ? Text(label, style: TextStyle(fontSize: labelFontSize ?? textFontSize, color: labelColor ?? textColor))
                            : SizedBox(),
                        (label != "") ? SizedBox(height: labelSpacing) : SizedBox(),
                        Container(
                          width: double.maxFinite,
                          height: height,
                          padding: EdgeInsets.symmetric(horizontal: contentHorizontalPadding, vertical: contentVerticalPadding),
                          alignment: (keyboardType == TextInputType.multiline) ? Alignment.topLeft : Alignment.center,
                          decoration: BoxDecoration(
                            color: fillColor,
                            border: (customTextFormFieldProvider.errorText == "") ? border : errorBorder,
                            borderRadius: ((customTextFormFieldProvider.errorText == "" && border.isUniform) ||
                                    (customTextFormFieldProvider.errorText != "" && errorBorder.isUniform))
                                ? BorderRadius.circular(borderRadius)
                                : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              (!isPrefixIconOutofField && prefixIcons.length != 0) ? prefixIcon : SizedBox(),
                              (!isPrefixIconOutofField && prefixIcons.length != 0) ? SizedBox(width: iconSpacing) : SizedBox(),
                              Expanded(
                                child: TextFormField(
                                  focusNode: focusNode,
                                  initialValue: initialValue,
                                  style: TextStyle(color: textColor, fontSize: textFontSize),
                                  autofocus: autofocus,
                                  maxLines: maxLines,
                                  textInputAction: textInputAction,
                                  readOnly: readOnly,
                                  textAlign: textAlign,
                                  keyboardType: keyboardType,
                                  autovalidate: autovalidate,
                                  controller: controller,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(fontSize: 0, color: fillColor),
                                    isDense: true,
                                    hintText: hintText,
                                    hintStyle: TextStyle(fontSize: hintTextFontSize ?? textFontSize, color: hintTextColor),
                                    border: UnderlineInputBorder(borderSide: hideBorderSide),
                                    enabledBorder: UnderlineInputBorder(borderSide: hideBorderSide),
                                    focusedBorder: UnderlineInputBorder(borderSide: hideBorderSide),
                                    focusedErrorBorder: UnderlineInputBorder(borderSide: hideBorderSide),
                                    errorBorder: UnderlineInputBorder(borderSide: hideBorderSide),
                                    disabledBorder: UnderlineInputBorder(borderSide: hideBorderSide),
                                    filled: true,
                                    fillColor: fillColor,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  inputFormatters: inputFormatters,
                                  obscureText: obscureText,
                                  onTap: onTapHandler,
                                  onChanged: (input) {
                                    customTextFormFieldProvider.setErrorText("");
                                    if (onChangeHandler != null) onChangeHandler(input);
                                  },
                                  validator: (input) {
                                    if (validatorHandler == null) return null;
                                    var result = validatorHandler(input);
                                    if (result != null)
                                      customTextFormFieldProvider.setIsValidated(false, result);
                                    else
                                      customTextFormFieldProvider.setIsValidated(true, "");
                                    return result;
                                  },
                                  onSaved: (input) {
                                    if (onSaveHandler == null) return null;
                                    onSaveHandler(input.trim());
                                  },
                                  onFieldSubmitted: onFieldSubmittedHandler,
                                ),
                              ),
                              (!isSuffixIconOutofField && suffixIcons.length != 0) ? SizedBox(width: iconSpacing) : SizedBox(),
                              (!isSuffixIconOutofField && suffixIcons.length != 0) ? suffixIcon : SizedBox(),
                            ],
                          ),
                        ),
                        (customTextFormFieldProvider.errorText != "")
                            ? Container(
                                height: errorStringFontSize,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  customTextFormFieldProvider.errorText,
                                  style: TextStyle(fontSize: errorStringFontSize, color: Colors.red),
                                ),
                              )
                            : (fixedHeightState) ? SizedBox(height: errorStringFontSize) : SizedBox(),
                      ],
                    ),
                  ),
                  (isSuffixIconOutofField && suffixIcons.length != 0) ? SizedBox(width: iconSpacing) : SizedBox(),
                  (isSuffixIconOutofField) ? suffixIcon : SizedBox(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomTextFormFieldProvider extends ChangeNotifier {
  static CustomTextFormFieldProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<CustomTextFormFieldProvider>(context, listen: listen);

  bool _isValidated = false;
  bool get isValidated => _isValidated;

  String _errorText = "";
  String get errorText => _errorText;

  void setErrorText(String errorText) {
    if (_errorText != errorText) {
      _errorText = errorText;
      notifyListeners();
    }
  }

  void setIsValidated(bool isValidated, String errorText) {
    if (_isValidated != isValidated || _errorText != errorText) {
      _isValidated = isValidated;
      _errorText = errorText;
      notifyListeners();
    }
  }
}
