// lib/features/game_session/data/models/financial_report_model.dart

import '../../domain/entities/financial_report.dart';

class FinancialReportModel extends FinancialReport {
  const FinancialReportModel({
    required super.revenue,
    required super.cogs,
    required super.grossMargin,
    required super.ebitda,
    required super.netProfit,
    required super.roi,
    required super.cash,
    required super.debt,
    required super.liquidityRatio,
    required super.workingCapitalRequirement,
    required super.selfFinancingCapacity,
    required super.marketShare,
  });

  factory FinancialReportModel.fromJson(Map<String, dynamic> json) {
    return FinancialReportModel(
      revenue: (json['revenue'] as num? ?? 0.0).toDouble(),
      cogs: (json['cogs'] as num? ?? 0.0).toDouble(),
      grossMargin: (json['grossMargin'] as num? ?? 0.0).toDouble(),
      ebitda: (json['ebitda'] as num? ?? 0.0).toDouble(),
      netProfit: (json['netProfit'] as num? ?? 0.0).toDouble(),
      roi: (json['roi'] as num? ?? 0.0).toDouble(),
      cash: (json['cash'] as num? ?? 0.0).toDouble(),
      debt: (json['debt'] as num? ?? 0.0).toDouble(),
      liquidityRatio: (json['liquidityRatio'] as num? ?? 0.0).toDouble(),
      workingCapitalRequirement: (json['workingCapitalRequirement'] as num? ?? 0.0).toDouble(),
      selfFinancingCapacity: (json['selfFinancingCapacity'] as num? ?? 0.0).toDouble(),
      marketShare: (json['marketShare'] as num? ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'revenue': revenue,
    'cogs': cogs,
    'grossMargin': grossMargin,
    'ebitda': ebitda,
    'netProfit': netProfit,
    'roi': roi,
    'cash': cash,
    'debt': debt,
    'liquidityRatio': liquidityRatio,
    'workingCapitalRequirement': workingCapitalRequirement,
    'selfFinancingCapacity': selfFinancingCapacity,
    'marketShare': marketShare,
  };

  FinancialReport toEntity() {
    return FinancialReport(
      revenue: revenue,
      cogs: cogs,
      grossMargin: grossMargin,
      ebitda: ebitda,
      netProfit: netProfit,
      roi: roi,
      cash: cash,
      debt: debt,
      liquidityRatio: liquidityRatio,
      workingCapitalRequirement: workingCapitalRequirement,
      selfFinancingCapacity: selfFinancingCapacity,
      marketShare: marketShare,
    );
  }
}
