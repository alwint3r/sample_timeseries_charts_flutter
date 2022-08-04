import 'package:flutter/material.dart';
import 'package:timeseriescharts/periodic_timeseries_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timeseries Chart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Timeseries Chart')),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            height: 250,
            child: PeriodicTimeseriesChart(
              updateDuration: Duration(seconds: 3),
            ),
          ),
        ),
      ),
    );
  }
}
