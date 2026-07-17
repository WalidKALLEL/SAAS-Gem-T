import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import '../app/app_constants.dart';
import '../design_system/biz_pulse_design_system.dart';
import 'onboarding_models.dart';

const logoAsset = 'assets/brand/biz-pulse-logo.png';

class PlayerPortalShell extends StatelessWidget {
  const PlayerPortalShell({
    super.key,
    required this.step,
    required this.themeMode,
    required this.onToggleTheme,
    required this.coachTitle,
    required this.coachMessage,
    required this.child,
  });

  final PlayerOnboardingStep step;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final String coachTitle;
  final String coachMessage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      body: DecoratedBox(
        decoration: BizPulseDesignSystem.pageBackground(brightness),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isTablet = constraints.maxWidth >= 760;
              final horizontalPadding = isTablet ? 36.0 : 12.0;
              final panelWidth = isTablet ? 1040.0 : 430.0;

              return Stack(
                children: [
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(
                        painter: _AmbientShapesPainter(
                          brightness: brightness,
                          animationValue: step.index / 10,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        isTablet ? 26 : 12,
                        horizontalPadding,
                        isTablet ? 92 : 82,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: panelWidth),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: BizPulseDesignSystem.panelColor(context),
                            borderRadius:
                                BorderRadius.circular(isTablet ? 22 : 20),
                            border: Border.all(
                              color: BizPulseDesignSystem.outlineColor(context),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  brightness == Brightness.dark ? 0.30 : 0.10,
                                ),
                                blurRadius: 34,
                                offset: const Offset(0, 20),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(isTablet ? 24 : 16),
                            child: isTablet
                                ? _TabletLayout(
                                    step: step,
                                    themeMode: themeMode,
                                    onToggleTheme: onToggleTheme,
                                    child: child,
                                  )
                                : _PhoneLayout(
                                    step: step,
                                    themeMode: themeMode,
                                    onToggleTheme: onToggleTheme,
                                    child: child,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: isTablet ? 36 : 18,
                    bottom: isTablet ? 30 : 18,
                    child: CoachBizButton(
                      title: coachTitle,
                      screenTitle: step.title,
                      message: coachMessage,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PhoneLayout extends StatelessWidget {
  const _PhoneLayout({
    required this.step,
    required this.themeMode,
    required this.onToggleTheme,
    required this.child,
  });

  final PlayerOnboardingStep step;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PortalToolbar(themeMode: themeMode, onToggleTheme: onToggleTheme),
        const SizedBox(height: 14),
        JourneyProgress(currentStep: step),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}

class _TabletLayout extends StatelessWidget {
  const _TabletLayout({
    required this.step,
    required this.themeMode,
    required this.onToggleTheme,
    required this.child,
  });

  final PlayerOnboardingStep step;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PortalToolbar(themeMode: themeMode, onToggleTheme: onToggleTheme),
        const SizedBox(height: 22),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const BrandPanel(),
                  const SizedBox(height: 14),
                  JourneyProgress(currentStep: step, vertical: true),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(flex: 7, child: child),
          ],
        ),
      ],
    );
  }
}

class PortalToolbar extends StatelessWidget {
  const PortalToolbar({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 92,
          child: Image(
            image: AssetImage(logoAsset),
            height: 30,
            fit: BoxFit.contain,
            semanticLabel: '$APP_NAME Business challenge',
          ),
        ),
        const SizedBox(width: 10),
        const LanguageSelector(),
        const Spacer(),
        IconButton.filledTonal(
          key: const ValueKey('theme-toggle'),
          tooltip: themeMode == ThemeMode.dark ? 'Mode clair' : 'Mode dark',
          onPressed: onToggleTheme,
          icon: Icon(
            themeMode == ThemeMode.dark
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
            size: 19,
          ),
        ),
      ],
    );
  }
}

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        color: BizPulseDesignSystem.softPanelColor(context),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: BizPulseDesignSystem.outlineColor(context)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          key: const ValueKey('language-selector'),
          value: 'en',
          borderRadius: BorderRadius.circular(BizPulseDesignSystem.radius),
          isDense: true,
          icon: const Icon(Icons.expand_more_rounded, size: 17),
          items: const [
            DropdownMenuItem(
              value: 'ar',
              child: _LanguageChoice(language: 'ar', label: 'AR'),
            ),
            DropdownMenuItem(
              value: 'fr',
              child: _LanguageChoice(language: 'fr', label: 'FR'),
            ),
            DropdownMenuItem(
              value: 'en',
              child: _LanguageChoice(language: 'en', label: 'EN'),
            ),
          ],
          selectedItemBuilder: (context) => const [
            _LanguageChoice(language: 'ar', label: 'AR'),
            _LanguageChoice(language: 'fr', label: 'FR'),
            _LanguageChoice(language: 'en', label: 'EN'),
          ],
          onChanged: (_) {},
        ),
      ),
    );
  }
}

class _LanguageChoice extends StatelessWidget {
  const _LanguageChoice({required this.language, required this.label});

  final String language;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 16,
          height: 12,
          child: CustomPaint(painter: _LanguageFlagPainter(language)),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }
}

class _LanguageFlagPainter extends CustomPainter {
  const _LanguageFlagPainter(this.language);

  final String language;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final borderRadius = BorderRadius.circular(2);
    final clipPath = Path()..addRRect(borderRadius.toRRect(rect));

    canvas.save();
    canvas.clipPath(clipPath);

    switch (language) {
      case 'ar':
        _paintTunisia(canvas, size);
        break;
      case 'fr':
        _paintFrance(canvas, size);
        break;
      default:
        _paintEngland(canvas, size);
    }

    canvas.restore();
    canvas.drawRRect(
      borderRadius.toRRect(rect),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.7
        ..color = const Color(0x55263863),
    );
  }

  void _paintTunisia(Canvas canvas, Size size) {
    canvas.drawRect(
        Offset.zero & size, Paint()..color = const Color(0xFFE11D2E));
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.height * 0.31,
      Paint()..color = Colors.white,
    );
    canvas.drawCircle(
      Offset(size.width * 0.53, size.height * 0.5),
      size.height * 0.22,
      Paint()..color = const Color(0xFFE11D2E),
    );
    canvas.drawCircle(
      Offset(size.width * 0.59, size.height * 0.5),
      size.height * 0.19,
      Paint()..color = Colors.white,
    );
  }

  void _paintFrance(Canvas canvas, Size size) {
    final third = size.width / 3;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, third, size.height),
      Paint()..color = const Color(0xFF244AA5),
    );
    canvas.drawRect(
      Rect.fromLTWH(third, 0, third, size.height),
      Paint()..color = Colors.white,
    );
    canvas.drawRect(
      Rect.fromLTWH(third * 2, 0, third, size.height),
      Paint()..color = const Color(0xFFE43D4D),
    );
  }

  void _paintEngland(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.white);
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.5),
        width: size.width,
        height: size.height * 0.24,
      ),
      Paint()..color = const Color(0xFFD91E36),
    );
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.5),
        width: size.width * 0.20,
        height: size.height,
      ),
      Paint()..color = const Color(0xFFD91E36),
    );
  }

  @override
  bool shouldRepaint(covariant _LanguageFlagPainter oldDelegate) {
    return oldDelegate.language != language;
  }
}

