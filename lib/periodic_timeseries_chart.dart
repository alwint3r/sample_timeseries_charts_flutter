import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:timeseriescharts/timeseries_temperature.dart';

class PeriodicTimeseriesChart extends StatefulWidget {
  const PeriodicTimeseriesChart({Key? key, required this.updateDuration})
      : super(key: key);
  final Duration updateDuration;

  @override
  State<PeriodicTimeseriesChart> createState() =>
      _PeriodicTimeseriesChartState();
}

class _PeriodicTimeseriesChartState extends State<PeriodicTimeseriesChart> {
  late Timer timer;
  final List<TimeSeriesTemperature> temperatures = <TimeSeriesTemperature>[];
  late charts.Series<dynamic, DateTime> series;

  double _getRandom(Random source, double start, double end) =>
      source.nextDouble() * (end - start) + start;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(widget.updateDuration, (timer) {
      Random rand = Random();
      double randomValue = _getRandom(rand, 25.0, 27.1);
      setState(() {
        if (temperatures.length > 30) {
          temperatures.removeAt(0);
        }

        temperatures.add(TimeSeriesTemperature(DateTime.now(), randomValue));
      });
    });

    series = charts.Series<TimeSeriesTemperature, DateTime>(
      id: 'Temperature',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (TimeSeriesTemperature ts, _) => ts.time,
      measureFn: (TimeSeriesTemperature ts, _) => ts.value,
      data: temperatures,
    );
  }

  @override
  void dispose() {
    super.dispose();

    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      [series],
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      behaviors: [
        charts.SeriesLegend(
          showMeasures: true,
          position: charts.BehaviorPosition.end,
          cellPadding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
          horizontalFirst: false,
          measureFormatter: (value) {
            if (value == null) {
              return '-';
            } else {
              return value.toStringAsFixed(1);
            }
          },
        ),
      ],
      primaryMeasureAxis: const charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
      ),
    );
  }
}
