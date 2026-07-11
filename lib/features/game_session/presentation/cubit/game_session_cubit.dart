// lib/features/game_session/presentation/cubit/game_session_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_session_state.dart';
import '../../domain/usecases/submit_quarter_decision.dart'; 
import '../../domain/entities/quarter_decision.dart';       
import '../../domain/entities/quarter_result.dart';         
import '../../../telemetry/domain/entities/telemetry_event.dart';
import '../../../../core/domain/session/session_purpose.dart';

class GameSessionCubit extends Cubit<GameSessionState> {
  final SubmitQuarterDecisionUseCase _submitDecisionUseCase;
  final SessionPurpose _sessionPurpose;
  final bool _telemetryConsent; 
  final String? _organizationId;
  final String? _cohortId;
  final List<TelemetryEvent> _telemetryBuffer = [];

  GameSessionCubit({
    required SubmitQuarterDecisionUseCase submitDecisionUseCase,
    required SessionPurpose sessionPurpose,
    required bool telemetryConsent,
    String? organizationId,
    String? cohortId,
  })  : _submitDecisionUseCase = submitDecisionUseCase,
        _sessionPurpose = sessionPurpose,
        _telemetryConsent = telemetryConsent,
        _organizationId = organizationId,
        _cohortId = cohortId,
        super(GameSessionInitial());

  void addTelemetryLog(TelemetryEvent event) {
    if (_telemetryConsent && _sessionPurpose != SessionPurpose.soloGame) {
      _telemetryBuffer.add(event);
    }
  }

  Future<void> executeQuarterResolution(QuarterDecision decision) async {
    emit(GameSessionLoading("Résolution analytique du trimestre par le serveur..."));

    try {
      final QuarterResult result = await _submitDecisionUseCase.call(
        decision, 
        List.from(_telemetryBuffer),
      );

      _telemetryBuffer.clear();

      if (result.companyStatus == CompanyStatus.bankrupt) {
        final bool canBuyRescue = !(_sessionPurpose == SessionPurpose.recruitment || 
                                    _sessionPurpose == SessionPurpose.assessment || 
                                    _sessionPurpose == SessionPurpose.classroom);
        
        emit(GameSessionBankruptcy(
          failedQuarter: result.nextQuarter,
          financialReport: result.financialReport, 
          allowSurvivalToken: canBuyRescue,
          organizationId: _organizationId,
          cohortId: _cohortId,
        ));
      } else {
        emit(GameSessionActive(
          currentQuarter: result.nextQuarter,
          stockUnits: result.stockUnits,
          financialReport: result.financialReport,
          activeAlerts: result.alerts,
          allowSurvivalToken: _sessionPurpose == SessionPurpose.soloGame,
          organizationId: _organizationId,
          cohortId: _cohortId,
        ));
      }
    } catch (failure) {
      emit(GameSessionFailure("Échec de synchronisation du trimestre. Veuillez vérifier votre connexion."));
    }
  }
}
