import 'dart:io';

import 'package:biz_pulse_player_portal/src/app/biz_pulse_player_portal.dart';
import 'package:biz_pulse_player_portal/src/onboarding/onboarding_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(_loadScreenshotFonts);

  testWidgets('capture creation de compte suivie de bienvenue', (tester) async {
    await _pumpPortal(tester);
    await _tapVisible(tester, 'Créer mon compte');
    await _pumpFrame(tester);

    await expectLater(
      find.byType(BizPulsePlayerPortal),
      matchesGoldenFile('../captures/after/06_create_account_to_welcome.png'),
    );
  });

  testWidgets('capture KPI non mesurable avec aide ouverte', (tester) async {
    await _pumpPortal(tester, step: PlayerOnboardingStep.dashboard);
    await tester.ensureVisible(find.text('Satisfaction client'));
    await _pumpFrame(tester);
    await tester.tap(find.byKey(const ValueKey('kpi-info-satisfaction')));
    await _pumpFrame(tester);

    await expectLater(
      find.byType(BizPulsePlayerPortal),
      matchesGoldenFile(
        '../captures/after/05_kpi_non_measurable_help_mobile.png',
      ),
    );
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

  await tester.pumpWidget(BizPulsePlayerPortal(initialStep: step));
  await _pumpFrame(tester);
  await tester.runAsync(() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
  });
  await _pumpFrame(tester);
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
