import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  final int cols;
  final double outterMarginsOffset;
  final List<Widget> children;

  const Grid({
    Key? key,
    required this.outterMarginsOffset,
    required this.cols,
    required this.children,
  }) : super(key: key);

  double bottomMargin(int index) => children.length > 2
      ? (index < children.length - 2 ? outterMarginsOffset : 0)
      : 0;

  double get containerOffset => (outterMarginsOffset * (cols - 1)) / cols;

  double sideSize(context) =>
      ((MediaQuery.of(context).size.width / cols) -
          ((outterMarginsOffset * 2) / cols)) -
      containerOffset;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: List.generate(
        children.length,
        (index) => Container(
          margin: EdgeInsets.only(bottom: bottomMargin(index)),
          width: sideSize(context),
          height: sideSize(context),
          child: children[index],
        ),
      ),
    );
  }
}