class BrandPanel extends StatelessWidget {
  const BrandPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: BizPulseDesignSystem.accentGradient(context),
        ),
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.cardRadius),
        border: Border.all(color: BizPulseDesignSystem.outlineColor(context)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(
              image: AssetImage(logoAsset),
              height: 58,
              fit: BoxFit.contain,
              semanticLabel: '$APP_NAME Business challenge',
            ),
            const SizedBox(height: 16),
            Text('Votre cockpit se prépare.',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              'Une prise en main courte pour entrer dans le rôle sans surcharge.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class JourneyProgress extends StatelessWidget {
  const JourneyProgress({
    super.key,
    required this.currentStep,
    this.vertical = false,
  });

  final PlayerOnboardingStep currentStep;
  final bool vertical;

  static const groups = [
    _JourneyGroup('Compte'),
    _JourneyGroup('Bienvenue'),
    _JourneyGroup('Entreprise'),
    _JourneyGroup('Produit'),
    _JourneyGroup('Mission'),
    _JourneyGroup('Visite', optional: true),
    _JourneyGroup('Dashboard'),
  ];

  @override
  Widget build(BuildContext context) {
    final current = currentStep.progressIndex;

    if (vertical) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: BizPulseDesignSystem.elevatedSurface(context),
          borderRadius: BorderRadius.circular(BizPulseDesignSystem.cardRadius),
          border: Border.all(color: BizPulseDesignSystem.outlineColor(context)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Progression',
                  style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 5),
              Text(
                'Étape ${currentStep.index + 1} sur ${PlayerOnboardingStep.values.length}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 12),
              for (var index = 0; index < groups.length; index += 1)
                _ProgressItem(
                  label: groups[index].label,
                  status: _statusForGroup(index, current),
                  index: index,
                  vertical: true,
                ),
            ],
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: BizPulseDesignSystem.elevatedSurface(context),
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.cardRadius),
        border: Border.all(color: BizPulseDesignSystem.outlineColor(context)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: BizPulseDesignSystem.progressGreen.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.route_rounded,
                    color: BizPulseDesignSystem.progressGreen,
                    size: 19,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Étape ${currentStep.index + 1} sur ${PlayerOnboardingStep.values.length}',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        currentStep.title,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Voir toutes les étapes',
                  onPressed: () => _showJourneySheet(context),
                  icon: const Icon(Icons.format_list_bulleted_rounded),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: (currentStep.index + 1) /
                    PlayerOnboardingStep.values.length,
                minHeight: 7,
                backgroundColor: BizPulseDesignSystem.outlineColor(context),
                color: BizPulseDesignSystem.progressGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _JourneyStepStatus _statusForGroup(int index, int current) {
    if (index < current) {
      return _JourneyStepStatus.done;
    }
    if (index == current) {
      return _JourneyStepStatus.active;
    }
    if (groups[index].optional) {
      return _JourneyStepStatus.optional;
    }
    if (index == current + 1) {
      return _JourneyStepStatus.upcoming;
    }
    return _JourneyStepStatus.locked;
  }

  _JourneyStepStatus _statusForStep(PlayerOnboardingStep step) {
    if (step.index < currentStep.index) {
      return _JourneyStepStatus.done;
    }
    if (step.index == currentStep.index) {
      return _JourneyStepStatus.active;
    }
    if (step == PlayerOnboardingStep.guidedVisit) {
      return _JourneyStepStatus.optional;
    }
    if (step.index == currentStep.index + 1) {
      return _JourneyStepStatus.upcoming;
    }
    return _JourneyStepStatus.locked;
  }

  void _showJourneySheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Parcours de prise en main',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 6),
                Text(
                  'Les étapes futures restent visibles, mais verrouillées jusqu’au bon moment.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 14),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (final step in PlayerOnboardingStep.values)
                          _ProgressItem(
                            label: step.title,
                            index: step.index,
                            status: _statusForStep(step),
                            vertical: true,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _JourneyGroup {
  const _JourneyGroup(this.label, {this.optional = false});

  final String label;
  final bool optional;
}

enum _JourneyStepStatus {
  done,
  active,
  upcoming,
  locked,
  optional,
}

class _ProgressItem extends StatelessWidget {
  const _ProgressItem({
    required this.label,
    required this.index,
    required this.status,
    required this.vertical,
  });

  final String label;
  final int index;
  final _JourneyStepStatus status;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(context);
    final background = switch (status) {
      _JourneyStepStatus.active => color.withOpacity(0.14),
      _JourneyStepStatus.done => color.withOpacity(0.08),
      _JourneyStepStatus.optional => color.withOpacity(0.08),
      _ => Colors.transparent,
    };

    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: EdgeInsets.symmetric(
        horizontal: 9,
        vertical: vertical ? 8 : 7,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _statusIcon(),
            size: 15,
            color: color,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: status == _JourneyStepStatus.locked
                            ? Theme.of(context).textTheme.bodyMedium?.color
                            : color,
                        fontWeight: status == _JourneyStepStatus.active
                            ? FontWeight.w900
                            : FontWeight.w800,
                      ),
                ),
                if (vertical) ...[
                  const SizedBox(height: 1),
                  Text(
                    _statusLabel(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: color,
                        ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );

    if (!vertical) {
      return content;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: content,
    );
  }

  Color _statusColor(BuildContext context) {
    return switch (status) {
      _JourneyStepStatus.done => BizPulseDesignSystem.progressGreen,
      _JourneyStepStatus.active => BizPulseDesignSystem.trustBlue,
      _JourneyStepStatus.upcoming => BizPulseDesignSystem.bizGold,
      _JourneyStepStatus.optional => BizPulseDesignSystem.innovationViolet,
      _JourneyStepStatus.locked =>
        Theme.of(context).textTheme.bodyMedium?.color ??
            BizPulseDesignSystem.muted,
    };
  }

  IconData _statusIcon() {
    return switch (status) {
      _JourneyStepStatus.done => Icons.check_circle_rounded,
      _JourneyStepStatus.active => Icons.radio_button_checked_rounded,
      _JourneyStepStatus.upcoming => Icons.arrow_circle_right_rounded,
      _JourneyStepStatus.optional => Icons.explore_rounded,
      _JourneyStepStatus.locked => Icons.lock_rounded,
    };
  }

  String _statusLabel() {
    return switch (status) {
      _JourneyStepStatus.done => 'Terminé',
      _JourneyStepStatus.active => 'Actif',
      _JourneyStepStatus.upcoming => 'À venir',
      _JourneyStepStatus.optional => 'Facultatif',
      _JourneyStepStatus.locked => 'Verrouillé',
    };
  }
}

class StageScaffold extends StatelessWidget {
  const StageScaffold({
    super.key,
    required this.illustration,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.children,
    this.primaryLabel,
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.tertiaryLabel,
    this.onTertiary,
    this.confirmation,
    this.denseHeader = false,
  });

  final StageIllustrationType illustration;
  final String eyebrow;
  final String title;
  final String subtitle;
  final List<Widget> children;
  final String? primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final String? tertiaryLabel;
  final VoidCallback? onTertiary;
  final String? confirmation;
  final bool denseHeader;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.96, end: 1),
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          alignment: Alignment.topCenter,
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return StageIllustration(
                type: illustration,
                compact: constraints.maxWidth < 420,
                dense: denseHeader,
              );
            },
          ),
          SizedBox(height: denseHeader ? 10 : 16),
          Text(
            eyebrow,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w900,
                ),
          ),
          SizedBox(height: denseHeader ? 4 : 6),
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          SizedBox(height: denseHeader ? 4 : 8),
          Text(subtitle, style: Theme.of(context).textTheme.bodyLarge),
          if (confirmation != null) ...[
            const SizedBox(height: 12),
            PositiveFeedback(message: confirmation!),
          ],
          if (children.isNotEmpty) ...[
            SizedBox(height: denseHeader ? 10 : 16),
            ...children,
          ],
          if (primaryLabel != null || secondaryLabel != null) ...[
            const SizedBox(height: 18),
            ActionArea(
              primaryLabel: primaryLabel,
              onPrimary: onPrimary,
              secondaryLabel: secondaryLabel,
              onSecondary: onSecondary,
              tertiaryLabel: tertiaryLabel,
              onTertiary: onTertiary,
            ),
          ],
        ],
      ),
    );
  }
}

class StageIllustration extends StatelessWidget {
  const StageIllustration({
    super.key,
    required this.type,
    this.compact = false,
    this.dense = false,
  });

  final StageIllustrationType type;
  final bool compact;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final height = dense ? 90.0 : (compact ? 116.0 : 138.0);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderRadius = BorderRadius.circular(18);

    return Semantics(
      label: _semanticLabel(type),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: BizPulseDesignSystem.outlineColor(context)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              _photoAsset(type),
              fit: BoxFit.cover,
              semanticLabel: _semanticLabel(type),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(isDark ? 0.50 : 0.30),
                    Colors.black.withOpacity(isDark ? 0.22 : 0.08),
                    Colors.white.withOpacity(isDark ? 0.02 : 0.18),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: isDark ? 0.10 : 0.07,
              child: CustomPaint(
                painter: _StageIllustrationPainter(
                  type: type,
                  brightness: Theme.of(context).brightness,
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 14,
              child: _IllustrationBadge(type: type),
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: _SceneSignalStrip(type: type),
            ),
          ],
        ),
      ),
    );
  }

  String _photoAsset(StageIllustrationType type) {
    switch (type) {
      case StageIllustrationType.account:
      case StageIllustrationType.login:
      case StageIllustrationType.mission:
        return 'assets/onboarding/strategy-office.png';
      case StageIllustrationType.welcome:
      case StageIllustrationType.company:
      case StageIllustrationType.visit:
        return 'assets/onboarding/incubator.png';
      case StageIllustrationType.goal:
        return 'assets/onboarding/boardroom.png';
      case StageIllustrationType.product:
      case StageIllustrationType.confirmation:
        return 'assets/onboarding/smart-factory.png';
      case StageIllustrationType.tour:
      case StageIllustrationType.dashboard:
        return 'assets/onboarding/analytics-cockpit.png';
    }
  }

  String _semanticLabel(StageIllustrationType type) {
    switch (type) {
      case StageIllustrationType.account:
        return 'Illustration de création de compte joueur';
      case StageIllustrationType.login:
        return 'Illustration de connexion sécurisée';
      case StageIllustrationType.welcome:
        return 'Illustration d’entrepreneur aux commandes';
      case StageIllustrationType.goal:
        return 'Illustration d’objectif d’apprentissage';
      case StageIllustrationType.company:
        return 'Illustration de création d’entreprise';
      case StageIllustrationType.product:
        return 'Illustration de choix produit';
      case StageIllustrationType.confirmation:
        return 'Illustration de confirmation positive';
      case StageIllustrationType.mission:
        return 'Illustration de mission stratégique';
      case StageIllustrationType.tour:
        return 'Illustration de fonctionnement d’un tour';
      case StageIllustrationType.visit:
        return 'Illustration de visite guidée du cockpit';
      case StageIllustrationType.dashboard:
        return 'Illustration du dashboard du premier tour';
    }
  }
}

