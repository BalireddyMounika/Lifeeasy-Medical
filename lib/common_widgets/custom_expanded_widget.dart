import 'package:flutter/material.dart';

typedef OnChangedDate = void Function(bool isExpanded);
//ignore: must_be_immutable
class CustomExpandedWidget extends StatefulWidget {
  final OnChangedDate? isExpanded;
  bool expandWidget = true;
  Widget? header;
  Widget? body;
  Color? headerBackgroundColor;
  Color? arrowExpandedColor;
  Color? arrowClosedColor;

  CustomExpandedWidget(
      {this.isExpanded,
        this.header,
        this.body,
        this.headerBackgroundColor,
        required this.expandWidget,
        this.arrowExpandedColor,
        this.arrowClosedColor});

  @override
  _CustomExpandedWidgetState createState() => _CustomExpandedWidgetState();
}

class _CustomExpandedWidgetState extends State<CustomExpandedWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          color: widget.headerBackgroundColor,
          child: InkWell(
            onTap: () {
              setState(() {
                widget.expandWidget = !widget.expandWidget;

                if (widget.isExpanded != null)
                  widget.isExpanded!(widget.expandWidget);
              });
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: widget.header!,
                ),
                ExpandIcon(
                  isExpanded: widget.expandWidget,
                  color: widget.arrowClosedColor ?? Colors.black,
                  expandedColor: widget.arrowExpandedColor ?? Colors.black,
                  disabledColor: Colors.grey,
                  onPressed: (bool isExpanded) {
                    setState(() {
                      widget.expandWidget = !widget.expandWidget;

                      if (widget.isExpanded != null)
                        widget.isExpanded!(widget.expandWidget);
                    });
                  },
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(height: 0.0),
          secondChild: widget.body!,
          firstCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
          secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
          sizeCurve: Curves.fastOutSlowIn,
          crossFadeState: widget.expandWidget
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: Duration(seconds: 1),
        ),
      ],
    );
  }
}
