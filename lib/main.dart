import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:odd_calendar/widgets/date_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo ',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Table(
              children: getTableRows(getDateTiles()),
            ),
          ],
        ),
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
