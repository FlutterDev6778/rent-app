import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rental/Utils/date_time_convert.dart';

class CustomTableWidget extends StatelessWidget {
  CustomTableWidget({
    Key key,
    @required this.width,
    @required this.rowHeight,
    this.columnNameList,
    @required this.tableData,
    this.columnWidthList = const [],
    this.columnAlignment,
    this.headerWidgets,
    this.borderType = 1,
    this.cellHorizontalPadding = 5,
    this.cellVerticlaPadding = 5,
    this.autoIncreaseColumn = "",
    this.sortData,
    this.initSortName,
    this.textStyle = const TextStyle(fontSize: 15, color: Colors.black),
    this.filter,
    this.onPressRowHandler,
  }) : super(key: key);
  final double width;
  final double rowHeight;
  List<String> columnNameList;
  final List<Map<String, dynamic>> tableData;
  final List<dynamic> columnWidthList;
  final Map<int, AlignmentGeometry> columnAlignment;
  final Map<String, dynamic> headerWidgets;
  final int borderType;
  final double cellHorizontalPadding;
  final double cellVerticlaPadding;
  final String autoIncreaseColumn;
  final Map<String, Map<String, dynamic>> sortData;
  final String initSortName;
  final TextStyle textStyle;
  final Map<String, dynamic> filter;
  final Function onPressRowHandler;
  double realWidth;
  List<double> realColumnWidthList = [];

