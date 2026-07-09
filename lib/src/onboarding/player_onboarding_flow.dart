import 'package:flutter/material.dart';

import '../design_system/biz_pulse_design_system.dart';
import 'onboarding_models.dart';
import 'portal_widgets.dart';

class PlayerOnboardingFlow extends StatefulWidget {
  const PlayerOnboardingFlow({
    super.key,
    required this.initialStep,
    required this.dashboardData,
    required this.themeMode,
    required this.onToggleTheme,
  });

  final PlayerOnboardingStep initialStep;
  final DashboardData dashboardData;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  @override
  State<PlayerOnboardingFlow> createState() => _PlayerOnboardingFlowState();
}

class _PlayerOnboardingFlowState extends State<PlayerOnboardingFlow> {
  late PlayerOnboardingStep _step;
  late PlayerOnboardingState _flowState;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _companyNameController;
  late TextEditingController _companyActivityController;
  late TextEditingController _companySloganController;

  String? _warning;
  String? _confirmation;
  bool _acceptedTerms = true;
  int _visitIndex = 0;

  @override
  void initState() {
    super.initState();
    _step = widget.initialStep;
    _flowState = PlayerOnboardingState.initial;
    _firstNameController = TextEditingController(text: _flowState.firstName);
    _lastNameController = TextEditingController(text: _flowState.lastName);
    _emailController = TextEditingController(text: _flowState.email);
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _companyNameController =
        TextEditingController(text: _flowState.companyName);
    _companyActivityController =
        TextEditingController(text: _flowState.companyActivity);
    _companySloganController =
        TextEditingController(text: _flowState.companySlogan);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _companyNameController.dispose();
    _companyActivityController.dispose();
    _companySloganController.dispose();
    super.dispose();
  }

  void _goTo(PlayerOnboardingStep nextStep, {String? confirmation}) {
    setState(() {
      _step = nextStep;
      _warning = null;
      _confirmation = confirmation;
    });
  }

  void _submitAccount() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if ([firstName, email, password, confirmPassword]
        .any((value) => value.trim().isEmpty)) {
      setState(() {
        _warning = 'Complétez les champs obligatoires.';
        _confirmation = null;
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _warning = 'Les mots de passe ne correspondent pas.';
        _confirmation = null;
      });
      return;
    }

    if (!_acceptedTerms) {
      setState(() {
        _warning = 'Acceptez les conditions pour créer le compte.';
        _confirmation = null;
      });
      return;
    }

