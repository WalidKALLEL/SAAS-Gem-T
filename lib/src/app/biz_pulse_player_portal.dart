import 'package:flutter/material.dart';

import 'app_constants.dart';
import '../design_system/biz_pulse_design_system.dart';
import '../onboarding/onboarding_models.dart';
import '../onboarding/player_onboarding_flow.dart';

class BizPulsePlayerPortal extends StatefulWidget {
  const BizPulsePlayerPortal({
    super.key,
    this.initialStep = PlayerOnboardingStep.createAccount,
    this.initialThemeMode = ThemeMode.light,
    this.dashboardData = initialDashboardData,
  });

  final PlayerOnboardingStep initialStep;
  final ThemeMode initialThemeMode;
  final DashboardData dashboardData;

  @override
  State<BizPulsePlayerPortal> createState() => _BizPulsePlayerPortalState();
}

class _BizPulsePlayerPortalState extends State<BizPulsePlayerPortal> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
  }

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      theme: BizPulseDesignSystem.lightTheme,
      darkTheme: BizPulseDesignSystem.darkTheme,
      themeMode: _themeMode,
      home: PlayerOnboardingFlow(
        initialStep: widget.initialStep,
        dashboardData: widget.dashboardData,
        themeMode: _themeMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}
