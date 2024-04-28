import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';

class ReportUtils {
  static LineChartData generateChartData(
    List<String> mileStones,
    List<int> completedBookingData,
    List<int> canceledBookingData,
  ) {
    List<FlSpot> completeBookingSpots = [];
    List<FlSpot> canceledBookingSpots = [];
    int maxYSpot = 18;

    for (int i = 0; i < mileStones.length; i++) {
      completeBookingSpots
          .add(FlSpot((i + 1).toDouble(), completedBookingData[i].toDouble()));
      canceledBookingSpots
          .add(FlSpot((i + 1).toDouble(), canceledBookingData[i].toDouble()));

      maxYSpot = max(maxYSpot, completedBookingData[i]);
      maxYSpot = max(maxYSpot, canceledBookingData[i]);
    }

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 2,
      ),
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
            y: 0,
            color: Colors.black,
            strokeWidth: 1,
            dashArray: [5, 5],
          ),
        ],
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1.5,
            getTitlesWidget: (value, _) {
              if (value.toInt() == 0 ||
                  value.toInt() == mileStones.length + 1) {
                return const Text('');
              }
              for (int i = 0; i < mileStones.length; i++) {
                if (value.toInt() == i) {
                  return Container(
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    child: Text(
                      mileStones[i].substring(0, mileStones[i].length - 5),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  );
                }
              }
              return const Text('');
            },
          ),
          axisNameSize: 1,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: mileStones.isEmpty ? 1 : mileStones.length.toDouble() + 1,
      minY: 0,
      maxY: maxYSpot.toDouble() + 1,
      lineBarsData: [
        LineChartBarData(
          spots: completeBookingSpots,
          isCurved: true,
          color: ColorHelper.getColor(ColorHelper.green),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          preventCurveOverShooting: true,
        ),
        LineChartBarData(
          spots: canceledBookingSpots,
          isCurved: true,
          color: Colors.orange,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          preventCurveOverShooting: true,
        ),
      ],
    );
  }
}
