// lib/widgets/weekly_bars_chart.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Graphe simple : minutes par jour d'une semaine.
/// [data] : Map<DateTime, int> (doit contenir au moins les 7 derniers jours).
class WeeklyBarsChart extends StatelessWidget {
  const WeeklyBarsChart({super.key, required this.data});

  final Map<DateTime, int> data;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monday = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
    final days = List<DateTime>.generate(7, (i) => monday.add(Duration(days: i)));
    final values = days.map((d) => data[_day(d)] ?? 0).toList();

    return AspectRatio(
      aspectRatio: 1.8,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 32)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, meta) {
                  final idx = v.toInt();
                  if (idx < 0 || idx > 6) return const SizedBox.shrink();
                  const labels = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(labels[idx]),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(
            7,
                (i) => BarChartGroupData(
              x: i,
              barRods: [BarChartRodData(toY: values[i].toDouble())],
            ),
          ),
        ),
      ),
    );
  }

  DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);
}