class _SceneSignalStrip extends StatelessWidget {
  const _SceneSignalStrip({required this.type});

  final StageIllustrationType type;

  @override
  Widget build(BuildContext context) {
    final icons = switch (type) {
      StageIllustrationType.account => [
          Icons.badge_rounded,
          Icons.security_rounded,
          Icons.arrow_forward_rounded,
        ],
      StageIllustrationType.login => [
          Icons.lock_rounded,
          Icons.devices_rounded,
          Icons.check_rounded,
        ],
      StageIllustrationType.welcome => [
          Icons.rocket_launch_rounded,
          Icons.business_center_rounded,
          Icons.trending_up_rounded,
        ],
      StageIllustrationType.goal => [
          Icons.route_rounded,
          Icons.flag_rounded,
          Icons.insights_rounded,
        ],
      StageIllustrationType.company => [
          Icons.apartment_rounded,
          Icons.groups_rounded,
          Icons.foundation_rounded,
        ],
      StageIllustrationType.product => [
          Icons.precision_manufacturing_rounded,
          Icons.inventory_2_rounded,
          Icons.verified_rounded,
        ],
      StageIllustrationType.confirmation => [
          Icons.verified_rounded,
          Icons.rule_rounded,
          Icons.done_all_rounded,
        ],
      StageIllustrationType.mission => [
          Icons.psychology_alt_rounded,
          Icons.timeline_rounded,
          Icons.bolt_rounded,
        ],
      StageIllustrationType.tour => [
          Icons.visibility_rounded,
          Icons.touch_app_rounded,
          Icons.analytics_rounded,
        ],
      StageIllustrationType.visit => [
          Icons.explore_rounded,
          Icons.widgets_rounded,
          Icons.dashboard_customize_rounded,
        ],
      StageIllustrationType.dashboard => [
          Icons.speed_rounded,
          Icons.query_stats_rounded,
          Icons.assessment_rounded,
        ],
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: BizPulseDesignSystem.bizBlack.withOpacity(0.72),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.16)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var index = 0; index < icons.length; index += 1) ...[
              Icon(
                icons[index],
                size: 15,
                color: BizPulseDesignSystem.bizGold,
              ),
              if (index != icons.length - 1) const SizedBox(width: 7),
            ],
          ],
        ),
      ),
    );
  }
}

class _IllustrationBadge extends StatelessWidget {
  const _IllustrationBadge({required this.type});

  final StageIllustrationType type;

  @override
  Widget build(BuildContext context) {
    final data = switch (type) {
      StageIllustrationType.account => (
          Icons.person_add_alt_1_rounded,
          BizPulseDesignSystem.trustBlue
        ),
      StageIllustrationType.login => (
          Icons.lock_open_rounded,
          BizPulseDesignSystem.bizGold
        ),
      StageIllustrationType.welcome => (
          Icons.rocket_launch_rounded,
          BizPulseDesignSystem.innovationViolet
        ),
      StageIllustrationType.goal => (
          Icons.flag_rounded,
          BizPulseDesignSystem.progressGreen
        ),
      StageIllustrationType.company => (
          Icons.apartment_rounded,
          BizPulseDesignSystem.trustBlue
        ),
      StageIllustrationType.product => (
          Icons.widgets_rounded,
          BizPulseDesignSystem.turquoise
        ),
      StageIllustrationType.confirmation => (
          Icons.verified_rounded,
          BizPulseDesignSystem.progressGreen
        ),
      StageIllustrationType.mission => (
          Icons.psychology_alt_rounded,
          BizPulseDesignSystem.innovationViolet
        ),
      StageIllustrationType.tour => (
          Icons.sync_alt_rounded,
          BizPulseDesignSystem.bizGold
        ),
      StageIllustrationType.visit => (
          Icons.explore_rounded,
          BizPulseDesignSystem.trustBlue
        ),
      StageIllustrationType.dashboard => (
          Icons.dashboard_rounded,
          BizPulseDesignSystem.turquoise
        ),
    };

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: data.$2,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: data.$2.withOpacity(0.18),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(data.$1, color: Colors.white, size: 28),
    );
  }
}

class _StageIllustrationPainter extends CustomPainter {
  const _StageIllustrationPainter({
    required this.type,
    required this.brightness,
  });

  final StageIllustrationType type;
  final Brightness brightness;

  @override
  void paint(Canvas canvas, Size size) {
    final isDark = brightness == Brightness.dark;
    final ink = Paint()
      ..color = isDark ? const Color(0xFFEAF2FF) : BizPulseDesignSystem.bizBlack
      ..style = PaintingStyle.fill;
    final blue = Paint()..color = BizPulseDesignSystem.trustBlue;
    final gold = Paint()..color = BizPulseDesignSystem.bizGold;
    final green = Paint()..color = BizPulseDesignSystem.progressGreen;
    final violet = Paint()..color = BizPulseDesignSystem.innovationViolet;
    final teal = Paint()..color = BizPulseDesignSystem.turquoise;
    final white = Paint()
      ..color = Colors.white.withOpacity(isDark ? 0.08 : 0.58);

    canvas.drawCircle(Offset(size.width * 0.82, size.height * 0.24),
        size.height * 0.34, white);
    canvas.drawCircle(Offset(size.width * 0.74, size.height * 0.86),
        size.height * 0.15, gold..color = gold.color.withOpacity(0.20));
    canvas.drawCircle(Offset(size.width * 0.95, size.height * 0.76),
        size.height * 0.13, teal..color = teal.color.withOpacity(0.15));

    switch (type) {
      case StageIllustrationType.account:
      case StageIllustrationType.login:
        _paintIdentity(canvas, size, ink, blue, gold, green);
        break;
      case StageIllustrationType.welcome:
        _paintRocket(canvas, size, ink, violet, gold, teal);
        break;
      case StageIllustrationType.goal:
        _paintGoal(canvas, size, ink, blue, green, gold);
        break;
      case StageIllustrationType.company:
        _paintCompany(canvas, size, ink, blue, gold, teal);
        break;
      case StageIllustrationType.product:
      case StageIllustrationType.confirmation:
        _paintProducts(canvas, size, ink, blue, violet, teal, green);
        break;
      case StageIllustrationType.mission:
        _paintMission(canvas, size, ink, violet, blue, gold);
        break;
      case StageIllustrationType.tour:
        _paintTour(canvas, size, ink, blue, green, gold);
        break;
      case StageIllustrationType.visit:
        _paintVisit(canvas, size, ink, blue, violet, teal);
        break;
      case StageIllustrationType.dashboard:
        _paintDashboard(canvas, size, ink, blue, green, gold, violet);
        break;
    }
  }

