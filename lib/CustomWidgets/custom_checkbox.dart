import 'dart:convert';

import 'package:flutter/material.dart';

class CustomCheckBox extends FormField<bool> {
  CustomCheckBox({
    Key key,
    BuildContext context,
    @required double width,
    @required double height,
    FormFieldSetter<bool> onSaveHandler,
    Function onChanged,
    FormFieldValidator<bool> onValidateHandler,
    bool value = false,
    bool autovalidate = false,
    bool enabled = true,
    bool readOnly = false,
    IconData trueIcon = Icons.check_box,
    IconData falseIcon = Icons.check_box_outline_blank,
    Color iconColor = Colors.grey,
    Color trueIconColor,
    Color falseIconColor,
    Color disabledColor = Colors.grey,
    double padding = 24.0,
    double iconSize = 25,
    String label = "",
    double labelFontSize = 10,
    Color labelColor = Colors.black,
    bool fixedHeightState = true,
    bool stateChangePossible = true,
  }) : super(
          key: key,
          onSaved: onSaveHandler,
          initialValue: value,
          autovalidate: autovalidate,
          validator: (value) {
            if (onValidateHandler != null) return onValidateHandler(value);
          },
          builder: (FormFieldState<bool> state) {
            trueIconColor = trueIconColor ?? iconColor;
            falseIconColor = falseIconColor ?? iconColor;
            // if (onChanged != null) onChanged(state.value);
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (state.value != value && !stateChangePossible) {
                state.didChange(value);
              }
            });
            return Padding(
              padding: EdgeInsets.zero,
              child: state.value
                  ? _createTappableIcon(
                      state,
                      enabled,
                      readOnly,
                      trueIcon,
                      trueIconColor,
                      disabledColor,
                      iconSize,
                      label,
                      labelFontSize,
                      labelColor,
                      width,
                      height,
                      fixedHeightState,
                      stateChangePossible,
                      onChanged,
                    )
                  : _createTappableIcon(
                      state,
                      enabled,
                      readOnly,
                      falseIcon,
                      falseIconColor,
                      disabledColor,
                      iconSize,
                      label,
                      labelFontSize,
                      labelColor,
                      width,
                      height,
                      fixedHeightState,
                      stateChangePossible,
                      onChanged,
                    ),
            );
          },
        );

  static Widget _createTappableIcon(
    FormFieldState<bool> state,
    bool enabled,
    bool readOnly,
    IconData icon,
    Color iconColor,
    Color disabledColor,
    double iconSize,
    String label,
    double labelFontSize,
    Color labelColor,
    double width,
    double height,
    bool fixedHeightState,
    bool stateChangePossible,
    Function onChanged,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          height: height,
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: (enabled && !readOnly)
                    ? () {
                        bool newState = !state.value;
                        if (stateChangePossible) state.didChange(newState);
                        if (onChanged != null) onChanged(newState);
                      }
                    : null,
                child: Icon(icon, color: enabled ? iconColor : disabledColor, size: iconSize),
              ),
              SizedBox(width: 10),
              (width == null)
                  ? GestureDetector(
                      onTap: (enabled && !readOnly)
                          ? () {
                              bool newState = !state.value;
                              if (stateChangePossible) state.didChange(newState);
                              if (onChanged != null) onChanged(newState);
                            }
                          : null,
                      child: Text(label, style: TextStyle(fontSize: labelFontSize, color: labelColor)),
                    )
                  : Expanded(
                      child: GestureDetector(
                        onTap: (enabled && !readOnly)
                            ? () {
                                bool newState = !state.value;
                                if (stateChangePossible) state.didChange(newState);
                                if (onChanged != null) onChanged(newState);
                              }
                            : null,
                        child: Text(label, style: TextStyle(fontSize: labelFontSize, color: labelColor)),
                      ),
                    )
            ],
          ),
        ),
        (state.hasError)
            ? Container(
                height: labelFontSize + 5,
                child: Text(
                  (state.errorText ?? ""),
                  style: TextStyle(fontSize: labelFontSize * 0.8, color: Colors.red),
                ),
              )
            : (fixedHeightState) ? SizedBox(height: labelFontSize + 5) : SizedBox(),
      ],
    );
  }
}
