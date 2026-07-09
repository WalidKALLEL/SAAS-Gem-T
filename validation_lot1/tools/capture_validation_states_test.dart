import 'dart:io';

import 'package:biz_pulse_player_portal/src/app/biz_pulse_player_portal.dart';
import 'package:biz_pulse_player_portal/src/onboarding/onboarding_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(_loadScreenshotFonts);

  testWidgets('capture Coach Biz notification, ouvert, lecture et ferme',
      (tester) async {
    await _pumpPortal(tester);
    await _expectShot('01_coach_biz_with_notification.png');

    await tester.tap(find.byKey(const ValueKey('coach-biz')));
    await _pumpFrame(tester);
    await _expectShot('02_coach_biz_open.png');

    await tester.tap(find.text('Lire cet écran'));
    await _pumpFrame(tester);
    await _expectShot('03_coach_biz_reading_simulated.png');

    await tester.tap(find.text('Fermer'));
    await _pumpFrame(tester);
    await _expectShot('04_coach_biz_closed.png');
  });

  testWidgets('capture formulaire clavier et erreur de validation',
      (tester) async {
    await _pumpPortal(tester);
    await tester.tap(find.byKey(const ValueKey('field-Email')));
    tester.view.viewInsets = const FakeViewPadding(bottom: 310);
    await _pumpFrame(tester);
    await _expectShot('05_mobile_keyboard_form_focus.png');
    tester.view.resetViewInsets();

    await tester.enterText(
      find.byKey(const ValueKey('field-Prénom ou pseudo')),
      '',
    );
    await tester.enterText(find.byKey(const ValueKey('field-Email')), '');
    await tester.enterText(find.byKey(const ValueKey('field-Mot de passe')), '');
    await tester.enterText(find.byKey(const ValueKey('field-Confirmer')), '');
    await _tapVisible(tester, 'Créer mon compte');
    await _pumpFrame(tester);
    await _expectShot('06_form_validation_error.png');
  });

  testWidgets('capture selection et confirmation produit', (tester) async {
    await _pumpPortal(tester, step: PlayerOnboardingStep.productFamily);
    await tester.ensureVisible(find.byKey(const ValueKey('product-PRES')));
    await tester.tap(find.byKey(const ValueKey('product-PRES')));
    await _pumpFrame(tester);
    await _expectShot('07_product_selected.png');

    await _pumpPortal(tester, step: PlayerOnboardingStep.productConfirm);
    await _expectShot('08_product_confirmation.png');
  });

  testWidgets('capture aide KPI smartphone', (tester) async {
    await _pumpPortal(tester, step: PlayerOnboardingStep.dashboard);
    await tester.ensureVisible(find.byKey(const ValueKey('kpi-info-cash')));
    await tester.tap(find.byKey(const ValueKey('kpi-info-cash')));
    await _pumpFrame(tester);
    await _expectShot('09_kpi_help_mobile.png');
  });

  testWidgets('capture aide KPI tablette', (tester) async {
    await _pumpPortal(
      tester,
      step: PlayerOnboardingStep.dashboard,
      size: const Size(834, 1112),
    );
    await tester.ensureVisible(find.byKey(const ValueKey('kpi-info-cash')));
    await tester.tap(find.byKey(const ValueKey('kpi-info-cash')));
    await _pumpFrame(tester);
    await _expectShot('10_kpi_help_tablet.png');
  });

  testWidgets('capture dashboard alertes et vue experte verrouillee',
      (tester) async {
    await _pumpPortal(tester, step: PlayerOnboardingStep.dashboard);
    await tester.ensureVisible(find.text('Alertes prioritaires'));
    await _pumpFrame(tester);
    await _expectShot('11_dashboard_with_alerts.png');

    await tester.ensureVisible(find.text('Vue experte'));
    await tester.tap(find.text('Vue experte'));
    await _pumpFrame(tester);
    await _expectShot('12_expert_view_locked.png');
  });
}

Future<void> _pumpPortal(
  WidgetTester tester, {
  PlayerOnboardingStep step = PlayerOnboardingStep.createAccount,
  Size size = const Size(390, 844),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetViewInsets);

  await tester.pumpWidget(BizPulsePlayerPortal(initialStep: step));
  await _pumpFrame(tester);
}

Future<void> _expectShot(String fileName) async {
  await expectLater(
    find.byType(BizPulsePlayerPortal),
    matchesGoldenFile('../captures/states/$fileName'),
  );
}

Future<void> _pumpFrame(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 420));
}

Future<void> _tapVisible(WidgetTester tester, String text) async {
  final finder = find.text(text);
  await tester.ensureVisible(finder);
  await tester.tap(finder);
}

Future<void> _loadScreenshotFonts() async {
  final flutterRoot = Platform.environment['FLUTTER_ROOT'];
  final fontRoots = <Directory>[
    Directory(
      '${Directory.current.parent.parent.path}/.tools/flutter/bin/cache/artifacts/material_fonts',
    ),
    if (flutterRoot != null)
      Directory('$flutterRoot/bin/cache/artifacts/material_fonts'),
  ];

  Directory? fontRoot;
  for (final candidate in fontRoots) {
    if (candidate.existsSync()) {
      fontRoot = candidate;
      break;
    }
  }

  if (fontRoot == null) {
    return;
  }

  await _loadFontFamily(
    'Roboto',
    [
      'Roboto-Regular.ttf',
      'Roboto-Light.ttf',
      'Roboto-Medium.ttf',
      'Roboto-Bold.ttf',
      'Roboto-Black.ttf',
    ].map((fileName) => File('${fontRoot!.path}/$fileName')),
  );

  await _loadFontFamily(
    'MaterialIcons',
    [File('${fontRoot.path}/MaterialIcons-Regular.otf')],
  );
}

Future<void> _loadFontFamily(String family, Iterable<File> files) async {
  final fontLoader = FontLoader(family);
  var hasFonts = false;

  for (final file in files) {
    if (!file.existsSync()) {
      continue;
    }

    final bytes = file.readAsBytesSync();
    fontLoader.addFont(Future<ByteData>.value(ByteData.sublistView(bytes)));
    hasFonts = true;
  }

  if (hasFonts) {
    await fontLoader.load();
  }
}
