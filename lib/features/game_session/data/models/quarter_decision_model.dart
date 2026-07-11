// lib/features/game_session/data/models/quarter_decision_model.dart

import '../../domain/entities/quarter_decision.dart';

class QuarterDecisionModel extends QuarterDecision {
  const QuarterDecisionModel({
    required super.priceInput,
    required super.selectedAxe,
    required super.productionVolume,
    required super.targetArguments,
  });

  factory QuarterDecisionModel.fromJson(Map<String, dynamic> json) {
    return QuarterDecisionModel(
      priceInput: (json['priceInput'] as num? ?? 0.0).toDouble(),
      selectedAxe: json['selectedAxe'] as String? ?? '',
      productionVolume: json['productionVolume'] as int? ?? 0,
      targetArguments: (json['targetArguments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ?? 
          const [],
    );
  }

  Map<String, dynamic> toJson() => {
    'priceInput': priceInput,
    'selectedAxe': selectedAxe,
    'productionVolume': productionVolume,
    'targetArguments': targetArguments,
  };
}
