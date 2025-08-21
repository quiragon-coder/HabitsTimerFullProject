class Pause {
  final String id;
  final String sessionId;
  final DateTime startedAt;
  DateTime? endedAt;

  Pause({
    required this.id,
    required this.sessionId,
    required this.startedAt,
    this.endedAt,
  });

  bool get isOpen => endedAt == null;
}
