class Session {
  final String id;
  final String activityId;
  final DateTime startedAt;
  DateTime? endedAt;

  Session({
    required this.id,
    required this.activityId,
    required this.startedAt,
    this.endedAt,
  });

  bool get isOpen => endedAt == null;
}