    setState(() {
      _flowState = _flowState.copyWith(
        firstName: firstName,
        lastName: lastName,
        email: email,
      );
      _step = PlayerOnboardingStep.welcome;
      _warning = null;
      _confirmation = 'Compte créé. Session ouverte automatiquement.';
    });
  }

  void _submitLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _warning = 'Email et mot de passe sont obligatoires.';
        _confirmation = null;
      });
      return;
    }

    setState(() {
      _flowState = _flowState.copyWith(email: email);
      _step = PlayerOnboardingStep.welcome;
      _warning = null;
      _confirmation = 'Connexion confirmée.';
    });
  }

  void _selectLearningGoal(LearningGoal goal) {
    setState(() {
      _flowState = _flowState.copyWith(learningGoal: goal);
      _warning = null;
      _confirmation = 'Objectif sélectionné.';
    });
  }

  void _selectExperience(PlayerExperienceLevel experienceLevel) {
    setState(() {
      _flowState = _flowState.copyWith(experienceLevel: experienceLevel);
      _warning = null;
      _confirmation = 'Niveau d’expérience enregistré.';
    });
  }

  void _toggleTerms(bool? value) {
    setState(() {
      _acceptedTerms = value ?? false;
      _warning = null;
    });
  }

  void _submitCompany() {
    final companyName = _companyNameController.text.trim();
    final activity = _companyActivityController.text.trim();
    final slogan = _companySloganController.text.trim();

    if (companyName.isEmpty) {
      setState(() {
        _warning = 'Le nom de l’entreprise est obligatoire.';
        _confirmation = null;
      });
      return;
    }

    setState(() {
      _flowState = _flowState.copyWith(
        companyName: companyName,
        companyActivity: activity,
        companySlogan: slogan,
      );
      _step = PlayerOnboardingStep.productFamily;
      _warning = null;
      _confirmation = 'Entreprise créée.';
    });
  }

  void _nextVisitStep() {
    if (_visitIndex >= guidedVisitSteps.length - 1) {
      _goTo(
        PlayerOnboardingStep.dashboard,
        confirmation: 'Visite terminée. Tour 1 prêt.',
      );
      return;
    }

    setState(() {
      _visitIndex += 1;
      _warning = null;
      _confirmation = null;
    });
  }

  void _previousVisitStep() {
    if (_visitIndex == 0) {
      _goTo(PlayerOnboardingStep.tourGuide);
      return;
    }

    setState(() {
      _visitIndex -= 1;
      _warning = null;
      _confirmation = null;
    });
  }

  void _skipVisit() {
    _goTo(
      PlayerOnboardingStep.dashboard,
      confirmation: 'Visite passée. Vous pourrez la revoir plus tard.',
    );
  }

  void _selectProduct(ProductFamily family) {
    setState(() {
      _flowState = _flowState.copyWith(productFamily: family);
      _warning = null;
      _confirmation = '${family.name} sélectionné.';
    });
  }

  void _showProductComparison() {
    showDashboardActionSheet(
      context,
      title: 'Comparer les produits',
      message:
          'Comparez les promesses, les KPI à surveiller et le niveau de risque. Aucun produit n’est présenté comme la réponse optimale.',
      icon: Icons.compare_arrows_rounded,
    );
  }

  void _showMissionBriefing() {
    showDashboardActionSheet(
      context,
      title: 'Briefing du Tour 1',
      message:
          'Votre objectif est de construire une promesse cohérente, puis d’observer les premiers signaux avant de décider.',
      icon: Icons.record_voice_over_rounded,
    );
  }

  void _showWelcomeMessage() {
    showDashboardActionSheet(
      context,
      title: 'Message de bienvenue',
      message:
          'Vous allez créer une entreprise, choisir un produit, lire une mission simple puis découvrir votre premier dashboard.',
      icon: Icons.volume_up_rounded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlayerPortalShell(
      step: _step,
      themeMode: widget.themeMode,
      onToggleTheme: widget.onToggleTheme,
      coachTitle: 'COACH BIZ',
      coachMessage: _assistantMessage(_step),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 260),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        child: KeyedSubtree(
          key: ValueKey(_step),
          child: _buildStep(),
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case PlayerOnboardingStep.createAccount:
        return _CreateAccountStep(
          firstNameController: _firstNameController,
          lastNameController: _lastNameController,
          emailController: _emailController,
          passwordController: _passwordController,
          confirmPasswordController: _confirmPasswordController,
          warning: _warning,
          acceptedTerms: _acceptedTerms,
          onTermsChanged: _toggleTerms,
          onLogin: () => _goTo(PlayerOnboardingStep.login),
          onSubmit: _submitAccount,
        );
      case PlayerOnboardingStep.login:
        return _LoginStep(
          emailController: _emailController,
          passwordController: _passwordController,
          warning: _warning,
          confirmation: _confirmation,
          onCreateAccount: () => _goTo(PlayerOnboardingStep.createAccount),
          onSubmit: _submitLogin,
        );
      case PlayerOnboardingStep.welcome:
        return _WelcomeStep(
          confirmation: _confirmation,
          onStart: () => _goTo(PlayerOnboardingStep.learningGoal),
          onTourInfo: _showWelcomeMessage,
        );
      case PlayerOnboardingStep.learningGoal:
        return _LearningGoalStep(
          selectedGoal: _flowState.learningGoal,
          selectedExperience: _flowState.experienceLevel,
          confirmation: _confirmation,
          onBack: () => _goTo(PlayerOnboardingStep.welcome),
          onSelect: _selectLearningGoal,
          onSelectExperience: _selectExperience,
          onSubmit: () => _goTo(PlayerOnboardingStep.company),
        );
      case PlayerOnboardingStep.company:
        return _CompanyStep(
          companyNameController: _companyNameController,
          activityController: _companyActivityController,
          sloganController: _companySloganController,
          warning: _warning,
          state: _flowState,
          onBack: () => _goTo(PlayerOnboardingStep.learningGoal),
          onSubmit: _submitCompany,
        );
      case PlayerOnboardingStep.productFamily:
        return _ProductFamilyStep(
          selectedFamily: _flowState.productFamily,
          confirmation: _confirmation,
          onBack: () => _goTo(PlayerOnboardingStep.company),
          onSelect: _selectProduct,
          onCompare: _showProductComparison,
          onSubmit: () => _goTo(PlayerOnboardingStep.productConfirm),
        );
      case PlayerOnboardingStep.productConfirm:
        return _ProductConfirmStep(
          state: _flowState,
          onBack: () => _goTo(PlayerOnboardingStep.productFamily),
          onSubmit: () => _goTo(
            PlayerOnboardingStep.firstMission,
            confirmation: 'Produit confirmé pour le Tour 1.',
          ),
        );
      case PlayerOnboardingStep.firstMission:
        return _FirstMissionStep(
          state: _flowState,
          confirmation: _confirmation,
          onBack: () => _goTo(PlayerOnboardingStep.productConfirm),
          onBriefing: _showMissionBriefing,
          onSubmit: () => _goTo(PlayerOnboardingStep.tourGuide),
        );
      case PlayerOnboardingStep.tourGuide:
        return _TourGuideStep(
          onBack: () => _goTo(PlayerOnboardingStep.firstMission),
          onSubmit: () => _goTo(PlayerOnboardingStep.guidedVisit),
        );
      case PlayerOnboardingStep.guidedVisit:
        return _GuidedVisitStep(
          currentIndex: _visitIndex,
          onBack: _previousVisitStep,
          onSkip: _skipVisit,
          onNext: _nextVisitStep,
        );
      case PlayerOnboardingStep.dashboard:
        return _DashboardStep(
          state: _flowState,
          dashboardData: widget.dashboardData,
          confirmation: _confirmation,
          onBack: () => _goTo(PlayerOnboardingStep.guidedVisit),
        );
    }
  }

  String _assistantMessage(PlayerOnboardingStep step) {
    switch (step) {
      case PlayerOnboardingStep.createAccount:
        return 'Créez votre accès joueur. Je vous guiderai ensuite étape par étape.';
      case PlayerOnboardingStep.login:
        return 'Connectez-vous pour retrouver votre parcours. Besoin d’aide ? Vérifiez email et mot de passe.';
      case PlayerOnboardingStep.welcome:
        return 'Vous entrez dans le rôle d’entrepreneur. Appuyez sur commencer pour configurer votre première mission.';
      case PlayerOnboardingStep.learningGoal:
        return 'Choisissez ce que vous voulez travailler en priorité. Aucun choix n’est une solution optimale.';
      case PlayerOnboardingStep.company:
        return 'Donnez un nom à votre entreprise. Court, mémorable, facile à reconnaître.';
      case PlayerOnboardingStep.productFamily:
        return 'Choisissez une famille de produits. Regardez les indicateurs, pas seulement le nom.';
      case PlayerOnboardingStep.productConfirm:
        return 'Vérifiez votre choix. Vous pourrez apprendre à l’ajuster plus tard avec les résultats.';
      case PlayerOnboardingStep.firstMission:
        return 'Votre mission est de créer une promesse cohérente entre produit, marque et vente.';
      case PlayerOnboardingStep.tourGuide:
        return 'Un tour est une boucle simple : observer, décider, confirmer, puis analyser.';
      case PlayerOnboardingStep.guidedVisit:
        return 'La visite montre les zones du cockpit. Elle ne révèle pas les meilleures décisions.';
      case PlayerOnboardingStep.dashboard:
        return 'Ce dashboard est simplifié pour démarrer. Les directions complètes viendront après validation.';
    }
  }
}

