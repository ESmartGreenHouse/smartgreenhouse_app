import 'package:flutter/material.dart';

class CustomGrid extends StatelessWidget {
  final List<Widget> children;
  final int columnCount;

  CustomGrid({
    this.columnCount = 2,
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final columns = <Widget>[];

    for (var columnNum = 0; columnNum < columnCount; columnNum++) {
      final column = <Widget>[];

      for (var rowNum = 0; (rowNum * columnCount + columnNum) < children.length; rowNum++) {
        column.add(children.elementAt(rowNum * columnCount + columnNum));
      }

      columns.add(
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: column,
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: columns,
    );
  }
}
