import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

LineChartData mainData() {
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawHorizontalLine: true,
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: Color(0xff37434d),
          strokeWidth: 0.1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, _) {
            switch (value.toInt()) {
              case 2:
                return const Text('MAR');
              case 5:
                return const Text('JUN');
              case 8:
                return const Text('SEP');
            }
            return const Text('');
          },
        ),
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: [
          const FlSpot(0, 3),
          const FlSpot(2.6, 2),
          const FlSpot(4.9, 5),
          const FlSpot(6.8, 3.1),
          const FlSpot(8, 4),
          const FlSpot(9.5, 3),
          const FlSpot(11, 4),
        ],
        isCurved: true,
        color: const Color(0xFFFF3378),
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
      ),
    ],
  );
}