  void _paintIdentity(Canvas canvas, Size size, Paint ink, Paint blue,
      Paint gold, Paint green) {
    final card = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.36, size.height * 0.20, size.width * 0.46,
          size.height * 0.52),
      const Radius.circular(14),
    );
    canvas.drawRRect(card, Paint()..color = Colors.white.withOpacity(0.86));
    canvas.drawRRect(
      card,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = blue.color.withOpacity(0.30),
    );
    canvas.drawCircle(
      Offset(size.width * 0.49, size.height * 0.38),
      size.height * 0.09,
      gold,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.43, size.height * 0.52, size.width * 0.28,
            size.height * 0.06),
        const Radius.circular(20),
      ),
      ink,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.55, size.height * 0.62, size.width * 0.18,
            size.height * 0.045),
        const Radius.circular(20),
      ),
      green,
    );
    canvas.drawCircle(Offset(size.width * 0.77, size.height * 0.27),
        size.height * 0.055, blue);
  }

  void _paintRocket(Canvas canvas, Size size, Paint ink, Paint violet,
      Paint gold, Paint teal) {
    final body = Path()
      ..moveTo(size.width * 0.54, size.height * 0.18)
      ..quadraticBezierTo(size.width * 0.76, size.height * 0.42,
          size.width * 0.58, size.height * 0.73)
      ..quadraticBezierTo(size.width * 0.42, size.height * 0.44,
          size.width * 0.54, size.height * 0.18);
    canvas.drawPath(body, ink);
    canvas.drawCircle(Offset(size.width * 0.57, size.height * 0.40),
        size.height * 0.055, gold);
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.45, size.height * 0.60)
        ..lineTo(size.width * 0.34, size.height * 0.78)
        ..lineTo(size.width * 0.52, size.height * 0.70)
        ..close(),
      violet,
    );
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.64, size.height * 0.60)
        ..lineTo(size.width * 0.82, size.height * 0.73)
        ..lineTo(size.width * 0.58, size.height * 0.70)
        ..close(),
      teal,
    );
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.30), 5, gold);
    canvas.drawCircle(Offset(size.width * 0.80, size.height * 0.22), 4, violet);
  }

  void _paintGoal(Canvas canvas, Size size, Paint ink, Paint blue, Paint green,
      Paint gold) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.38, size.height * 0.22, size.width * 0.08,
            size.height * 0.56),
        const Radius.circular(8),
      ),
      ink,
    );
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.46, size.height * 0.25)
        ..lineTo(size.width * 0.78, size.height * 0.33)
        ..lineTo(size.width * 0.46, size.height * 0.47)
        ..close(),
      green,
    );
    for (var i = 0; i < 3; i += 1) {
      canvas.drawCircle(
          Offset(
              size.width * (0.40 + i * 0.13), size.height * (0.82 - i * 0.09)),
          size.height * 0.05,
          [blue, gold, green][i]);
    }
  }

  void _paintCompany(
      Canvas canvas, Size size, Paint ink, Paint blue, Paint gold, Paint teal) {
    final baseY = size.height * 0.75;
    for (var i = 0; i < 3; i += 1) {
      final left = size.width * (0.38 + i * 0.14);
      final height = size.height * (0.32 + i * 0.08);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(left, baseY - height, size.width * 0.10, height),
          const Radius.circular(8),
        ),
        [blue, ink, teal][i],
      );
      canvas.drawCircle(
          Offset(left + size.width * 0.05, baseY - height - 10), 5, gold);
    }
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.35, baseY, size.width * 0.50, 8),
        const Radius.circular(8),
      ),
      gold,
    );
  }

  void _paintProducts(Canvas canvas, Size size, Paint ink, Paint blue,
      Paint violet, Paint teal, Paint green) {
    final colors = [blue, violet, teal];
    for (var i = 0; i < 3; i += 1) {
      final left = size.width * (0.35 + i * 0.16);
      final top = size.height * (0.28 + (i.isEven ? 0 : 0.08));
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, size.width * 0.13, size.height * 0.34),
        const Radius.circular(14),
      );
      canvas.drawRRect(rect, colors[i]);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(left + 10, top + 12, size.width * 0.07, 7),
          const Radius.circular(5),
        ),
        Paint()..color = Colors.white.withOpacity(0.75),
      );
    }
    canvas.drawCircle(Offset(size.width * 0.80, size.height * 0.33), 12, green);
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.775, size.height * 0.33)
        ..lineTo(size.width * 0.795, size.height * 0.35)
        ..lineTo(size.width * 0.83, size.height * 0.30),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..color = Colors.white,
    );
    canvas.drawCircle(Offset(size.width * 0.40, size.height * 0.77), 4, ink);
  }

  void _paintMission(Canvas canvas, Size size, Paint ink, Paint violet,
      Paint blue, Paint gold) {
    canvas.drawCircle(Offset(size.width * 0.56, size.height * 0.48),
        size.height * 0.22, violet);
    canvas.drawCircle(Offset(size.width * 0.56, size.height * 0.48),
        size.height * 0.13, Paint()..color = Colors.white.withOpacity(0.88));
    canvas.drawCircle(Offset(size.width * 0.56, size.height * 0.48),
        size.height * 0.055, gold);
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.34, size.height * 0.70)
        ..lineTo(size.width * 0.78, size.height * 0.28),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round
        ..color = ink.color,
    );
    canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.28), 7, blue);
  }

  void _paintTour(Canvas canvas, Size size, Paint ink, Paint blue, Paint green,
      Paint gold) {
    final center = Offset(size.width * 0.60, size.height * 0.50);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.height * 0.25),
      -math.pi * 0.2,
      math.pi * 1.35,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7
        ..strokeCap = StrokeCap.round
        ..color = blue.color,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.height * 0.16),
      math.pi * 0.8,
      math.pi * 1.1,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7
        ..strokeCap = StrokeCap.round
        ..color = green.color,
    );
    canvas.drawCircle(center, size.height * 0.08, gold);
    canvas.drawCircle(Offset(size.width * 0.38, size.height * 0.32), 6, ink);
  }

  void _paintVisit(Canvas canvas, Size size, Paint ink, Paint blue,
      Paint violet, Paint teal) {
    final frame = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.34, size.height * 0.24, size.width * 0.52,
          size.height * 0.44),
      const Radius.circular(14),
    );
    canvas.drawRRect(frame, Paint()..color = Colors.white.withOpacity(0.86));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.38, size.height * 0.32, size.width * 0.16,
            size.height * 0.10),
        const Radius.circular(8),
      ),
      blue,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.58, size.height * 0.32, size.width * 0.20,
            size.height * 0.10),
        const Radius.circular(8),
      ),
      violet,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.38, size.height * 0.48, size.width * 0.40,
            size.height * 0.08),
        const Radius.circular(8),
      ),
      teal,
    );
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.70, size.height * 0.72)
        ..lineTo(size.width * 0.80, size.height * 0.82)
        ..lineTo(size.width * 0.78, size.height * 0.68)
        ..close(),
      ink,
    );
  }

  void _paintDashboard(Canvas canvas, Size size, Paint ink, Paint blue,
      Paint green, Paint gold, Paint violet) {
    final left = size.width * 0.34;
    final top = size.height * 0.24;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, size.width * 0.52, size.height * 0.48),
        const Radius.circular(16),
      ),
      Paint()..color = Colors.white.withOpacity(0.88),
    );
    final bars = [0.28, 0.46, 0.35, 0.58];
    final paints = [blue, green, gold, violet];
    for (var i = 0; i < bars.length; i += 1) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(left + 18, top + 24 + i * 18, size.width * bars[i], 8),
          const Radius.circular(8),
        ),
        paints[i],
      );
    }
    canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.35), 15, ink);
  }

  @override
  bool shouldRepaint(covariant _StageIllustrationPainter oldDelegate) {
    return oldDelegate.type != type || oldDelegate.brightness != brightness;
  }
}

enum _CoachBizStatus {
  closed,
  notification,
  panelOpen,
  reading,
  listening,
  completed,
}

class CoachBizButton extends StatefulWidget {
  const CoachBizButton({
    super.key,
    required this.title,
    required this.screenTitle,
    required this.message,
  });

  final String title;
  final String screenTitle;
  final String message;

  @override
  State<CoachBizButton> createState() => _CoachBizButtonState();
}

class _CoachBizButtonState extends State<CoachBizButton> {
  _CoachBizStatus _status = _CoachBizStatus.notification;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width >= 760;
    final label = isTablet ? widget.title : 'COACH';

    return Semantics(
      button: true,
      label: '${widget.title}. Aide disponible pour ${widget.screenTitle}.',
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.96, end: 1),
        duration: const Duration(milliseconds: 720),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.scale(scale: value, child: child);
        },
        child: Material(
          key: const ValueKey('coach-biz'),
          color: BizPulseDesignSystem.bizBlack,
          borderRadius: BorderRadius.circular(999),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.18),
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: _openCoach,
            child: Container(
              constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: BizPulseDesignSystem.bizGold),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: BizPulseDesignSystem.bizGold,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: const Icon(
                          Icons.psychology_alt_rounded,
                          color: BizPulseDesignSystem.bizBlack,
                          size: 19,
                        ),
                      ),
                      if (_status == _CoachBizStatus.notification)
                        Positioned(
                          right: -2,
                          top: -2,
                          child: _CoachPulseDot(),
                        ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openCoach() async {
    setState(() => _status = _CoachBizStatus.panelOpen);
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return _CoachBizPanel(
          title: widget.title,
          screenTitle: widget.screenTitle,
          message: widget.message,
          onStatusChanged: (status) {
            if (mounted) {
              setState(() => _status = status);
            }
          },
        );
      },
    );
    if (mounted) {
      setState(() => _status = _CoachBizStatus.completed);
    }
  }
}

class _CoachPulseDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.55, end: 1),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              color: BizPulseDesignSystem.progressGreen,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
          ),
        );
      },
    );
  }
}

class _CoachBizPanel extends StatefulWidget {
  const _CoachBizPanel({
    required this.title,
    required this.screenTitle,
    required this.message,
    required this.onStatusChanged,
  });

  final String title;
  final String screenTitle;
  final String message;
  final ValueChanged<_CoachBizStatus> onStatusChanged;

  @override
  State<_CoachBizPanel> createState() => _CoachBizPanelState();
}