  @override
  Widget build(BuildContext context) {
    columnNameList = columnNameList ?? headerWidgets.keys.toList();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CustomTableWidgetProvider(
            (sortData != null) ? (initSortName != null && sortData[initSortName] != null) ? initSortName : sortData.keys.toList()[0] : "",
            sortData,
          ),
        ),
      ],
      child: LayoutBuilder(builder: (context, constraints) {
        realWidth = constraints.maxWidth;
        if (realWidth.toString() == "Infinity") realWidth = width;
        return Consumer<CustomTableWidgetProvider>(
          builder: (context, customTableWidgetProvider, _) {
            double flexs = 0;
            double totalFlexWidth = realWidth;
            for (var i = 0; i < columnNameList.length; i++) {
              try {
                if (columnWidthList[i].toString().contains("w")) {
                  flexs += 0;
                  totalFlexWidth -= double.parse(columnWidthList[i].toString().split('w')[0].toString());
                } else {
                  flexs += columnWidthList[i];
                }
              } catch (e) {
                flexs += 1;
              }
            }

            for (var i = 0; i < columnNameList.length; i++) {
              try {
                if (columnWidthList[i].toString().contains("w")) {
                  realColumnWidthList.add(double.parse(columnWidthList[i].toString().split('w')[0].toString()));
                } else {
                  realColumnWidthList.add(columnWidthList[i] * (totalFlexWidth / flexs));
                }
              } catch (e) {
                realColumnWidthList.add(totalFlexWidth / flexs);
              }
            }

            List<Widget> _tableWidgetList = [];
            if (headerWidgets != null) {
              _tableWidgetList.add(_containerRowData(context, customTableWidgetProvider, headerWidgets, isHeader: true));
            }

            tableData.sort((a, b) {
              if (a.runtimeType != String && a.runtimeType != Text) return 1;
              var aValue = (a[customTableWidgetProvider.currentSortName].runtimeType == Text)
                  ? a[customTableWidgetProvider.currentSortName].data
                  : a[customTableWidgetProvider.currentSortName];
              var bValue = (b[customTableWidgetProvider.currentSortName].runtimeType == Text)
                  ? b[customTableWidgetProvider.currentSortName].data
                  : b[customTableWidgetProvider.currentSortName];

              if (customTableWidgetProvider.sortData[customTableWidgetProvider.currentSortName]["type"] == "alpha") {
                return (customTableWidgetProvider.sortData[customTableWidgetProvider.currentSortName]["desc"])
                    ? (aValue.toLowerCase().compareTo(bValue.toLowerCase())) * -1
                    : aValue.toLowerCase().compareTo(bValue.toLowerCase());
              } else if (customTableWidgetProvider.sortData[customTableWidgetProvider.currentSortName]["type"] == "number") {
                return (customTableWidgetProvider.sortData[customTableWidgetProvider.currentSortName]["desc"])
                    ? double.parse(aValue.toString()).compareTo(double.parse(bValue.toString())) * -1
                    : double.parse(aValue.toString()).compareTo(double.parse(bValue.toString()));
              } else if (customTableWidgetProvider.sortData[customTableWidgetProvider.currentSortName]["type"] == "bool") {
                return (customTableWidgetProvider.sortData[customTableWidgetProvider.currentSortName]["desc"])
                    ? (aValue.toString().toLowerCase().compareTo(bValue.toString().toLowerCase())) * -1
                    : aValue.toString().toLowerCase().compareTo(bValue.toString().toLowerCase());
              } else
                return 1;
            });
            if (tableData.length != 0) {
              for (var i = 0; i < tableData.length; i++) {
                bool isFiltered = true;
                if (filter != null) {
                  filter.forEach((key, value) {
                    if (value != "" && value != null) isFiltered = tableData[i][key].toString().contains(value);
                  });
                }

                if (isFiltered) _tableWidgetList.add(_containerRowData(context, customTableWidgetProvider, tableData[i], index: i));
              }
            } else {
              _tableWidgetList.add(
                Container(
                  height: rowHeight,
                  child: Center(child: Text("No Data", style: textStyle)),
                ),
              );
            }

            return Container(
              width: realWidth,
              child: Column(
                children: _tableWidgetList,
              ),
            );
          },
        );
      }),
    );
  }

  Widget _containerRowData(BuildContext context, CustomTableWidgetProvider customTableWidgetProvider, Map<String, dynamic> columnWidget,
      {int index = 0, bool isHeader = false}) {
    List<Widget> list = [];
    for (var i = 0; i < columnNameList.length; i++) {
      String columnName = columnNameList[i];
      dynamic flex;
      AlignmentGeometry alignment;
      Widget colWidget;

      alignment = (columnAlignment != null && columnAlignment[i] != null) ? columnAlignment[i] : Alignment.center;
      try {
        flex = columnWidthList[i];
      } catch (e) {
        flex = 1;
      }

      if (!isHeader && columnName == autoIncreaseColumn) {
        colWidget = Text((index + 1).toString(), style: textStyle);
      } else {
        try {
          colWidget = (columnWidget[columnName] != null)
              ? (columnWidget[columnName].runtimeType == String)
                  ? Text(
                      (columnName != "ts" || isHeader)
                          ? columnWidget[columnName].toString()
                          : convertMillisecondsToDateString(
                              int.parse(columnWidget[columnName]),
                              formats: [yyyy, '\n', mm, '-', dd],
                            ),
                      style: textStyle,
                      textAlign: TextAlign.center)
                  : columnWidget[columnName]
              : SizedBox();
        } catch (e) {
          print(e);
          colWidget = SizedBox();
        }
      }
      // if (flex.toString().contains("w")) {
      // double colWidth = double.parse(flex.toString().split('w')[0].toString());
      list.add(
        Container(
          width: realColumnWidthList[i],
          height: rowHeight,
          padding: EdgeInsets.symmetric(horizontal: cellHorizontalPadding, vertical: cellVerticlaPadding),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 1),
              right: ((i != columnNameList.length - 1) ? BorderSide.none : BorderSide(width: 1)),
            ),
          ),
          alignment: Alignment.center,
          child: InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              if (!isHeader && onPressRowHandler != null && columnWidget["id"] != null) {
                onPressRowHandler(columnWidget["id"]);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Container(alignment: alignment, child: colWidget)),
                // (isHeader && sortData != null && sortData[columnName] != null) ? SizedBox(width: 10) : SizedBox(),
                (isHeader && sortData != null && sortData[columnName] != null)
                    ? GestureDetector(
                        child: Icon(
                          (sortData[columnName]["desc"]) ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                          color: (customTableWidgetProvider.currentSortName == columnName) ? Colors.black : Colors.grey,
                        ),
                        onTap: () {
                          customTableWidgetProvider.setCurrentSortName(columnName);
                          Map<String, Map<String, dynamic>> sortData = customTableWidgetProvider.sortData;
                          sortData[columnName]["desc"] = !sortData[columnName]["desc"];
                          customTableWidgetProvider.setSorData(sortData);
                        },
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      );
      // }
      // else {
      // list.add(
      //   Flexible(
      //     flex: flex,
      //     child: Container(
      //       width: double.infinity,
      //       height: rowHeight,
      //       padding: EdgeInsets.symmetric(horizontal: cellHorizontalPadding, vertical: cellVerticlaPadding),
      //       alignment: Alignment.centerLeft,
      //       decoration: BoxDecoration(
      //         border: Border(
      //           left: BorderSide(width: 1),
      //           right: ((i != columnNameList.length - 1) ? BorderSide.none : BorderSide(width: 1)),
      //         ),
      //       ),
      //       child: InkWell(
      //         hoverColor: Colors.transparent,
      //         highlightColor: Colors.transparent,
      //         onTap: () {
      //           if (!isHeader && onPressRowHandler != null && columnWidget["id"] != null) {
      //             onPressRowHandler(columnWidget["id"]);
      //           }
      //         },
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             Expanded(child: Container(alignment: alignment, child: colWidget)),
      //             // (isHeader && sortData != null && sortData[columnName] != null) ? SizedBox(width: 10) : SizedBox(),
      //             (isHeader && sortData != null && sortData[columnName] != null)
      //                 ? GestureDetector(
      //                     child: Icon(
      //                       (sortData[columnName]["desc"]) ? Icons.arrow_drop_down : Icons.arrow_drop_up,
      //                       color: (customTableWidgetProvider.currentSortName == columnName) ? Colors.black : Colors.grey,
      //                     ),
      //                     onTap: () {
      //                       customTableWidgetProvider.setCurrentSortName(columnName);
      //                       // Map<String, Map<String, dynamic>> sortData = customTableWidgetProvider.sortData;
      //                       sortData[columnName]["desc"] = !sortData[columnName]["desc"];
      //                       customTableWidgetProvider.setSorData(sortData);
      //                     },
      //                   )
      //                 : SizedBox(),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // );
      // }
    }

    return Container(
      width: realWidth,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1), top: (isHeader) ? BorderSide(width: 1) : BorderSide.none)),
      child: Row(
        children: list,
      ),
    );
  }
}

class CustomTableWidgetProvider extends ChangeNotifier {
  static CustomTableWidgetProvider of(BuildContext context, {bool listen = false}) => Provider.of<CustomTableWidgetProvider>(context, listen: listen);

  CustomTableWidgetProvider(this._currentSortName, this._sortData);

  String _currentSortName;
  String get currentSortName => _currentSortName;
  void setCurrentSortName(String currentSortName) {
    if (_currentSortName != currentSortName) {
      _currentSortName = currentSortName;
    }
  }

  Map<String, Map<String, dynamic>> _sortData;
  Map<String, Map<String, dynamic>> get sortData => _sortData;
  void setSorData(Map<String, Map<String, dynamic>> sortData) {
    _sortData = sortData;
    notifyListeners();
  }
}
