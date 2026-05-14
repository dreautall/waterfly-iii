import 'dart:math';

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
// ignore: implementation_imports
import 'package:community_charts_flutter/src/text_element.dart' as charts_text;
// ignore: implementation_imports
import 'package:community_charts_flutter/src/text_style.dart' as charts_style;
import 'package:flutter/material.dart';
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
        TimeSeriesChart(DateTime.parse(key), double.tryParse(value) ?? 0),
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
  // https://sronpersonalpages.nl/~pault/#fig:scheme_muted (fig.4)
  // rose
  const charts.Color(r: 204, g: 102, b: 119),
  // indigo - actually blue from fig.3
  const charts.Color(r: 0, g: 119, b: 187),
  // sand - actually yellow from fig.5
  const charts.Color(r: 238, g: 204, b: 102),
  // green
  const charts.Color(r: 17, g: 119, b: 51),
  // cyan - actually from fig.3
  const charts.Color(r: 51, g: 187, b: 238),
  // wine - disabled as black reads poorly
  //const charts.Color(r: 136, g: 34, b: 85),
  // teal
  const charts.Color(r: 68, g: 170, b: 153),
  // olive
  const charts.Color(r: 153, g: 153, b: 51),
  // purple
  const charts.Color(r: 170, g: 68, b: 153),
];

final List<Color> possibleChartColorsDart = <Color>[
  ...possibleChartColors.map(
    (charts.Color c) => charts.ColorUtil.toDartColor(c),
  ),
];

class TextSymbolRenderer extends charts.CircleSymbolRenderer {
  TextSymbolRenderer(
    this.printFunc,
    this.context, {
    this.marginBottom = 8,
    this.padding = const .all(8),
  });

  final String Function() printFunc;
  final BuildContext context;
  final double marginBottom;
  final EdgeInsets padding;

  @override
  void paint(
    charts.ChartCanvas canvas,
    Rectangle<num> bounds, {
    List<int>? dashPattern,
    charts.Color? fillColor,
    charts.FillPatternType? fillPattern,
    charts.Color? strokeColor,
    double? strokeWidthPx,
  }) {
    super.paint(
      canvas,
      bounds,
      dashPattern: dashPattern,
      fillColor: fillColor,
      fillPattern: fillPattern,
      strokeColor: strokeColor,
      strokeWidthPx: strokeWidthPx,
    );

    final charts_style.TextStyle textStyle = charts_style.TextStyle();
    textStyle.color = charts.ColorUtil.fromDartColor(
      Theme.of(context).colorScheme.onSurfaceVariant,
    );
    textStyle.fontSize =
        Theme.of(context).textTheme.labelSmall?.fontSize?.toInt() ?? 12;

    final charts_text.TextElement textElement = charts_text.TextElement(
      printFunc(),
      style: textStyle,
    );
    final double width = textElement.measurement.horizontalSliceWidth;
    final double height = textElement.measurement.verticalSliceWidth;

    final double centerX = bounds.left + bounds.width / 2;
    final double centerY =
        bounds.top +
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
        Theme.of(context).colorScheme.surfaceContainerHighest,
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

class WFChartData {
  WFChartData(this.label, [this.value, this.isIntermediate, this.isTotal]);
  final String label;
  final double? value;
  final bool? isIntermediate;
  final bool? isTotal;
}