class _CreateAccountStep extends StatelessWidget {
  const _CreateAccountStep({
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.warning,
    required this.acceptedTerms,
    required this.onTermsChanged,
    required this.onLogin,
    required this.onSubmit,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String? warning;
  final bool acceptedTerms;
  final ValueChanged<bool?> onTermsChanged;
  final VoidCallback onLogin;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return StageScaffold(
      illustration: StageIllustrationType.account,
      eyebrow: 'Nouveau joueur',
      title: 'Créez votre compte.',
      subtitle: 'Votre aventure entrepreneur commence ici.',
      primaryLabel: 'Créer mon compte',
      onPrimary: onSubmit,
      secondaryLabel: 'J’ai déjà un compte',
      onSecondary: onLogin,
      children: [
        if (warning != null) ...[
          WarningFeedback(message: warning!),
          const SizedBox(height: 12),
        ],
        BizTextField(
          label: 'Prénom ou pseudo',
          controller: firstNameController,
          required: true,
        ),
        const SizedBox(height: 10),
        BizTextField(
          label: 'Email',
          controller: emailController,
          required: true,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 10),
        BizTextField(
          label: 'Mot de passe',
          controller: passwordController,
          required: true,
          obscureText: true,
        ),
        const SizedBox(height: 10),
        BizTextField(
          label: 'Confirmer',
          controller: confirmPasswordController,
          required: true,
          obscureText: true,
        ),
        const SizedBox(height: 10),
        TermsAcceptanceTile(
          accepted: acceptedTerms,
          onChanged: onTermsChanged,
        ),
      ],
    );
  }
}

class _LoginStep extends StatelessWidget {
  const _LoginStep({
    required this.emailController,
    required this.passwordController,
    required this.warning,
    required this.confirmation,
    required this.onCreateAccount,
    required this.onSubmit,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String? warning;
  final String? confirmation;
  final VoidCallback onCreateAccount;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return StageScaffold(
      illustration: StageIllustrationType.login,
      eyebrow: 'Retour au cockpit',
      title: 'Connectez-vous.',
      subtitle: 'Reprenez votre parcours en quelques secondes.',
      confirmation: confirmation,
      primaryLabel: 'Se connecter',
      onPrimary: onSubmit,
      secondaryLabel: 'Créer un compte',
      onSecondary: onCreateAccount,
      children: [
        if (warning != null) ...[
          WarningFeedback(message: warning!),
          const SizedBox(height: 12),
        ],
        BizTextField(
          label: 'Email',
          controller: emailController,
          required: true,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 10),
        BizTextField(
          label: 'Mot de passe',
          controller: passwordController,
          required: true,
          obscureText: true,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text('Mot de passe oublié ?'),
          ),
        ),
      ],
    );
  }
}

class _WelcomeStep extends StatelessWidget {
  const _WelcomeStep({
    required this.confirmation,
    required this.onStart,
    required this.onTourInfo,
  });

