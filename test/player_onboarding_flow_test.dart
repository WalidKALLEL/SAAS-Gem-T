import 'package:biz_pulse_player_portal/src/app/biz_pulse_player_portal.dart';
import 'package:biz_pulse_player_portal/src/onboarding/onboarding_models.dart';
import 'package:biz_pulse_player_portal/src/onboarding/portal_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('parcours de première prise en main jusqu’au dashboard simplifié',
      (tester) async {
    await _pumpPortal(tester);

    expect(find.text('Créez votre compte.'), findsOneWidget);
    expect(find.textContaining('Portail Administrateur'), findsNothing);

    await _tapVisible(tester, 'Créer mon compte');
    await tester.pumpAndSettle();
    expect(find.text('Bienvenue, entrepreneur du futur !'), findsOneWidget);
    expect(find.text('Compte créé. Session ouverte automatiquement.'),
        findsOneWidget);

    await _tapVisible(tester, 'Commencer l’expérience');
    await tester.pumpAndSettle();
    expect(find.text('Que souhaitez-vous développer ?'), findsOneWidget);

    await tester.ensureVisible(find.byKey(const ValueKey('goal-leadership')));
    await tester.tap(find.byKey(const ValueKey('goal-leadership')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('experience-some')));
    await tester.tap(find.byKey(const ValueKey('experience-some')));
    await tester.pumpAndSettle();
    await _tapVisible(tester, 'Continuer');
    await tester.pumpAndSettle();
    expect(find.text('Créez votre entreprise.'), findsOneWidget);

    await _tapVisible(tester, 'Créer mon entreprise');
    await tester.pumpAndSettle();
    expect(find.text('Choisissez votre terrain de jeu.'), findsOneWidget);

    await tester.ensureVisible(find.byKey(const ValueKey('product-PRES')));
    await tester.tap(find.byKey(const ValueKey('product-PRES')));
    await tester.pumpAndSettle();
    await _tapVisible(tester, 'Confirmer ce produit');
    await tester.pumpAndSettle();
    expect(find.text('Prestige TECH est prêt.'), findsOneWidget);
    expect(find.textContaining('définitif'), findsOneWidget);

    await _tapVisible(tester, 'Confirmer mon choix');
    await tester.pumpAndSettle();
    expect(find.text('Votre première mission.'), findsOneWidget);

    await _tapVisible(tester, 'Commencer la mission');
    await tester.pumpAndSettle();
    expect(find.text('Un tour = un trimestre.'), findsOneWidget);

    await _tapVisible(tester, 'Faire la visite');
    await tester.pumpAndSettle();
    expect(find.text('Repérez votre cockpit.'), findsOneWidget);

    await _tapVisible(tester, 'Passer la visite');
    await tester.pumpAndSettle();
    expect(find.text('Dashboard simplifié.'), findsOneWidget);
    expect(find.text('Fin du lot : validation requise avant la suite.'),
        findsOneWidget);
    expect(find.textContaining('Portail Administrateur'), findsNothing);
  });

  testWidgets('message de validation si la création de compte est incomplète',
      (tester) async {
    await _pumpPortal(tester);

    await tester.enterText(
        find.byKey(const ValueKey('field-Prénom ou pseudo')), '');
    await tester.enterText(find.byKey(const ValueKey('field-Email')), '');
    await tester.enterText(
        find.byKey(const ValueKey('field-Mot de passe')), '');
    await tester.enterText(find.byKey(const ValueKey('field-Confirmer')), '');
    await _tapVisible(tester, 'Créer mon compte');
    await tester.pumpAndSettle();

    expect(find.text('Complétez les champs obligatoires.'), findsOneWidget);
  });

  testWidgets('création de compte exige acceptation des conditions',
      (tester) async {
    await _pumpPortal(tester);

    final terms = find.byKey(const ValueKey('terms-acceptance'));
    await tester.ensureVisible(terms);
    await tester.tap(terms);
    await tester.pumpAndSettle();
    await _tapVisible(tester, 'Créer mon compte');
    await tester.pumpAndSettle();

    expect(find.text('Acceptez les conditions pour créer le compte.'),
        findsOneWidget);
  });

  testWidgets('écran de connexion accessible depuis la création de compte',
      (tester) async {
    await _pumpPortal(tester);

    await _tapVisible(tester, 'J’ai déjà un compte');
    await tester.pumpAndSettle();
    expect(find.text('Connectez-vous.'), findsOneWidget);
    expect(find.text('Mot de passe oublié ?'), findsOneWidget);
  });

  testWidgets('coach biz visible et panneau pédagogique disponible',
      (tester) async {
    await _pumpPortal(tester);

    expect(find.byKey(const ValueKey('coach-biz')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('coach-biz')));
    await tester.pumpAndSettle();

    expect(find.text('COACH BIZ'), findsOneWidget);
    expect(find.text('Lire cet écran'), findsOneWidget);
    expect(find.text('Que dois-je faire maintenant ?'), findsOneWidget);
    expect(find.textContaining('sans donner de stratégie gagnante'),
        findsOneWidget);
  });

  testWidgets('dashboard expose les KPI essentiels et leur aide',
      (tester) async {
    await _pumpPortal(tester, initialStep: PlayerOnboardingStep.dashboard);

    expect(find.text('Trésorerie'), findsOneWidget);
    expect(find.text('Chiffre d’affaires'), findsOneWidget);
    expect(find.text('Part de marché'), findsOneWidget);
    expect(find.text('Productivité'), findsNothing);
    expect(find.text('Progression de la mission'), findsOneWidget);

    final infoButton = find.byKey(const ValueKey('kpi-info-cash'));
    await tester.ensureVisible(infoButton);
    await tester.tap(infoButton);
    await tester.pumpAndSettle();

    expect(find.text('Comprendre : Trésorerie'), findsOneWidget);
    expect(find.text('Question de réflexion'), findsOneWidget);
    expect(find.textContaining('sans révéler la décision optimale'),
        findsOneWidget);
  });

  testWidgets('création de compte ouvre automatiquement la session',
      (tester) async {
    await _pumpPortal(tester);

    await _tapVisible(tester, 'Créer mon compte');
    await tester.pumpAndSettle();

    expect(find.text('Bienvenue, entrepreneur du futur !'), findsOneWidget);
    expect(find.text('Connectez-vous.'), findsNothing);
    expect(find.text('Compte créé. Session ouverte automatiquement.'),
        findsOneWidget);
  });

  testWidgets('dashboard initial respecte les données métier validées',
      (tester) async {
    await _pumpPortal(tester, initialStep: PlayerOnboardingStep.dashboard);

    expect(find.text('3 000'), findsOneWidget);
    expect(find.text('TND'), findsWidgets);
    expect(find.text('0'), findsWidgets);
    expect(find.text('42.5'), findsNothing);
    expect(find.text('18.2'), findsNothing);
    expect(find.text('128'), findsNothing);
    expect(find.text('74'), findsNothing);

    await tester.ensureVisible(find.text('Situation de départ'));
    await tester.pumpAndSettle();
    expect(find.text('Capital souscrit : '), findsOneWidget);
    expect(find.text('10 000 TND'), findsOneWidget);
    expect(find.text('Capital libéré : '), findsOneWidget);
    expect(find.text('Restant à libérer : '), findsOneWidget);
    expect(find.text('7 000 TND'), findsOneWidget);
    expect(find.text('Dettes : '), findsOneWidget);
    expect(find.text('Créances : '), findsOneWidget);
    expect(find.text('Machines : '), findsOneWidget);
    expect(find.text('Salariés : '), findsOneWidget);
    expect(find.text('Local loué : '), findsOneWidget);
    expect(find.text('30 m²'), findsOneWidget);
  });

  testWidgets('kpi non mesurable reste explicable', (tester) async {
    await _pumpPortal(tester, initialStep: PlayerOnboardingStep.dashboard);

    await tester.ensureVisible(find.text('Satisfaction client'));
    await tester.pumpAndSettle();
    expect(find.text('Disponible après vos premières ventes'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('kpi-info-satisfaction')));
    await tester.pumpAndSettle();

    expect(find.text('Disponibilité'), findsOneWidget);
    expect(find.textContaining('Pas encore mesurable'), findsWidgets);
    expect(find.textContaining('Sans vente ni retour client'), findsOneWidget);
  });

  testWidgets('kpi prioritaires visibles en grille mobile compacte',
      (tester) async {
    await _pumpPortal(tester, initialStep: PlayerOnboardingStep.dashboard);

    final cash = find.byKey(const ValueKey('kpi-card-cash'));
    final stock = find.byKey(const ValueKey('kpi-card-stock'));

    expect(cash, findsOneWidget);
    expect(stock, findsOneWidget);
    expect(tester.getBottomRight(cash).dy, lessThan(844));
    expect(tester.getBottomRight(stock).dy, lessThan(844));
    expect(tester.getTopLeft(stock).dx, greaterThan(150));
  });

  testWidgets('données dashboard initial et post tour séparées',
      (tester) async {
    expect(initialDashboardData.id, 'initial');
    expect(postTurnDemoDashboardData.id, 'postTurnDemo');
    expect(initialDashboardData.kpis.first.value, '3 000');
    expect(postTurnDemoDashboardData.kpis.first.value, '42.5');
    expect(
      initialDashboardData.kpis.any((kpi) => kpi.label == 'Productivité'),
      isFalse,
    );
    expect(
      postTurnDemoDashboardData.kpis.any((kpi) => kpi.label == 'Productivité'),
      isTrue,
    );
  });

  testWidgets('visite guidée permet suivant, retour et terminer',
      (tester) async {
    await _pumpPortal(tester, initialStep: PlayerOnboardingStep.guidedVisit);

    expect(find.text('Numéro du tour'), findsOneWidget);
    await _tapVisible(tester, 'Suivant');
    await tester.pumpAndSettle();
    expect(find.text('Compte à rebours'), findsOneWidget);
    await _tapVisible(tester, 'Retour');
    await tester.pumpAndSettle();
    expect(find.text('Numéro du tour'), findsOneWidget);

    for (var index = 0; index < 7; index += 1) {
      await _tapVisible(tester, 'Suivant');
      await tester.pumpAndSettle();
    }

    expect(find.text('Passage du tour'), findsOneWidget);
    await _tapVisible(tester, 'Terminer');
    await tester.pumpAndSettle();
    expect(find.text('Dashboard simplifié.'), findsOneWidget);
  });

  testWidgets('cartes produits affichent illustration, usages et aide',
      (tester) async {
    await _pumpPortal(tester, initialStep: PlayerOnboardingStep.productFamily);

    expect(find.text('Drone intelligent'), findsOneWidget);
    expect(find.text('Robot professionnel intelligent'), findsOneWidget);
    expect(find.text('Chaise multifonction intelligente'), findsOneWidget);
    expect(find.byType(ProductVisualBadge), findsWidgets);

    await tester.tap(find.byKey(const ValueKey('product-info-PRES')));
    await tester.pumpAndSettle();

    expect(find.text('Usages principaux'), findsOneWidget);
    expect(find.text('KPI à surveiller'), findsOneWidget);
  });
}

Future<void> _pumpPortal(
  WidgetTester tester, {
  PlayerOnboardingStep initialStep = PlayerOnboardingStep.createAccount,
}) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(BizPulsePlayerPortal(initialStep: initialStep));
  await tester.pumpAndSettle();
}

Future<void> _tapVisible(WidgetTester tester, String text) async {
  final finder = find.text(text);
  await tester.ensureVisible(finder);
  await tester.tap(finder);
}
