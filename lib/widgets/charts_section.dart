import 'package:flutter/material.dart';
import 'hourly_bars_chart.dart';
import 'weekly_bars_chart.dart';
import 'monthly_bars_chart.dart';
import 'yearly_bars_chart.dart';

class ChartsSection extends StatelessWidget {
  const ChartsSection({
    super.key,
    required this.hourly,   // 24 valeurs
    required this.weekly,   // 7 valeurs
    required this.monthly,  // 28-31 valeurs
    required this.yearly,   // 12 valeurs
  });

  final List<double> hourly;
  final List<double> weekly;
  final List<double> monthly;
  final List<double> yearly;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: DefaultTabController(
          length: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Charts', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: 'Jour'),
                  Tab(text: 'Semaine'),
                  Tab(text: 'Mois'),
                  Tab(text: 'Année'),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 220,
                child: TabBarView(
                  children: [
                    HourlyBarsChart(values: hourly),
                    WeeklyBarsChart(values: weekly),
                    MonthlyBarsChart(values: monthly),
                    YearlyBarsChart(values: yearly),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