  final String? confirmation;
  final VoidCallback onStart;
  final VoidCallback onTourInfo;

  @override
  Widget build(BuildContext context) {
    return StageScaffold(
      illustration: StageIllustrationType.welcome,
      eyebrow: 'Première connexion',
      title: 'Bienvenue, entrepreneur du futur !',
      subtitle:
          'Prenez les commandes, testez vos décisions et développez vos compétences.',
      confirmation: confirmation,
      primaryLabel: 'Commencer l’expérience',
      onPrimary: onStart,
      secondaryLabel: 'Écouter le message',
      onSecondary: onTourInfo,
      children: const [
        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: [
            MiniChip(
              label: 'Décider',
              color: BizPulseDesignSystem.trustBlue,
              icon: Icons.touch_app_rounded,
            ),
            MiniChip(
              label: 'Mesurer',
              color: BizPulseDesignSystem.progressGreen,
              icon: Icons.insights_rounded,
            ),
            MiniChip(
              label: 'Progresser',
              color: BizPulseDesignSystem.innovationViolet,
              icon: Icons.trending_up_rounded,
            ),
          ],
        ),
      ],
    );
  }
}

class _LearningGoalStep extends StatelessWidget {
  const _LearningGoalStep({
    required this.selectedGoal,
    required this.selectedExperience,
    required this.confirmation,
    required this.onBack,
    required this.onSelect,
    required this.onSelectExperience,
    required this.onSubmit,
  });

