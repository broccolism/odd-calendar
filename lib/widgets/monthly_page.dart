import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:odd_calendar/widgets/date_tile.dart';

class MonthlyPage extends StatelessWidget {
  const MonthlyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Table(
            children: getTableRows(getDateTiles()),
          ),
        ],
      ),
    );
  }

  List<TableRow> getTableRows(List<DateTile> tiles) {
    return tiles
        .slices(7)
        .map(
          (row) => TableRow(children: row),
        )
        .toList();
  }

  List<DateTile> getDateTiles() {
    final DateTime current = DateTime.now();
    final int year = current.year;
    final int month = current.month;

    final DateTime firstDate = DateTime(year, month, 1);
    final DateTime lastDate = DateTime(year, month + 1).subtract(const Duration(days: 1));

    final int firstDay = firstDate.weekday;
    final int lastDay = lastDate.weekday;
    final int invisibleTilePrefix = (firstDay - 1);
    final int invisibleTileSuffix = DateTime.daysPerWeek - lastDay;

    final int totalDates = DateTimeRange(start: firstDate, end: lastDate).duration.inDays + 1;
    return List.filled(
            invisibleTilePrefix,
            DateTile(
              date: DateTime.now(),
              visible: false,
            ),
            growable: false) +
        List.generate(totalDates, (int index) => DateTile(date: DateTime(year, month, index + 1)), growable: false) +
        List.filled(
            invisibleTileSuffix,
            DateTile(
              date: DateTime.now(),
              visible: false,
            ),
            growable: false);
  }
}