class _CoachBizPanelState extends State<_CoachBizPanel> {
  _CoachBizStatus _status = _CoachBizStatus.panelOpen;
  String _activeGuidance =
      'Je peux expliquer l’objectif, les risques et les KPI à surveiller, sans donner de stratégie gagnante.';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          6,
          20,
          20 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: BizPulseDesignSystem.goldSoft,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.psychology_alt_rounded,
                        color: BizPulseDesignSystem.bizBlack,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.title,
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 3),
                          Text(
                            widget.screenTitle,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                    _CoachStatusChip(status: _status),
                  ],
                ),
                const SizedBox(height: 14),
                Text(widget.message,
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 12),
                _CoachGuidanceCard(text: _activeGuidance),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 9,
                  runSpacing: 9,
                  children: [
                    _CoachActionChip(
                      icon: Icons.volume_up_rounded,
                      label: 'Lire cet écran',
                      onPressed: _readScreen,
                    ),
                    _CoachActionChip(
                      icon: Icons.help_rounded,
                      label: 'Que dois-je faire maintenant ?',
                      onPressed: () => _setGuidance(
                        'Concentrez-vous sur l’action principale de cet écran. Lisez les signaux, choisissez, puis avancez sans chercher la décision parfaite.',
                        _CoachBizStatus.completed,
                      ),
                    ),
                    _CoachActionChip(
                      icon: Icons.school_rounded,
                      label: 'Expliquer cette étape',
                      onPressed: () => _setGuidance(
                        'Cette étape prépare votre progression. Elle réduit la charge cognitive et transforme une décision abstraite en action simple.',
                        _CoachBizStatus.completed,
                      ),
                    ),
                    _CoachActionChip(
                      icon: Icons.compare_arrows_rounded,
                      label: 'Expliquer ce choix',
                      onPressed: () => _setGuidance(
                        'Comparez les conséquences possibles : demande, stock, cash, satisfaction et image. Je n’affiche jamais la meilleure réponse.',
                        _CoachBizStatus.completed,
                      ),
                    ),
                    _CoachActionChip(
                      icon: Icons.replay_rounded,
                      label: 'Répéter la consigne',
                      onPressed: _readScreen,
                    ),
                    _CoachActionChip(
                      icon: Icons.mic_rounded,
                      label: 'Écoute éventuelle',
                      onPressed: () => _setGuidance(
                        'Écoute prête : formulez une question sur l’objectif, la logique ou les KPI. Les réponses restent pédagogiques.',
                        _CoachBizStatus.listening,
                      ),
                    ),
                    _CoachActionChip(
                      icon: Icons.play_circle_rounded,
                      label: 'Ouvrir le tutoriel',
                      onPressed: () => _setGuidance(
                        'Tutoriel court : observer les signaux, prendre une décision, confirmer, puis analyser le résultat du tour.',
                        _CoachBizStatus.completed,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close_rounded, size: 18),
                        label: const Text('Fermer'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _readScreen() {
    SemanticsService.announce(widget.message, Directionality.of(context));
    _setGuidance(
      'Lecture audio lancée. Retenez surtout l’objectif de l’écran et le prochain geste à effectuer.',
      _CoachBizStatus.reading,
    );
  }

  void _setGuidance(String guidance, _CoachBizStatus status) {
    setState(() {
      _activeGuidance = guidance;
      _status = status;
    });
    widget.onStatusChanged(status);
  }
}

class _CoachStatusChip extends StatelessWidget {
  const _CoachStatusChip({required this.status});

  final _CoachBizStatus status;

  @override
  Widget build(BuildContext context) {
    final label = switch (status) {
      _CoachBizStatus.closed => 'Fermé',
      _CoachBizStatus.notification => 'Aide',
      _CoachBizStatus.panelOpen => 'Ouvert',
      _CoachBizStatus.reading => 'Audio',
      _CoachBizStatus.listening => 'Écoute',
      _CoachBizStatus.completed => 'Terminé',
    };

    return MiniChip(
      label: label,
      color: status == _CoachBizStatus.completed
          ? BizPulseDesignSystem.progressGreen
          : BizPulseDesignSystem.bizGold,
      icon: status == _CoachBizStatus.reading
          ? Icons.volume_up_rounded
          : Icons.bolt_rounded,
    );
  }
}

class _CoachGuidanceCard extends StatelessWidget {
  const _CoachGuidanceCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: BizPulseDesignSystem.blueSoft,
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.cardRadius),
        border: Border.all(
          color: BizPulseDesignSystem.trustBlue.withOpacity(0.18),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_rounded,
            color: BizPulseDesignSystem.trustBlue,
            size: 20,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: BizPulseDesignSystem.bizBlack,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoachActionChip extends StatelessWidget {
  const _CoachActionChip({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 17),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(44, 44),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
}

class RequiredFieldLabel extends StatelessWidget {
  const RequiredFieldLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '*',
          style: TextStyle(
            color: Color(0xFFE02424),
            fontSize: 12,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}

class BizTextField extends StatelessWidget {
  const BizTextField({
    super.key,
    required this.label,
    required this.controller,
    this.required = false,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final bool required;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        required
            ? RequiredFieldLabel(label)
            : Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 6),
        SizedBox(
          height: BizPulseDesignSystem.inputHeight,
          child: TextField(
            key: ValueKey('field-$label'),
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            decoration: InputDecoration(hintText: hintText),
          ),
        ),
      ],
    );
  }
}

class ActionArea extends StatelessWidget {
  const ActionArea({
    super.key,
    this.primaryLabel,
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.tertiaryLabel,
    this.onTertiary,
  });

  final String? primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final String? tertiaryLabel;
  final VoidCallback? onTertiary;

  @override
  Widget build(BuildContext context) {
    final secondaryButton = secondaryLabel != null && onSecondary != null
        ? OutlinedButton(
            key: ValueKey('secondary-$secondaryLabel'),
            onPressed: onSecondary,
            child: Text(secondaryLabel!, textAlign: TextAlign.center),
          )
        : null;
    final primaryButton = primaryLabel != null && onPrimary != null
        ? ElevatedButton(
            key: ValueKey('primary-$primaryLabel'),
            onPressed: onPrimary,
            child: Text(primaryLabel!, textAlign: TextAlign.center),
          )
        : null;
    final tertiaryButton = tertiaryLabel != null && onTertiary != null
        ? TextButton(
            key: ValueKey('tertiary-$tertiaryLabel'),
            onPressed: onTertiary,
            child: Text(tertiaryLabel!, textAlign: TextAlign.center),
          )
        : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (primaryButton == null &&
            secondaryButton == null &&
            tertiaryButton == null) {
          return const SizedBox.shrink();
        }

        if (constraints.maxWidth >= 390 &&
            primaryButton != null &&
            secondaryButton != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(child: secondaryButton),
                  const SizedBox(width: 10),
                  Expanded(child: primaryButton),
                ],
              ),
              if (tertiaryButton != null) ...[
                const SizedBox(height: 8),
                tertiaryButton,
              ],
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (primaryButton != null) primaryButton,
            if (primaryButton != null && secondaryButton != null)
              const SizedBox(height: 10),
            if (secondaryButton != null) secondaryButton,
            if ((primaryButton != null || secondaryButton != null) &&
                tertiaryButton != null)
              const SizedBox(height: 6),
            if (tertiaryButton != null) tertiaryButton,
          ],
        );
      },
    );
  }
}

