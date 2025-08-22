import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/controls_card.dart';
import '../widgets/charts_section.dart';
import '../widgets/mini_heatmap_30d.dart';
import '../widgets/realtime_history_list.dart';

class ActivityDebugPage extends StatefulWidget {
  const ActivityDebugPage({super.key});
  @override
  State<ActivityDebugPage> createState() => _ActivityDebugPageState();
}

class _ActivityDebugPageState extends State<ActivityDebugPage> {
  // ----- Demo ticker (remplace par ton vrai service) -----
  final _elapsedCtrl = StreamController<Duration>.broadcast();
  Duration _elapsed = Duration.zero;
  Timer? _t;
  bool _running = false;

  // Historique temps réel (simple démo)
  final _historyCtrl = StreamController<List<HistoryEvent>>.broadcast();
  final List<HistoryEvent> _history = [];

  // Données charts & heatmap (démo)
  List<double> hourly = List<double>.filled(24, 0);
  List<double> weekly = List<double>.filled(7, 0);
  List<double> monthly = List<double>.filled(30, 0);
  List<double> yearly = List<double>.filled(12, 0);
  Map<DateTime, int> countsByDay = {};

  @override
  void initState() {
    super.initState();
    _pushHistory(); // initial
    _mockStats();   // remplace par tes vraies stats
  }

  void _mockStats() {
    // Un peu de bruit pour voir qqchose
    hourly = List.generate(24, (i) => (i % 3 == 0 ? 20 : 5) + (i.toDouble()));
    weekly = [30, 45, 10, 25, 70, 40, 15];
    monthly = List.generate(30, (i) => (i % 5 == 0 ? 60 : 20) + (i % 7) * 3);
    yearly = List.generate(12, (i) => (i % 2 == 0 ? 100 : 60) + i * 5);

    final today = DateTime.now();
    for (int i = 0; i < 30; i++) {
      final d = DateTime(today.year, today.month, today.day).subtract(Duration(days: i));
      countsByDay[d] = (i % 6 == 0) ? 0 : (i % 10) + 1;
    }
    setState(() {});
  }

  void _start() {
    if (_running) return;
    _running = true;
    _history.insert(0, HistoryEvent(at: DateTime.now(), label: 'Start'));
    _pushHistory();
    _t = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsed += const Duration(seconds: 1);
      _elapsedCtrl.add(_elapsed);
    });
  }

  void _pause() {
    if (!_running) return;
    _running = false;
    _t?.cancel();
    _history.insert(0, HistoryEvent(at: DateTime.now(), label: 'Pause', duration: _elapsed));
    _pushHistory();
  }

  void _stop() {
    _running = false;
    _t?.cancel();
    _history.insert(0, HistoryEvent(at: DateTime.now(), label: 'Stop', duration: _elapsed));
    _pushHistory();
    _elapsed = Duration.zero;
    _elapsedCtrl.add(_elapsed);
  }

  void _pushHistory() => _historyCtrl.add(List.unmodifiable(_history));

  @override
  void dispose() {
    _t?.cancel();
    _elapsedCtrl.close();
    _historyCtrl.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ftft')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ControlsCard(
              isRunning: _running,
              onStart: _start,
              onPause: _pause,
              onStop: _stop,
              ticker: _elapsedCtrl.stream,
              elapsed: _elapsed,
            ),
            ChartsSection(
              hourly: hourly,
              weekly: weekly,
              monthly: monthly,
              yearly: yearly,
            ),
            MiniHeatmap30d(countsByDay: countsByDay),
            RealtimeHistoryList(stream: _historyCtrl.stream),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
