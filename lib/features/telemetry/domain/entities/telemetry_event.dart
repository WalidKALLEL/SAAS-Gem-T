class TelemetryEvent {
  const TelemetryEvent({
    required this.type,
    required this.occurredAt,
    this.data = const <String, dynamic>{},
  });

  final String type;
  final DateTime occurredAt;
  final Map<String, dynamic> data;
}
