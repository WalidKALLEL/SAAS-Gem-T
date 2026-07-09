import 'dart:io';

import 'package:biz_pulse_player_portal/src/app/biz_pulse_player_portal.dart';
import 'package:biz_pulse_player_portal/src/onboarding/onboarding_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

var _logoAssetWarmed = false;

void main() {
  setUpAll(_loadScreenshotFonts);

  final screens = <String, PlayerOnboardingStep>{
    '01_create_account': PlayerOnboardingStep.createAccount,
    '02_login': PlayerOnboardingStep.login,
    '03_welcome': PlayerOnboardingStep.welcome,
    '04_learning_goal': PlayerOnboardingStep.learningGoal,
    '05_company_creation': PlayerOnboardingStep.company,
    '06_product_family': PlayerOnboardingStep.productFamily,
    '07_product_confirm': PlayerOnboardingStep.productConfirm,
    '08_first_turn_mission': PlayerOnboardingStep.firstMission,
    '09_tour_guide': PlayerOnboardingStep.tourGuide,
    '10_guided_visit': PlayerOnboardingStep.guidedVisit,
    '11_dashboard': PlayerOnboardingStep.dashboard,
  };

  for (final entry in screens.entries) {
    testWidgets('capture smartphone ${entry.key}', (tester) async {
      await _pumpScreenshot(
        tester,
        step: entry.value,
        size: const Size(390, 844),
      );

      await expectLater(
        find.byType(BizPulsePlayerPortal),
        matchesGoldenFile('goldens/mobile_${entry.key}.png'),
      );
    });

    testWidgets('capture tablette ${entry.key}', (tester) async {
      await _pumpScreenshot(
        tester,
        step: entry.value,
        size: const Size(834, 1112),
      );

      await expectLater(
        find.byType(BizPulsePlayerPortal),
        matchesGoldenFile('goldens/tablet_${entry.key}.png'),
      );
    });

    testWidgets('capture smartphone dark ${entry.key}', (tester) async {
      await _pumpScreenshot(
        tester,
        step: entry.value,
        size: const Size(390, 844),
        themeMode: ThemeMode.dark,
      );

      await expectLater(
        find.byType(BizPulsePlayerPortal),
        matchesGoldenFile('goldens/dark_mobile_${entry.key}.png'),
      );
    });
  }

  testWidgets('capture smartphone dashboard post turn demo', (tester) async {
    await _pumpScreenshot(
      tester,
      step: PlayerOnboardingStep.dashboard,
      size: const Size(390, 844),
      dashboardData: postTurnDemoDashboardData,
    );

    await expectLater(
      find.byType(BizPulsePlayerPortal),
      matchesGoldenFile('goldens/mobile_12_dashboard_post_turn_demo.png'),
    );
  });
}

Future<void> _pumpScreenshot(
  WidgetTester tester, {
  required PlayerOnboardingStep step,
  required Size size,
  ThemeMode themeMode = ThemeMode.light,
  DashboardData dashboardData = initialDashboardData,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  if (!_logoAssetWarmed) {
    await tester.pumpWidget(
      const BizPulsePlayerPortal(
        initialStep: PlayerOnboardingStep.createAccount,
      ),
    );
    await tester.pump();
    await tester.runAsync(() async {
      await Future<void>.delayed(const Duration(milliseconds: 800));
    });
    await tester.pumpAndSettle();
    _logoAssetWarmed = true;
  }

  await tester.pumpWidget(
    BizPulsePlayerPortal(
      initialStep: step,
      initialThemeMode: themeMode,
      dashboardData: dashboardData,
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 260));
  await tester.pumpAndSettle();
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
    fontLoader.addFont(
      Future<ByteData>.value(ByteData.sublistView(bytes)),
    );
    hasFonts = true;
  }

  if (hasFonts) {
    await fontLoader.load();
  }
}
