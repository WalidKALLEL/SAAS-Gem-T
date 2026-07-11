// lib/features/game_session/domain/entities/quarter_decision.dart

class QuarterDecision {
  final double priceInput;
  final String selectedAxe;
  final int productionVolume;
  final List<String> targetArguments;

  const QuarterDecision({
    required this.priceInput,
    required this.selectedAxe,
    required this.productionVolume,
    required this.targetArguments,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuarterDecision &&
          runtimeType == other.runtimeType &&
          priceInput == other.priceInput &&
          selectedAxe == other.selectedAxe &&
          productionVolume == other.productionVolume;

  @override
  int get hashCode =>
      priceInput.hashCode ^ selectedAxe.hashCode ^ productionVolume.hashCode;
}
