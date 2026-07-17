// lib/features/game_session/domain/entities/game_alert.dart

enum GameAlertType { overstock, lowCash, supplierDelay, customerDissatisfaction, turnoverRH, negativeMargin }

class GameAlert {
  final GameAlertType type;
  final String message;
  final bool isCritical;

  const GameAlert({
    required this.type,
    required this.message,
    this.isCritical = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameAlert &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          message == other.message &&
          isCritical == other.isCritical;

  @override
  int get hashCode => type.hashCode ^ message.hashCode ^ isCritical.hashCode;
}
