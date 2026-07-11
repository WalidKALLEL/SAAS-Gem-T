// lib/features/game_session/domain/entities/financial_report.dart

class FinancialReport {
  final double revenue;
  final double cogs;
  final double grossMargin;
  final double ebitda;
  final double netProfit;
  final double roi;
  final double cash;
  final double debt;
  final double liquidityRatio;
  final double workingCapitalRequirement; // BFR en TND
  final double selfFinancingCapacity;     // CAF en TND
  final double marketShare;

  const FinancialReport({
    required this.revenue,
    required this.cogs,
    required this.grossMargin,
    required this.ebitda,
    required this.netProfit,
    required this.roi,
    required this.cash,
    required this.debt,
    required this.liquidityRatio,
    required this.workingCapitalRequirement,
    required this.selfFinancingCapacity,
    required this.marketShare,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinancialReport &&
          runtimeType == other.runtimeType &&
          revenue == other.revenue &&
          cash == other.cash &&
          netProfit == other.netProfit &&
          workingCapitalRequirement == other.workingCapitalRequirement;

  @override
  int get hashCode =>
      revenue.hashCode ^
      cash.hashCode ^
      netProfit.hashCode ^
      workingCapitalRequirement.hashCode;
}