class PositiveFeedback extends StatelessWidget {
  const PositiveFeedback({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: BizPulseDesignSystem.greenSoft,
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.radius),
        border: Border.all(
          color: BizPulseDesignSystem.progressGreen.withOpacity(0.35),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            size: 18,
            color: BizPulseDesignSystem.progressGreen,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: BizPulseDesignSystem.bizBlack,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class WarningFeedback extends StatelessWidget {
  const WarningFeedback({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFE02424);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.radius),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_rounded, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: color,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class TermsAcceptanceTile extends StatelessWidget {
  const TermsAcceptanceTile({
    super.key,
    required this.accepted,
    required this.onChanged,
  });

  final bool accepted;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      checked: accepted,
      label: 'Acceptation des conditions',
      child: Material(
  color: BizPulseDesignSystem.elevatedSurface(context),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(BizPulseDesignSystem.radius),
    side: BorderSide(
      color: BizPulseDesignSystem.outlineColor(context),
    ),
  ),
  sed -i '2171,2176c\
      child: Material(\
        color: BizPulseDesignSystem.elevatedSurface(context),\
        shape: RoundedRectangleBorder(\
          borderRadius: BorderRadius.circular(BizPulseDesignSystem.radius),\
          side: BorderSide(\
            color: BizPulseDesignSystem.outlineColor(context),\
          ),\
        ),\
        clipBehavior: Clip.antiAlias,' lib/src/onboarding/portal_widgets.dart

dart format lib/src/onboarding/portal_widgets.dart
flutter test test/player_onboarding_flow_test.dart
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          title: Text(
            'J’accepte les conditions de participation.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}

class LearningGoalCard extends StatelessWidget {
  const LearningGoalCard({
    super.key,
    required this.goal,
    required this.selected,
    required this.onTap,
  });

  final LearningGoal goal;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _SelectableTile(
      key: ValueKey('goal-${goal.id}'),
      selected: selected,
      color: goal.color,
      onTap: onTap,
      icon: goal.icon,
      title: goal.title,
      subtitle: goal.shortDescription,
    );
  }
}

class ExperienceLevelTile extends StatelessWidget {
  const ExperienceLevelTile({
    super.key,
    required this.experience,
    required this.selected,
    required this.onTap,
  });

  final PlayerExperienceLevel experience;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _SelectableTile(
      key: ValueKey('experience-${experience.id}'),
      selected: selected,
      color: BizPulseDesignSystem.trustBlue,
      onTap: onTap,
      icon: experience.icon,
      title: experience.label,
      subtitle: experience.shortDescription,
    );
  }
}

class ProductFamilyVisualCard extends StatelessWidget {
  const ProductFamilyVisualCard({
    super.key,
    required this.family,
    required this.selected,
    required this.onTap,
  });

  final ProductFamily family;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: '${family.name}, ${family.productLine}',
      child: InkWell(
        key: ValueKey('product-${family.id}'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.cardRadius),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: selected
                ? family.color.withOpacity(0.10)
                : BizPulseDesignSystem.elevatedSurface(context),
            borderRadius:
                BorderRadius.circular(BizPulseDesignSystem.cardRadius),
            border: Border.all(
              color: selected
                  ? family.color
                  : BizPulseDesignSystem.outlineColor(context),
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductVisualBadge(
                kind: family.visualKind,
                color: family.color,
                accentColor: family.accentColor,
                selected: selected,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            family.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        IconButton(
                          key: ValueKey('product-info-${family.id}'),
                          tooltip: 'Informations ${family.productLine}',
                          onPressed: () => showProductInfoSheet(
                            context,
                            family,
                          ),
                          icon: const Icon(Icons.info_outline_rounded),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      family.productLine,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      family.shortDescription,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 9),
                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        for (final usage in family.usages)
                          MiniChip(
                            label: usage,
                            color: family.accentColor,
                            icon: Icons.check_rounded,
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        for (final kpi in family.kpis)
                          MiniChip(label: kpi, color: family.color),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: selected
                    ? BizPulseDesignSystem.progressGreen
                    : Theme.of(context).textTheme.bodyMedium?.color,
                size: 21,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showProductInfoSheet(BuildContext context, ProductFamily family) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ProductVisualBadge(
                    kind: family.visualKind,
                    color: family.color,
                    accentColor: family.accentColor,
                    selected: true,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          family.productLine,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          family.shortDescription,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text('Usages principaux',
                  style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final usage in family.usages)
                    MiniChip(
                      label: usage,
                      color: family.accentColor,
                      icon: Icons.check_rounded,
                    ),
                ],
              ),
              const SizedBox(height: 14),
              Text('KPI à surveiller',
                  style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final kpi in family.kpis)
                    MiniChip(label: kpi, color: family.color),
                ],
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fermer'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class ProductVisualBadge extends StatelessWidget {
  const ProductVisualBadge({
    super.key,
    required this.kind,
    required this.color,
    required this.accentColor,
    required this.selected,
  });

  final ProductVisualKind kind;
  final Color color;
  final Color accentColor;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: 72,
      height: 66,
      decoration: BoxDecoration(
        color: selected ? color.withOpacity(0.16) : color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(selected ? 0.34 : 0.18)),
      ),
      child: CustomPaint(
        painter: _ProductVisualPainter(
          kind: kind,
          color: color,
          accentColor: accentColor,
          isDark: Theme.of(context).brightness == Brightness.dark,
        ),
      ),
    );
  }
}

class _ProductVisualPainter extends CustomPainter {
  const _ProductVisualPainter({
    required this.kind,
    required this.color,
    required this.accentColor,
    required this.isDark,
  });

  final ProductVisualKind kind;
  final Color color;
  final Color accentColor;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final main = Paint()..color = color;
    final accent = Paint()..color = accentColor;
    final ink = Paint()
      ..color = isDark ? Colors.white : BizPulseDesignSystem.bizBlack
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final fill = Paint()
      ..color = Colors.white.withOpacity(isDark ? 0.10 : 0.82);

    canvas.drawCircle(
      Offset(size.width * 0.78, size.height * 0.22),
      size.height * 0.12,
      accent..color = accent.color.withOpacity(0.70),
    );

    switch (kind) {
      case ProductVisualKind.smartChair:
        _paintChair(canvas, size, main, accent, ink, fill);
        break;
      case ProductVisualKind.professionalRobot:
        _paintRobot(canvas, size, main, accent, ink, fill);
        break;
      case ProductVisualKind.smartDrone:
        _paintDrone(canvas, size, main, accent, ink, fill);
        break;
    }
  }

  void _paintChair(
    Canvas canvas,
    Size size,
    Paint main,
    Paint accent,
    Paint ink,
    Paint fill,
  ) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.30,
          size.height * 0.18,
          size.width * 0.34,
          size.height * 0.34,
        ),
        const Radius.circular(10),
      ),
      fill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.25,
          size.height * 0.50,
          size.width * 0.44,
          size.height * 0.16,
        ),
        const Radius.circular(10),
      ),
      main,
    );
    canvas.drawLine(
      Offset(size.width * 0.47, size.height * 0.66),
      Offset(size.width * 0.47, size.height * 0.86),
      ink,
    );
    canvas.drawLine(
      Offset(size.width * 0.28, size.height * 0.86),
      Offset(size.width * 0.66, size.height * 0.86),
      ink,
    );
    canvas.drawCircle(Offset(size.width * 0.67, size.height * 0.36), 4, accent);
  }

  void _paintRobot(
    Canvas canvas,
    Size size,
    Paint main,
    Paint accent,
    Paint ink,
    Paint fill,
  ) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.28,
          size.height * 0.18,
          size.width * 0.44,
          size.height * 0.40,
        ),
        const Radius.circular(12),
      ),
      main,
    );
    canvas.drawCircle(Offset(size.width * 0.42, size.height * 0.36), 4, fill);
    canvas.drawCircle(Offset(size.width * 0.58, size.height * 0.36), 4, fill);
    canvas.drawLine(
      Offset(size.width * 0.50, size.height * 0.58),
      Offset(size.width * 0.50, size.height * 0.78),
      ink,
    );
    canvas.drawLine(
      Offset(size.width * 0.34, size.height * 0.72),
      Offset(size.width * 0.66, size.height * 0.72),
      ink,
    );
    canvas.drawCircle(Offset(size.width * 0.50, size.height * 0.12), 4, accent);
  }

  void _paintDrone(
    Canvas canvas,
    Size size,
    Paint main,
    Paint accent,
    Paint ink,
    Paint fill,
  ) {
    final center = Offset(size.width * 0.50, size.height * 0.48);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: center,
          width: size.width * 0.30,
          height: size.height * 0.18,
        ),
        const Radius.circular(10),
      ),
      main,
    );
    for (final point in [
      Offset(size.width * 0.23, size.height * 0.28),
      Offset(size.width * 0.77, size.height * 0.28),
      Offset(size.width * 0.23, size.height * 0.68),
      Offset(size.width * 0.77, size.height * 0.68),
    ]) {
      canvas.drawLine(center, point, ink);
      canvas.drawCircle(point, size.height * 0.10, fill);
      canvas.drawCircle(point, size.height * 0.055, accent);
    }
  }

  @override
  bool shouldRepaint(covariant _ProductVisualPainter oldDelegate) {
    return oldDelegate.kind != kind ||
        oldDelegate.color != color ||
        oldDelegate.accentColor != accentColor ||
        oldDelegate.isDark != isDark;
  }
}

