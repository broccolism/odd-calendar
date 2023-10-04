import 'package:flutter/widgets.dart';

class DateTile extends StatefulWidget {
  final DateTime date;
  final bool visible;
  final Color? backgroundColor;
  const DateTile({super.key, required this.date, this.backgroundColor, this.visible = true});

  @override
  State<DateTile> createState() => _DayTileState();
}

class _DayTileState extends State<DateTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.backgroundColor,
        child: widget.visible
            ? Column(
                children: [Text(widget.date.day.toString())],
              )
            : Container());
  }
}
