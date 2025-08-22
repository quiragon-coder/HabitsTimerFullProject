import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// 30 barres max, labels espacés (1,5,10,15,20,25,30)
class MonthlyBarsChart extends StatelessWidget {
  const MonthlyBarsChart({super.key, required this.values, this.maxY})
      : assert(values.length >= 28 && values.length <= 31);

  final List<double> values;
  final double? maxY;

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
                  if (i < 0 || i >= values.length) return const SizedBox.shrink();
                  // N'afficher que 1,5,10,15,20,25,30
                  if (![0,4,9,14,19,24,29].contains(i)) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('${i + 1}', style: const TextStyle(fontSize: 10)),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(values.length, (i) {
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(toY: values[i], width: 8, borderRadius: BorderRadius.circular(3)),
              ],
            );
          }),
        ),
      ),
    );
  }
}