  final LearningGoal selectedGoal;
  final PlayerExperienceLevel selectedExperience;
  final String? confirmation;
  final VoidCallback onBack;
  final ValueChanged<LearningGoal> onSelect;
  final ValueChanged<PlayerExperienceLevel> onSelectExperience;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return StageScaffold(
      illustration: StageIllustrationType.goal,
      eyebrow: 'Objectif personnel',
      title: 'Que souhaitez-vous développer ?',
      subtitle: 'Choisissez une priorité et votre niveau de départ.',
      confirmation: confirmation,
      primaryLabel: 'Continuer',
      onPrimary: onSubmit,
      secondaryLabel: 'Retour',
      onSecondary: onBack,
      children: [
        for (final goal in learningGoals) ...[
          LearningGoalCard(
            goal: goal,
            selected: goal.id == selectedGoal.id,
            onTap: () => onSelect(goal),
          ),
          const SizedBox(height: 9),
        ],
        const SizedBox(height: 4),
        Text(
          'Avez-vous déjà joué à un business game ?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        for (final experience in playerExperienceLevels) ...[
          ExperienceLevelTile(
            experience: experience,
            selected: experience.id == selectedExperience.id,
            onTap: () => onSelectExperience(experience),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _CompanyStep extends StatelessWidget {
  const _CompanyStep({
    required this.companyNameController,
    required this.activityController,
    required this.sloganController,
    required this.warning,
    required this.state,
    required this.onBack,
    required this.onSubmit,
  });

  final TextEditingController companyNameController;
  final TextEditingController activityController;
  final TextEditingController sloganController;
  final String? warning;
  final PlayerOnboardingState state;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return StageScaffold(
      illustration: StageIllustrationType.company,
      eyebrow: 'Identité',
      title: 'Créez votre entreprise.',
      subtitle: 'Un nom clair suffit pour démarrer.',
      primaryLabel: 'Créer mon entreprise',
      onPrimary: onSubmit,
      secondaryLabel: 'Retour',
      onSecondary: onBack,
      children: [
        if (warning != null) ...[
          WarningFeedback(message: warning!),
          const SizedBox(height: 12),
        ],
        BizTextField(
          label: 'Nom de l’entreprise',
          controller: companyNameController,
          required: true,
          hintText: 'Ex. BIZ Pulse Lab',
        ),
        const SizedBox(height: 10),
        BizTextField(
          label: 'Activité',
          controller: activityController,
          hintText: 'Ex. services connectés',
        ),
        const SizedBox(height: 10),
        BizTextField(
          label: 'Slogan',
          controller: sloganController,
          hintText: 'Ex. Décider vite, apprendre mieux',
        ),
        const SizedBox(height: 12),
        CompanyPreviewCard(
          companyName: companyNameController.text,
          slogan: sloganController.text.isEmpty
              ? state.companySlogan
              : sloganController.text,
        ),
      ],
    );
  }
}

class _ProductFamilyStep extends StatelessWidget {
  const _ProductFamilyStep({
    required this.selectedFamily,
    required this.confirmation,
    required this.onBack,
    required this.onSelect,
    required this.onCompare,
    required this.onSubmit,
  });

  final ProductFamily selectedFamily;
  final String? confirmation;
  final VoidCallback onBack;
  final ValueChanged<ProductFamily> onSelect;
  final VoidCallback onCompare;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return StageScaffold(
      illustration: StageIllustrationType.product,
      eyebrow: 'Produit',
      title: 'Choisissez votre terrain de jeu.',
      subtitle: 'Chaque famille raconte une promesse différente.',
      confirmation: confirmation,
      primaryLabel: 'Confirmer ce produit',
      onPrimary: onSubmit,
      secondaryLabel: 'Comparer',
      onSecondary: onCompare,
      tertiaryLabel: 'Retour',
      onTertiary: onBack,
      children: [
        for (final family in productFamilies) ...[
          ProductFamilyVisualCard(
            family: family,
            selected: family.id == selectedFamily.id,
            onTap: () => onSelect(family),
          ),
          const SizedBox(height: 9),
        ],
      ],
    );
  }
}

class _ProductConfirmStep extends StatelessWidget {
  const _ProductConfirmStep({
    required this.state,
    required this.onBack,
    required this.onSubmit,
  });

  final PlayerOnboardingState state;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final family = state.productFamily;

    return StageScaffold(
      illustration: StageIllustrationType.confirmation,
      eyebrow: 'Confirmation',
      title: '${family.name} est prêt.',
      subtitle: family.missionAngle,
      primaryLabel: 'Confirmer mon choix',
      onPrimary: onSubmit,
      secondaryLabel: 'Comparer les produits',
      onSecondary: onBack,
      children: [
        ProductHeroCard(family: family),
        const SizedBox(height: 10),
        InsightCard(
          icon: family.icon,
          title: 'Famille choisie',
          value: family.productLine,
          color: family.color,
        ),
        const SizedBox(height: 10),
        InsightCard(
          icon: state.learningGoal.icon,
          title: 'Objectif',
          value: state.learningGoal.title,
          color: state.learningGoal.color,
        ),
        const SizedBox(height: 10),
        const WarningFeedback(
          message:
              'Ce choix est définitif pour cette partie. Prenez le temps de comparer avant de confirmer.',
        ),
      ],
    );
  }
}

class _FirstMissionStep extends StatelessWidget {
  const _FirstMissionStep({
    required this.state,
    required this.confirmation,
    required this.onBack,
    required this.onBriefing,
    required this.onSubmit,
  });

  final PlayerOnboardingState state;
  final String? confirmation;
  final VoidCallback onBack;
  final VoidCallback onBriefing;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return StageScaffold(
      illustration: StageIllustrationType.mission,
      eyebrow: 'Tour 1',
      title: 'Votre première mission.',
      subtitle: 'Construisez une promesse claire avant de décider.',
      confirmation: confirmation,
      primaryLabel: 'Commencer la mission',
      onPrimary: onSubmit,
      secondaryLabel: 'Écouter le briefing',
      onSecondary: onBriefing,
      tertiaryLabel: 'Retour',
      onTertiary: onBack,
      children: [
        MissionBlock(
          icon: Icons.flag_rounded,
          title: 'Objectif',
          value: 'Créer une promesse claire pour ${state.productFamily.name}.',
          color: BizPulseDesignSystem.trustBlue,
        ),
        const SizedBox(height: 10),
        const MissionBlock(
          icon: Icons.widgets_rounded,
          title: 'Moyens disponibles',
          value: 'Produit, budget initial, KPI et conseils du Coach Biz.',
          color: BizPulseDesignSystem.bizGold,
        ),
        const SizedBox(height: 10),
        const MissionBlock(
          icon: Icons.task_alt_rounded,
          title: 'Actions à réaliser',
          value: 'Analyser, décider, confirmer puis lire les résultats.',
          color: BizPulseDesignSystem.progressGreen,
        ),
      ],
    );
  }
}

class _TourGuideStep extends StatelessWidget {
  const _TourGuideStep({
    required this.onBack,
    required this.onSubmit,
  });

