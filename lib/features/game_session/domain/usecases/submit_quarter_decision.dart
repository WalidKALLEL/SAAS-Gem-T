import '../../../telemetry/domain/entities/telemetry_event.dart';
import '../entities/quarter_decision.dart';
import '../entities/quarter_result.dart';

abstract class SubmitQuarterDecisionUseCase {
  Future<QuarterResult> call(
    QuarterDecision decision,
    List<TelemetryEvent> telemetryEvents,
  );
}
