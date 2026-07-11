// lib/features/game_session/domain/entities/quarter_result.dart

import 'financial_report.dart';
import 'game_alert.dart';

enum CompanyStatus { active, warning, critical, bankrupt }

class QuarterResult {
  final int nextQuarter;
  final int stockUnits;
  final CompanyStatus companyStatus;
  final FinancialReport financialReport;
  final List<GameAlert> alerts;

  const QuarterResult({
    required this.nextQuarter,
    required this.stockUnits,
    required this.companyStatus,
    required this.financialReport,
    required this.alerts,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuarterResult &&
          runtimeType == other.runtimeType &&
          nextQuarter == other.nextQuarter &&
          stockUnits == other.stockUnits &&
          companyStatus == other.companyStatus &&
          financialReport == other.financialReport;

  @override
  int get hashCode =>
      nextQuarter.hashCode ^
      stockUnits.hashCode ^
      companyStatus.hashCode ^
      financialReport.hashCode;
}