  final VoidCallback onBack;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return StageScaffold(
      illustration: StageIllustrationType.tour,
      eyebrow: 'Règle simple',
      title: 'Un tour = un trimestre.',
      subtitle: 'Une boucle courte pour apprendre par l’action.',
      primaryLabel: 'Faire la visite',
      onPrimary: onSubmit,
      secondaryLabel: 'Retour',
      onSecondary: onBack,
      children: const [
        TourStepTile(
          number: '1',
          title: 'Analyser',
          icon: Icons.visibility_rounded,
          color: BizPulseDesignSystem.trustBlue,
        ),
        SizedBox(height: 8),
        TourStepTile(
          number: '2',
          title: 'Décider',
          icon: Icons.touch_app_rounded,
          color: BizPulseDesignSystem.bizGold,
        ),
        SizedBox(height: 8),
        TourStepTile(
          number: '3',
          title: 'Confirmer',
          icon: Icons.verified_rounded,
          color: BizPulseDesignSystem.progressGreen,
        ),
        SizedBox(height: 8),
        TourStepTile(
          number: '4',
          title: 'Passer le tour',
          icon: Icons.skip_next_rounded,
          color: BizPulseDesignSystem.innovationViolet,
        ),
        SizedBox(height: 8),
        TourStepTile(
          number: '5',
          title: 'Comprendre les résultats',
          icon: Icons.insights_rounded,
          color: BizPulseDesignSystem.turquoise,
        ),
      ],
    );
  }
}

