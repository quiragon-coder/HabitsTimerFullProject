// lib/widgets/weekly_bars_chart.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Histogramme sur 7 jours (lun -> dim).
/// [values] doit contenir 7 valeurs.
class WeeklyBarsChart extends StatelessWidget {
  const WeeklyBarsChart({
    super.key,
    required this.values,
    this.maxY,
  }) : assert(values.length == 7, 'values doit contenir 7 éléments');

  // <- la bonne déclaration
  final List<double> values;
  final double? maxY;

  static const _labels = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];

  @override
  Widget build(BuildContext context) {
    final localMax = (maxY ??
        (values.isEmpty
            ? 0
            : values.reduce((a, b) => a > b ? a : b)))
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
                getTitlesWidget: (v, meta) => Text(
                  v == 0 ? '0' : v.toStringAsFixed(0),
                  style: const TextStyle(fontSize: 11),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, meta) {
                  final idx = v.toInt();
                  if (idx < 0 || idx >= _labels.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(_labels[idx],
                        style: const TextStyle(fontSize: 10)),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(values.length, (i) {
            return BarChartGroupData(
              x: i,
              barsSpace: 0,
              barRods: [
                BarChartRodData(
                  toY: values[i],
                  width: 12,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
