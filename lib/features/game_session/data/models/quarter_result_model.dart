// lib/features/game_session/data/models/quarter_result_model.dart

import '../../domain/entities/game_alert.dart';
import '../../domain/entities/quarter_result.dart';
import 'financial_report_model.dart';

class QuarterResultModel extends QuarterResult {
  const QuarterResultModel({
    required super.nextQuarter,
    required super.stockUnits,
    required super.companyStatus,
    required super.financialReport,
    required super.alerts,
  });

  factory QuarterResultModel.fromJson(Map<String, dynamic> json) {
    return QuarterResultModel(
      nextQuarter: json['nextQuarter'] as int? ?? 1,
      stockUnits: json['stockUnits'] as int? ?? 0,
      companyStatus: CompanyStatus.values.firstWhere(
        (e) => e.name == json['companyStatus'],
        orElse: () => CompanyStatus.active,
      ),
      financialReport: FinancialReportModel.fromJson(
        json['financialReport'] as Map<String, dynamic>? ?? const {},
      ),
      alerts: (json['alerts'] as List<dynamic>?)
              ?.map((e) => _parseAlert(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}

GameAlert _parseAlert(Map<String, dynamic> json) {
  return GameAlert(
    type: GameAlertType.values.firstWhere(
      (e) => e.name == json['type'],
      orElse: () => GameAlertType.lowCash,
    ),
    message: json['message'] as String? ?? '',
    isCritical: json['isCritical'] as bool? ?? false,
  );
}
