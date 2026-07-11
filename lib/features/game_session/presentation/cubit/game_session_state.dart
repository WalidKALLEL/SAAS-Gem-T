// lib/features/game_session/presentation/cubit/game_session_state.dart

import '../../domain/entities/financial_report.dart';
import '../../domain/entities/game_alert.dart';

abstract class GameSessionState {}

class GameSessionInitial extends GameSessionState {}

class GameSessionLoading extends GameSessionState {
  final String message;
  GameSessionLoading(this.message);
}

class GameSessionActive extends GameSessionState {
  final int currentQuarter;
  final int stockUnits;
  final FinancialReport financialReport;
  final List<GameAlert> activeAlerts;
  final bool allowSurvivalToken;
  final String? organizationId;
  final String? cohortId;

  GameSessionActive({
    required this.currentQuarter,
    required this.stockUnits,
    required this.financialReport,
    required this.activeAlerts,
    required this.allowSurvivalToken,
    this.organizationId,
    this.cohortId,
  });
}

class GameSessionBankruptcy extends GameSessionState {
  final int failedQuarter;
  final FinancialReport financialReport; 
  final bool allowSurvivalToken;
  final String? organizationId;
  final String? cohortId;

  GameSessionBankruptcy({
    required this.failedQuarter,
    required this.financialReport, 
    required this.allowSurvivalToken,
    this.organizationId,
    this.cohortId,
  });
}

class GameSessionFailure extends GameSessionState {
  final String message;
  GameSessionFailure(this.message);
}