class _GuidedVisitStep extends StatelessWidget {
  const _GuidedVisitStep({
    required this.currentIndex,
    required this.onBack,
    required this.onSkip,
    required this.onNext,
  });

  final int currentIndex;
  final VoidCallback onBack;
  final VoidCallback onSkip;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final step = guidedVisitSteps[currentIndex];
    final isLast = currentIndex == guidedVisitSteps.length - 1;

    return StageScaffold(
      illustration: StageIllustrationType.visit,
      eyebrow: 'Visite guidée',
      title: 'Repérez votre cockpit.',
      subtitle: 'Huit repères utiles, rien de plus pour commencer.',
      primaryLabel: isLast ? 'Terminer' : 'Suivant',
      onPrimary: onNext,
      secondaryLabel: 'Retour',
      onSecondary: onBack,
      tertiaryLabel: 'Passer la visite',
      onTertiary: onSkip,
      children: [
        GuidedVisitSpotlightCard(
          step: step,
          index: currentIndex,
          total: guidedVisitSteps.length,
        ),
        const SizedBox(height: 12),
        const PositiveFeedback(
          message: 'Les directions complètes restent verrouillées pour ce lot.',
        ),
      ],
    );
  }
}

class _DashboardStep extends StatelessWidget {
  const _DashboardStep({
    required this.state,
    required this.dashboardData,
    required this.confirmation,
    required this.onBack,
  });

  final PlayerOnboardingState state;
  final DashboardData dashboardData;
  final String? confirmation;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return StageScaffold(
      illustration: StageIllustrationType.dashboard,
      denseHeader: true,
      eyebrow: 'Tour 1',
      title: 'Dashboard simplifié.',
      subtitle: 'Les signaux essentiels de votre entreprise.',
      confirmation: confirmation,
      primaryLabel: 'Parcours prêt',
      onPrimary: () {},
      secondaryLabel: 'Retour',
      onSecondary: onBack,
      children: [
        DashboardKpiGrid(
          kpis: dashboardData.priorityKpis,
          compact: true,
        ),
        const SizedBox(height: 10),
        DashboardQuickAction(action: dashboardData.nextActions.first),
        const SizedBox(height: 12),
        DashboardHeaderCard(
          companyName: state.companyName,
          productLine: state.productFamily.productLine,
          data: dashboardData,
        ),
        const SizedBox(height: 10),
        const DashboardViewSelector(),
        const SizedBox(height: 12),
        DashboardNextActions(actions: dashboardData.nextActions),
        const SizedBox(height: 12),
        DashboardSituationFacts(facts: dashboardData.facts),
        const SizedBox(height: 12),
        DashboardKpiGrid(kpis: dashboardData.secondaryKpis),
        const SizedBox(height: 16),
        PriorityAlerts(alerts: dashboardData.alerts),
        const SizedBox(height: 16),
        const LockedDirectionsAccess(),
        const SizedBox(height: 10),
        const PositiveFeedback(
          message: 'Fin du lot : validation requise avant la suite.',
        ),
      ],
    );
  }
}