class _SelectableTile extends StatelessWidget {
  const _SelectableTile({
    super.key,
    required this.selected,
    required this.color,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final bool selected;
  final Color color;
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.cardRadius),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: selected
                ? color.withOpacity(0.10)
                : BizPulseDesignSystem.elevatedSurface(context),
            borderRadius:
                BorderRadius.circular(BizPulseDesignSystem.cardRadius),
            border: Border.all(
              color:
                  selected ? color : BizPulseDesignSystem.outlineColor(context),
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: selected ? color : color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: selected ? Colors.white : color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Icon(
                          selected
                              ? Icons.check_circle_rounded
                              : Icons.circle_outlined,
                          color: selected
                              ? BizPulseDesignSystem.progressGreen
                              : Theme.of(context).textTheme.bodyMedium?.color,
                          size: 19,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(subtitle,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MiniChip extends StatelessWidget {
  const MiniChip({
    super.key,
    required this.label,
    required this.color,
    this.icon,
  });

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class InsightCard extends StatelessWidget {
  const InsightCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.09),
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.cardRadius),
        border: Border.all(color: color.withOpacity(0.18)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 21),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CompanyPreviewCard extends StatelessWidget {
  const CompanyPreviewCard({
    super.key,
    required this.companyName,
    required this.slogan,
  });

  final String companyName;
  final String slogan;

  @override
  Widget build(BuildContext context) {
    final visibleName =
        companyName.trim().isEmpty ? 'Votre entreprise' : companyName.trim();
    final visibleSlogan =
        slogan.trim().isEmpty ? 'Votre promesse stratégique.' : slogan.trim();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: BizPulseDesignSystem.accentGradient(context),
        ),
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.cardRadius),
        border: Border.all(color: BizPulseDesignSystem.outlineColor(context)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: BizPulseDesignSystem.bizBlack,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.apartment_rounded,
              color: BizPulseDesignSystem.bizGold,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(visibleName,
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(
                  visibleSlogan,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                const MiniChip(
                  label: 'Carte entreprise',
                  color: BizPulseDesignSystem.trustBlue,
                  icon: Icons.badge_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductHeroCard extends StatelessWidget {
  const ProductHeroCard({super.key, required this.family});

  final ProductFamily family;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: family.color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.cardRadius),
        border: Border.all(color: family.color.withOpacity(0.18)),
      ),
      child: Row(
        children: [
          ProductVisualBadge(
            kind: family.visualKind,
            color: family.color,
            accentColor: family.accentColor,
            selected: true,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  family.productLine,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  family.shortDescription,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final usage in family.usages)
                      MiniChip(
                        label: usage,
                        color: family.accentColor,
                        icon: Icons.check_rounded,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MissionBlock extends StatelessWidget {
  const MissionBlock({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.09),
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.cardRadius),
        border: Border.all(color: color.withOpacity(0.20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 4),
                Text(value, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GuidedVisitSpotlightCard extends StatelessWidget {
  const GuidedVisitSpotlightCard({
    super.key,
    required this.step,
    required this.index,
    required this.total,
  });

  final GuidedVisitSpotlight step;
  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: step.color.withOpacity(0.09),
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.cardRadius),
        border: Border.all(color: step.color.withOpacity(0.20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: step.color,
                foregroundColor: Colors.white,
                child: Text('${index + 1}'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  step.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Icon(step.icon, color: step.color),
            ],
          ),
          const SizedBox(height: 10),
          Text(step.shortDescription,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: (index + 1) / total,
              minHeight: 7,
              backgroundColor: step.color.withOpacity(0.12),
              color: step.color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Repère ${index + 1} sur $total',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}

class TourStepTile extends StatelessWidget {
  const TourStepTile({
    super.key,
    required this.number,
    required this.title,
    required this.icon,
    required this.color,
  });

  final String number;
  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: color.withOpacity(0.09),
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.radius),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: color,
            foregroundColor: Colors.white,
            child: Text(number, style: const TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: 9),
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.labelLarge),
          ),
        ],
      ),
    );
  }
}

class DashboardMetricCard extends StatelessWidget {
  const DashboardMetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.progress,
  });

  final String label;
  final String value;
  final Color color;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: BizPulseDesignSystem.elevatedSurface(context),
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.cardRadius),
        border: Border.all(color: BizPulseDesignSystem.outlineColor(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 6),
          Text(value, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: color.withOpacity(0.09),
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardHeaderCard extends StatelessWidget {
  const DashboardHeaderCard({
    super.key,
    required this.companyName,
    required this.productLine,
    required this.data,
  });

  final String companyName;
  final String productLine;
  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: BizPulseDesignSystem.elevatedSurface(context),
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.cardRadius),
        border: Border.all(color: BizPulseDesignSystem.outlineColor(context)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: BizPulseDesignSystem.trustBlue.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.apartment_rounded,
              color: BizPulseDesignSystem.trustBlue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(companyName,
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(productLine,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    MiniChip(
                      label: data.turnLabel,
                      color: BizPulseDesignSystem.trustBlue,
                      icon: Icons.flag_rounded,
                    ),
                    MiniChip(
                      label: data.timerLabel,
                      color: BizPulseDesignSystem.bizGold,
                      icon: Icons.schedule_rounded,
                    ),
                    MiniChip(
                      label: data.zoneLabel,
                      color: BizPulseDesignSystem.progressGreen,
                      icon: Icons.grid_view_rounded,
                    ),
                    MiniChip(
                      label: data.localLabel,
                      color: BizPulseDesignSystem.turquoise,
                      icon: Icons.meeting_room_rounded,
                    ),
                    MiniChip(
                      label: data.statusLabel,
                      color: BizPulseDesignSystem.innovationViolet,
                      icon: Icons.psychology_alt_rounded,
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Notifications prioritaires',
            onPressed: () => showDashboardActionSheet(
              context,
              title: 'Notifications prioritaires',
              message:
                  'Une alerte stock et une alerte trésorerie méritent une lecture avant vos prochaines décisions.',
              icon: Icons.notifications_active_rounded,
            ),
            icon: const Icon(Icons.notifications_active_rounded),
          ),
        ],
      ),
    );
  }
}

class DashboardViewSelector extends StatelessWidget {
  const DashboardViewSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: BizPulseDesignSystem.trustBlue.withOpacity(0.12),
              borderRadius: BorderRadius.circular(BizPulseDesignSystem.radius),
              border: Border.all(
                color: BizPulseDesignSystem.trustBlue.withOpacity(0.28),
              ),
            ),
            child: Text(
              'Vue simple',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: BizPulseDesignSystem.trustBlue,
                  ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => showDashboardActionSheet(
              context,
              title: 'Vue experte verrouillée',
              message:
                  'La vue experte reste visible pour préparer la suite, mais elle sera ouverte après validation du parcours initial.',
              icon: Icons.lock_rounded,
            ),
            icon: const Icon(Icons.lock_rounded, size: 17),
            label: const Text('Vue experte'),
          ),
        ),
      ],
    );
  }
}

class DashboardKpiGrid extends StatelessWidget {
  const DashboardKpiGrid({
    super.key,
    required this.kpis,
    this.compact = false,
  });

  final List<DashboardKpi> kpis;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = compact
            ? constraints.maxWidth >= 760
                ? 4
                : 2
            : constraints.maxWidth >= 620
                ? 2
                : constraints.maxWidth >= 480
                    ? 2
                    : 1;
        const spacing = 10.0;
        final width =
            (constraints.maxWidth - (columns - 1) * spacing) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final kpi in kpis)
              SizedBox(
                width: width,
                child: DashboardKpiCard(
                  key: ValueKey('kpi-card-${kpi.id}'),
                  kpi: kpi,
                  compact: compact,
                ),
              ),
          ],
        );
      },
    );
  }
}

class DashboardKpiCard extends StatelessWidget {
  const DashboardKpiCard({
    super.key,
    required this.kpi,
    this.compact = false,
  });

