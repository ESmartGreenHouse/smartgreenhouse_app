import 'dart:math';

import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  final kTabletBreakpoint;
  final kDesktopBreakpoint;
  final List<Widget> children;

  const ResponsiveGrid({
    Key key, 
    @required this.children,
    this.kTabletBreakpoint = 720.0,
    this.kDesktopBreakpoint = 1440.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        var columns = 1;

        if (media.size.width >= kTabletBreakpoint) {
          columns = 2;
        }

        if (media.size.width >= kDesktopBreakpoint) {
          columns = 3;
        }

        final chunks = chunk(children, columns);

        print(media.size.width);

        return SingleChildScrollView(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(columns, (index) => Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: chunks.map((c) => index < c.length ? c[index] : Container()).toList(),
              ),
            )),
          ),
        );
      }
    );
  }
}

List<List<T>> chunk<T>(List<T> lst, int size) {
  return List.generate(
    (lst.length / size).ceil(),
    (i) => lst.sublist(i * size, min(i * size + size, lst.length))
  );
}
