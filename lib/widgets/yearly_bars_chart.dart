import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class YearlyBarsChart extends StatelessWidget {
  const YearlyBarsChart({super.key, required this.values, this.maxY})
      : assert(values.length == 12);

  final List<double> values;
  final double? maxY;

  static const _labels = ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'];

  @override
  Widget build(BuildContext context) {
    final localMax = (maxY ??
        (values.isEmpty ? 0 : values.reduce((a, b) => a > b ? a : b)))
        .clamp(0, double.infinity);
    final top = localMax == 0 ? 1.0 : localMax * 1.2;

    return AspectRatio(
      aspectRatio: 1.8,
      child: BarChart(
        BarChartData(
          maxY: top,
          alignment: BarChartAlignment.spaceBetween,
          gridData: FlGridData(show: true, horizontalInterval: top / 4),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                interval: top / 4,
                getTitlesWidget: (v, _) =>
                    Text(v == 0 ? '0' : v.toStringAsFixed(0), style: const TextStyle(fontSize: 11)),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) {
                  final i = v.toInt();
                  if (i < 0 || i >= _labels.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(_labels[i], style: const TextStyle(fontSize: 10)),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(values.length, (i) {
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(toY: values[i], width: 12, borderRadius: BorderRadius.circular(4)),
              ],
            );
          }),
        ),
      ),
    );
  }
}