  final DashboardKpi kpi;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final valueStyle = compact
        ? Theme.of(context).textTheme.titleMedium
        : Theme.of(context).textTheme.titleLarge;
    final iconSize = compact ? 32.0 : 38.0;
    final infoButtonSize = compact ? 40.0 : 40.0;
    final iconBox = Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        color: kpi.color.withOpacity(0.11),
        borderRadius: BorderRadius.circular(compact ? 11 : 13),
      ),
      child: Icon(kpi.icon, color: kpi.color, size: compact ? 18 : 20),
    );
    final infoButton = SizedBox(
      width: infoButtonSize,
      height: infoButtonSize,
      child: IconButton(
        key: ValueKey('kpi-info-${kpi.id}'),
        tooltip: 'Expliquer ${kpi.label}',
        onPressed: () => showKpiHelpSheet(context, kpi),
        style: IconButton.styleFrom(
          minimumSize: Size.square(infoButtonSize),
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        icon: Icon(
          Icons.info_outline_rounded,
          size: compact ? 18 : 20,
        ),
      ),
    );

    return Container(
      padding: EdgeInsets.all(compact ? 10 : 12),
      decoration: BoxDecoration(
        color: BizPulseDesignSystem.elevatedSurface(context),
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.cardRadius),
        border: Border.all(color: BizPulseDesignSystem.outlineColor(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (compact) ...[
            Row(
              children: [
                iconBox,
                const Spacer(),
                infoButton,
              ],
            ),
            const SizedBox(height: 5),
            Text(
              kpi.label,
              style: Theme.of(context).textTheme.labelLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ] else
            Row(
              children: [
                iconBox,
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    kpi.label,
                    style: Theme.of(context).textTheme.labelLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                infoButton,
              ],
            ),
          SizedBox(height: compact ? 6 : 8),
          if (kpi.isActive)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    kpi.value,
                    style: valueStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (kpi.unit.isNotEmpty) ...[
                  const SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      kpi.unit,
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            )
          else
            Text(
              kpi.displayValue,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: kpi.color,
                  ),
              maxLines: compact ? 2 : 3,
              overflow: TextOverflow.ellipsis,
            ),
          SizedBox(height: compact ? 7 : 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              if (kpi.isActive && !compact)
                MiniChip(
                  label: kpi.evolution,
                  color: kpi.color,
                  icon: Icons.trending_up_rounded,
                ),
              MiniChip(
                label: kpi.stateLabel,
                color: kpi.isActive
                    ? BizPulseDesignSystem.progressGreen
                    : kpi.color,
                icon: kpi.isActive
                    ? Icons.verified_rounded
                    : kpi.applicability.icon,
              ),
            ],
          ),
          if (!compact || kpi.isActive) ...[
            SizedBox(height: compact ? 7 : 9),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: kpi.isActive ? kpi.progress : 0,
                minHeight: compact ? 5 : 6,
                backgroundColor: kpi.color.withOpacity(0.10),
                color: kpi.color,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class DashboardNextActions extends StatelessWidget {
  const DashboardNextActions({
    super.key,
    required this.actions,
  });

  final List<DashboardNextAction> actions;

  @override
  Widget build(BuildContext context) {
    return _DashboardSection(
      title: 'Que faire maintenant ?',
      child: Column(
        children: [
          for (final action in actions) ...[
            _DashboardActionTile(
              title: action.title,
              subtitle: action.subtitle,
              icon: action.icon,
              color: action.color,
            ),
            if (action != actions.last) const SizedBox(height: 8),
          ],
          const SizedBox(height: 8),
          const _DashboardTechnicalNote(),
        ],
      ),
    );
  }
}

class DashboardQuickAction extends StatelessWidget {
  const DashboardQuickAction({
    super.key,
    required this.action,
  });

  final DashboardNextAction action;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: action.color.withOpacity(0.10),
      borderRadius: BorderRadius.circular(BizPulseDesignSystem.radius),
      child: InkWell(
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.radius),
        onTap: () => showDashboardActionSheet(
          context,
          title: action.title,
          message: action.subtitle,
          icon: action.icon,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
          child: Row(
            children: [
              Icon(action.icon, color: action.color, size: 19),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Action prioritaire',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      action.title,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class PriorityAlerts extends StatelessWidget {
  const PriorityAlerts({
    super.key,
    required this.alerts,
  });

  final List<DashboardAlert> alerts;

  @override
  Widget build(BuildContext context) {
    return _DashboardSection(
      title: 'Alertes prioritaires',
      child: Column(
        children: [
          for (final alert in alerts) ...[
            _DashboardAlertTile(
              title: alert.title,
              subtitle: alert.subtitle,
              icon: alert.icon,
              color: alert.color,
            ),
            if (alert != alerts.last) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class DashboardSituationFacts extends StatelessWidget {
  const DashboardSituationFacts({
    super.key,
    required this.facts,
  });

  final List<DashboardFact> facts;

  @override
  Widget build(BuildContext context) {
    return _DashboardSection(
      title: 'Situation de départ',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 620 ? 4 : 2;
          const spacing = 8.0;
          final width =
              (constraints.maxWidth - (columns - 1) * spacing) / columns;

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              for (final fact in facts)
                SizedBox(
                  width: width,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: fact.color.withOpacity(0.08),
                      borderRadius:
                          BorderRadius.circular(BizPulseDesignSystem.radius),
                      border: Border.all(color: fact.color.withOpacity(0.16)),
                    ),
                    child: Row(
                      children: [
                        Icon(fact.icon, color: fact.color, size: 17),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${fact.label} : ',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                fact.value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _DashboardTechnicalNote extends StatelessWidget {
  const _DashboardTechnicalNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: BizPulseDesignSystem.turquoise.withOpacity(0.08),
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.radius),
        border: Border.all(
          color: BizPulseDesignSystem.turquoise.withOpacity(0.18),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: BizPulseDesignSystem.turquoise,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Actions provisoires : elles seront générées selon la mission, '
              'les décisions manquantes, les alertes, la trésorerie et les '
              'directions accessibles.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class LockedDirectionsAccess extends StatelessWidget {
  const LockedDirectionsAccess({super.key});

  @override
  Widget build(BuildContext context) {
    const directions = [
      ('Marketing', Icons.campaign_rounded, BizPulseDesignSystem.trustBlue),
      (
        'Production',
        Icons.precision_manufacturing_rounded,
        BizPulseDesignSystem.turquoise
      ),
      (
        'Finance',
        Icons.account_balance_rounded,
        BizPulseDesignSystem.progressGreen
      ),
    ];

    return _DashboardSection(
      title: 'Accès aux directions',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final direction in directions)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              decoration: BoxDecoration(
                color: direction.$3.withOpacity(0.08),
                borderRadius:
                    BorderRadius.circular(BizPulseDesignSystem.radius),
                border: Border.all(color: direction.$3.withOpacity(0.18)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(direction.$2, color: direction.$3, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    direction.$1,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.lock_rounded,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    size: 15,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _DashboardSection extends StatelessWidget {
  const _DashboardSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _DashboardActionTile extends StatelessWidget {
  const _DashboardActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(BizPulseDesignSystem.radius),
      child: InkWell(
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.radius),
        onTap: () => showDashboardActionSheet(
          context,
          title: title,
          message: subtitle,
          icon: icon,
        ),
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Row(
            children: [
              Icon(icon, color: color, size: 21),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardAlertTile extends StatelessWidget {
  const _DashboardAlertTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(BizPulseDesignSystem.radius),
        border: Border.all(color: color.withOpacity(0.18)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showDashboardActionSheet(
  BuildContext context, {
  required String title,
  required String message,
  required IconData icon,
}) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: BizPulseDesignSystem.trustBlue),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(title,
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(message, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 14),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fermer'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showKpiHelpSheet(BuildContext context, DashboardKpi kpi) {
  final isTablet = MediaQuery.sizeOf(context).width >= 760;

  if (isTablet) {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Fermer l’aide KPI',
      barrierColor: Colors.black.withOpacity(0.22),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: SafeArea(
            child: Material(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(24),
              ),
              child: SizedBox(
                width: 430,
                child: KpiHelpContent(kpi: kpi),
              ),
            ),
          ),
        );
      },
    );
    return;
  }

  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) => KpiHelpContent(kpi: kpi),
  );
}

class KpiHelpContent extends StatelessWidget {
  const KpiHelpContent({super.key, required this.kpi});

  final DashboardKpi kpi;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: kpi.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(kpi.icon, color: kpi.color),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Comprendre : ${kpi.label}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Fermer',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (!kpi.isActive)
                _KpiHelpSection(
                  title: 'Disponibilité',
                  text:
                      '${kpi.applicability.label}. ${kpi.availabilityLabel ?? ''}'
                          .trim(),
                ),
              _KpiHelpSection(title: 'Définition', text: kpi.definition),
              _KpiHelpSection(
                  title: 'Pourquoi c’est important', text: kpi.importance),
              _KpiHelpSection(
                  title: 'Comment l’interpréter', text: kpi.interpretation),
              _KpiHelpSection(
                title: 'Facteurs qui influencent',
                text: kpi.factors.join(', '),
              ),
              _KpiHelpSection(
                  title: 'KPI liés', text: kpi.relatedKpis.join(', ')),
              _KpiHelpSection(
                  title: 'Erreur fréquente', text: kpi.commonMistake),
              _KpiHelpSection(title: 'Exemple', text: kpi.example),
              _KpiHelpSection(
                title: 'Question de réflexion',
                text: kpi.reflectionQuestion,
              ),
              const SizedBox(height: 8),
              const PositiveFeedback(
                message:
                    'Le Coach Biz explique les signaux, sans révéler la décision optimale.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KpiHelpSection extends StatelessWidget {
  const _KpiHelpSection({required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 4),
          Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _AmbientShapesPainter extends CustomPainter {
  const _AmbientShapesPainter({
    required this.brightness,
    required this.animationValue,
  });

  final Brightness brightness;
  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final isDark = brightness == Brightness.dark;
    final colors = isDark
        ? [
            BizPulseDesignSystem.trustBlue.withOpacity(0.08),
            BizPulseDesignSystem.bizGold.withOpacity(0.07),
            BizPulseDesignSystem.turquoise.withOpacity(0.07),
          ]
        : [
            BizPulseDesignSystem.trustBlue.withOpacity(0.07),
            BizPulseDesignSystem.bizGold.withOpacity(0.08),
            BizPulseDesignSystem.innovationViolet.withOpacity(0.06),
          ];

    final offsets = [
      Offset(size.width * (0.12 + animationValue * 0.02), size.height * 0.14),
      Offset(size.width * 0.88, size.height * (0.20 + animationValue * 0.03)),
      Offset(size.width * 0.18, size.height * 0.86),
    ];

    for (var i = 0; i < offsets.length; i += 1) {
      canvas.drawCircle(
        offsets[i],
        size.shortestSide * (0.14 - i * 0.020),
        Paint()..color = colors[i],
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AmbientShapesPainter oldDelegate) {
    return oldDelegate.brightness != brightness ||
        oldDelegate.animationValue != animationValue;
  }
}
