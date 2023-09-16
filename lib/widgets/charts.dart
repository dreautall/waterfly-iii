import 'dart:math';

import 'package:flutter/material.dart';

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
// ignore: implementation_imports
import 'package:community_charts_flutter/src/text_style.dart' as charts_style;
// ignore: implementation_imports
import 'package:community_charts_flutter/src/text_element.dart' as charts_text;

import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';

class TimeSeriesChart {
  final DateTime time;
  final double value;

  TimeSeriesChart(this.time, this.value);
}

extension ConvertChartDataSet on ChartDataSet {
  List<TimeSeriesChart> toChart() {
    final List<TimeSeriesChart> data = <TimeSeriesChart>[];

    final Map<String, dynamic> e = entries! as Map<String, dynamic>;
    e.forEach(
      (String key, dynamic value) => data.add(
        TimeSeriesChart(
          DateTime.parse(key),
          double.tryParse(value) ?? 0,
        ),
      ),
    );
    return data;
  }
}

class LabelAmountChart {
  final String label;
  final double amount;

  LabelAmountChart(this.label, this.amount);
}

final List<charts.Color> possibleChartColors = <charts.Color>[
  charts.MaterialPalette.blue.shadeDefault,
  charts.MaterialPalette.deepOrange.shadeDefault,
  charts.MaterialPalette.purple.shadeDefault,
  charts.MaterialPalette.teal.shadeDefault,
  charts.MaterialPalette.lime.shadeDefault,
  charts.MaterialPalette.cyan.shadeDefault,
];

final List<Color> possibleChartColorsDart = <Color>[
  ...possibleChartColors
      .map((charts.Color c) => charts.ColorUtil.toDartColor(c))
];

class TextSymbolRenderer extends charts.CircleSymbolRenderer {
  TextSymbolRenderer(
    this.printFunc,
    this.context, {
    this.marginBottom = 8,
    this.padding = const EdgeInsets.all(8),
  });

  final String Function() printFunc;
  final BuildContext context;
  final double marginBottom;
  final EdgeInsets padding;

  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
      {List<int>? dashPattern,
      charts.Color? fillColor,
      charts.FillPatternType? fillPattern,
      charts.Color? strokeColor,
      double? strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        fillPattern: fillPattern,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);

    charts_style.TextStyle textStyle = charts_style.TextStyle();
    textStyle.color = charts.ColorUtil.fromDartColor(
      Theme.of(context).colorScheme.onSurfaceVariant,
    );
    textStyle.fontSize =
        Theme.of(context).textTheme.labelSmall?.fontSize?.toInt() ?? 12;

    charts_text.TextElement textElement = charts_text.TextElement(
      printFunc(),
      style: textStyle,
    );
    double width = textElement.measurement.horizontalSliceWidth;
    double height = textElement.measurement.verticalSliceWidth;

    double centerX = bounds.left + bounds.width / 2;
    double centerY = bounds.top +
        bounds.height / 2 -
        marginBottom -
        (padding.top + padding.bottom);

    canvas.drawRRect(
      Rectangle<num>(
        centerX - (width / 2) - padding.left,
        centerY - (height / 2) - padding.top,
        width + (padding.left + padding.right),
        height + (padding.top + padding.bottom),
      ),
      fill: charts.ColorUtil.fromDartColor(
        Theme.of(context).colorScheme.surfaceVariant,
      ),
      radius: 16,
      roundTopLeft: true,
      roundTopRight: true,
      roundBottomRight: true,
      roundBottomLeft: true,
    );
    canvas.drawText(
      textElement,
      (centerX - (width / 2)).round(),
      (centerY - (height / 2)).round(),
    );
  }
}
