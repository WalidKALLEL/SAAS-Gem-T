import 'package:flutter/material.dart';

enum PlayerOnboardingStep {
  createAccount,
  login,
  welcome,
  learningGoal,
  company,
  productFamily,
  productConfirm,
  firstMission,
  tourGuide,
  guidedVisit,
  dashboard,
}

extension PlayerOnboardingStepLabel on PlayerOnboardingStep {
  String get title {
    switch (this) {
      case PlayerOnboardingStep.createAccount:
        return 'Compte';
      case PlayerOnboardingStep.login:
        return 'Connexion';
      case PlayerOnboardingStep.welcome:
        return 'Bienvenue';
      case PlayerOnboardingStep.learningGoal:
        return 'Objectif';
      case PlayerOnboardingStep.company:
        return 'Entreprise';
      case PlayerOnboardingStep.productFamily:
        return 'Produit';
      case PlayerOnboardingStep.productConfirm:
        return 'Confirmation';
      case PlayerOnboardingStep.firstMission:
        return 'Mission';
      case PlayerOnboardingStep.tourGuide:
        return 'Tour';
      case PlayerOnboardingStep.guidedVisit:
        return 'Visite';
      case PlayerOnboardingStep.dashboard:
        return 'Dashboard';
    }
  }

  String get progressGroup {
    switch (this) {
      case PlayerOnboardingStep.createAccount:
      case PlayerOnboardingStep.login:
        return 'Compte';
      case PlayerOnboardingStep.welcome:
      case PlayerOnboardingStep.learningGoal:
        return 'Bienvenue';
      case PlayerOnboardingStep.company:
        return 'Entreprise';
      case PlayerOnboardingStep.productFamily:
      case PlayerOnboardingStep.productConfirm:
        return 'Produit';
      case PlayerOnboardingStep.firstMission:
      case PlayerOnboardingStep.tourGuide:
        return 'Mission';
      case PlayerOnboardingStep.guidedVisit:
        return 'Visite';
      case PlayerOnboardingStep.dashboard:
        return 'Dashboard';
    }
  }

  int get progressIndex {
    const groups = [
      'Compte',
      'Bienvenue',
      'Entreprise',
      'Produit',
      'Mission',
      'Visite',
      'Dashboard',
    ];

    return groups.indexOf(progressGroup);
  }
}

enum StageIllustrationType {
  account,
  login,
  welcome,
  goal,
  company,
  product,
  confirmation,
  mission,
  tour,
  visit,
  dashboard,
}

enum ProductVisualKind {
  smartChair,
  professionalRobot,
  smartDrone,
}

class LearningGoal {
  const LearningGoal({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.icon,
    required this.color,
  });

  final String id;
  final String title;
  final String shortDescription;
  final IconData icon;
  final Color color;
}

const learningGoals = <LearningGoal>[
  LearningGoal(
    id: 'strategy',
    title: 'Stratégie',
    shortDescription: 'Choisir, prioriser, décider.',
    icon: Icons.route_rounded,
    color: Color(0xFF2456A6),
  ),
  LearningGoal(
    id: 'growth',
    title: 'Croissance',
    shortDescription: 'Développer ventes et marché.',
    icon: Icons.trending_up_rounded,
    color: Color(0xFF2F855A),
  ),
  LearningGoal(
    id: 'finance',
    title: 'Finance',
    shortDescription: 'Comprendre marge, budget et cash.',
    icon: Icons.account_balance_wallet_rounded,
    color: Color(0xFF177E89),
  ),
  LearningGoal(
    id: 'negotiation',
    title: 'Négociation',
    shortDescription: 'Argumenter, arbitrer, convaincre.',
    icon: Icons.handshake_rounded,
    color: Color(0xFFC89B3C),
  ),
  LearningGoal(
    id: 'innovation',
    title: 'Innovation',
    shortDescription: 'Tester, différencier, apprendre.',
    icon: Icons.auto_awesome_rounded,
    color: Color(0xFF7657D5),
  ),
  LearningGoal(
    id: 'leadership',
    title: 'Leadership',
    shortDescription: 'Mobiliser une équipe et décider.',
    icon: Icons.groups_rounded,
    color: Color(0xFF5B4A91),
  ),
];

class PlayerExperienceLevel {
  const PlayerExperienceLevel({
    required this.id,
    required this.label,
    required this.shortDescription,
    required this.icon,
  });

  final String id;
  final String label;
  final String shortDescription;
  final IconData icon;
}

const playerExperienceLevels = <PlayerExperienceLevel>[
  PlayerExperienceLevel(
    id: 'first',
    label: 'Première expérience',
    shortDescription: 'Je découvre le business game.',
    icon: Icons.explore_rounded,
  ),
  PlayerExperienceLevel(
    id: 'some',
    label: 'Quelques notions',
    shortDescription: 'Je connais déjà quelques mécanismes.',
    icon: Icons.lightbulb_rounded,
  ),
  PlayerExperienceLevel(
    id: 'advanced',
    label: 'Expérience avancée',
    shortDescription: 'Je veux aller plus vite dans l’analyse.',
    icon: Icons.speed_rounded,
  ),
];

class ProductFamily {
  const ProductFamily({
    required this.id,
    required this.name,
    required this.productLine,
    required this.shortDescription,
    required this.missionAngle,
    required this.icon,
    required this.visualKind,
    required this.usages,
    required this.color,
    required this.accentColor,
    required this.kpis,
  });

  final String id;
  final String name;
  final String productLine;
  final String shortDescription;
  final String missionAngle;
  final IconData icon;
  final ProductVisualKind visualKind;
  final List<String> usages;
  final Color color;
  final Color accentColor;
  final List<String> kpis;
}

const productFamilies = <ProductFamily>[
  ProductFamily(
    id: 'PRES',
    name: 'Prestige TECH',
    productLine: 'Drone intelligent',
    shortDescription: 'Innovant, mobile, différencié.',
    missionAngle: 'Valoriser innovation et crédibilité.',
    icon: Icons.flight_takeoff_rounded,
    visualKind: ProductVisualKind.smartDrone,
    usages: ['Inspection', 'Livraison', 'Données'],
    color: Color(0xFF177E89),
    accentColor: Color(0xFFC89B3C),
    kpis: ['Innovation', 'Image', 'R&D'],
  ),
  ProductFamily(
    id: 'PREM',
    name: 'Premium Accessible',
    productLine: 'Robot professionnel intelligent',
    shortDescription: 'Fiable, qualitatif, rassurant.',
    missionAngle: 'Aligner qualité, confiance et preuve.',
    icon: Icons.smart_toy_rounded,
    visualKind: ProductVisualKind.professionalRobot,
    usages: ['Accueil', 'Assistance', 'Productivité'],
    color: Color(0xFF5B4A91),
    accentColor: Color(0xFFC89B3C),
    kpis: ['Qualité', 'Confiance', 'Marge'],
  ),
  ProductFamily(
    id: 'REF',
    name: 'Référence',
    productLine: 'Chaise multifonction intelligente',
    shortDescription: 'Simple, utile, accessible.',
    missionAngle: 'Prouver la valeur sans complexité.',
    icon: Icons.chair_rounded,
    visualKind: ProductVisualKind.smartChair,
    usages: ['Bureau', 'Santé', 'Confort'],
    color: Color(0xFF2456A6),
    accentColor: Color(0xFF2F855A),
    kpis: ['Prix', 'Stock', 'Volume'],
  ),
];

class PlayerOnboardingState {
  const PlayerOnboardingState({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.companyName,
    required this.companyActivity,
    required this.companySlogan,
    required this.learningGoal,
    required this.experienceLevel,
    required this.productFamily,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String companyName;
  final String companyActivity;
  final String companySlogan;
  final LearningGoal learningGoal;
  final PlayerExperienceLevel experienceLevel;
  final ProductFamily productFamily;

  PlayerOnboardingState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? companyName,
    String? companyActivity,
    String? companySlogan,
    LearningGoal? learningGoal,
    PlayerExperienceLevel? experienceLevel,
    ProductFamily? productFamily,
  }) {
    return PlayerOnboardingState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      companyName: companyName ?? this.companyName,
      companyActivity: companyActivity ?? this.companyActivity,
      companySlogan: companySlogan ?? this.companySlogan,
      learningGoal: learningGoal ?? this.learningGoal,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      productFamily: productFamily ?? this.productFamily,
    );
  }

  static const initial = PlayerOnboardingState(
    firstName: 'Nadia',
    lastName: 'Ben Ali',
    email: 'player@bizpulse.app',
    companyName: 'BIZ Pulse Lab',
    companyActivity: 'Business challenge',
    companySlogan: 'Décider vite, apprendre mieux.',
    learningGoal: LearningGoal(
      id: 'strategy',
      title: 'Stratégie',
      shortDescription: 'Choisir, prioriser, décider.',
      icon: Icons.route_rounded,
      color: Color(0xFF2456A6),
    ),
    experienceLevel: PlayerExperienceLevel(
      id: 'first',
      label: 'Première expérience',
      shortDescription: 'Je découvre le business game.',
      icon: Icons.explore_rounded,
    ),
    productFamily: ProductFamily(
      id: 'PREM',
      name: 'Premium Accessible',
      productLine: 'Robot professionnel intelligent',
      shortDescription: 'Fiable, qualitatif, rassurant.',
      missionAngle: 'Aligner qualité, confiance et preuve.',
      icon: Icons.smart_toy_rounded,
      visualKind: ProductVisualKind.professionalRobot,
      usages: ['Accueil', 'Assistance', 'Productivité'],
      color: Color(0xFF5B4A91),
      accentColor: Color(0xFFC89B3C),
      kpis: ['Qualité', 'Confiance', 'Marge'],
    ),
  );
}

class GuidedVisitSpotlight {
  const GuidedVisitSpotlight({
    required this.title,
    required this.shortDescription,
    required this.icon,
    required this.color,
  });

  final String title;
  final String shortDescription;
  final IconData icon;
  final Color color;
}

const guidedVisitSteps = <GuidedVisitSpotlight>[
  GuidedVisitSpotlight(
    title: 'Numéro du tour',
    shortDescription: 'Repérez où vous êtes dans la partie.',
    icon: Icons.flag_rounded,
    color: Color(0xFF2456A6),
  ),
  GuidedVisitSpotlight(
    title: 'Compte à rebours',
    shortDescription: 'Gardez le rythme sans pression inutile.',
    icon: Icons.timer_rounded,
    color: Color(0xFFC89B3C),
  ),
  GuidedVisitSpotlight(
    title: 'Navigation',
    shortDescription: 'Accédez aux zones utiles du cockpit.',
    icon: Icons.navigation_rounded,
    color: Color(0xFF177E89),
  ),
  GuidedVisitSpotlight(
    title: 'KPI',
    shortDescription: 'Lisez les signaux avant d’agir.',
    icon: Icons.speed_rounded,
    color: Color(0xFF2F855A),
  ),
  GuidedVisitSpotlight(
    title: 'Explication du KPI',
    shortDescription: 'Utilisez le bouton i pour comprendre.',
    icon: Icons.info_rounded,
    color: Color(0xFF2456A6),
  ),
  GuidedVisitSpotlight(
    title: 'Carte décisionnelle',
    shortDescription: 'Préparez une décision à la fois.',
    icon: Icons.tune_rounded,
    color: Color(0xFF7657D5),
  ),
  GuidedVisitSpotlight(
    title: 'Confirmation',
    shortDescription: 'Vérifiez avant de valider.',
    icon: Icons.verified_rounded,
    color: Color(0xFF21A366),
  ),
  GuidedVisitSpotlight(
    title: 'Passage du tour',
    shortDescription: 'Lancez le résultat lorsque tout est prêt.',
    icon: Icons.skip_next_rounded,
    color: Color(0xFFC89B3C),
  ),
];

enum DashboardKpiApplicability {
  active,
  nonMeasurable,
  locked,
  availableAfterCondition,
  availableAfterTurn,
}

extension DashboardKpiApplicabilityText on DashboardKpiApplicability {
  String get label {
    return switch (this) {
      DashboardKpiApplicability.active => 'Actif',
      DashboardKpiApplicability.nonMeasurable => 'Pas encore mesurable',
      DashboardKpiApplicability.locked => 'Verrouillé',
      DashboardKpiApplicability.availableAfterCondition =>
        'Disponible après condition',
      DashboardKpiApplicability.availableAfterTurn =>
        'Disponible après un tour',
    };
  }

  IconData get icon {
    return switch (this) {
      DashboardKpiApplicability.active => Icons.verified_rounded,
      DashboardKpiApplicability.nonMeasurable => Icons.hourglass_empty_rounded,
      DashboardKpiApplicability.locked => Icons.lock_rounded,
      DashboardKpiApplicability.availableAfterCondition => Icons.rule_rounded,
      DashboardKpiApplicability.availableAfterTurn => Icons.skip_next_rounded,
    };
  }
}

class DashboardKpi {
  const DashboardKpi({
    required this.id,
    required this.label,
    required this.value,
    required this.unit,
    required this.evolution,
    required this.stateLabel,
    required this.icon,
    required this.color,
    required this.progress,
    required this.definition,
    required this.importance,
    required this.interpretation,
    required this.factors,
    required this.relatedKpis,
    required this.commonMistake,
    required this.example,
    required this.reflectionQuestion,
    this.applicability = DashboardKpiApplicability.active,
    this.availabilityLabel,
    this.priority = false,
  });

  final String id;
  final String label;
  final String value;
  final String unit;
  final String evolution;
  final String stateLabel;
  final IconData icon;
  final Color color;
  final double progress;
  final String definition;
  final String importance;
  final String interpretation;
  final List<String> factors;
  final List<String> relatedKpis;
  final String commonMistake;
  final String example;
  final String reflectionQuestion;
  final DashboardKpiApplicability applicability;
  final String? availabilityLabel;
  final bool priority;

  bool get isActive => applicability == DashboardKpiApplicability.active;

  String get displayValue =>
      isActive ? value : availabilityLabel ?? applicability.label;
}

class DashboardFact {
  const DashboardFact({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
}

class DashboardNextAction {
  const DashboardNextAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
}

class DashboardAlert {
  const DashboardAlert({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
}

class DashboardData {
  const DashboardData({
    required this.id,
    required this.statusLabel,
    required this.turnLabel,
    required this.timerLabel,
    required this.zoneLabel,
    required this.localLabel,
    required this.facts,
    required this.kpis,
    required this.nextActions,
    required this.alerts,
  });

  final String id;
  final String statusLabel;
  final String turnLabel;
  final String timerLabel;
  final String zoneLabel;
  final String localLabel;
  final List<DashboardFact> facts;
  final List<DashboardKpi> kpis;
  final List<DashboardNextAction> nextActions;
  final List<DashboardAlert> alerts;

  List<DashboardKpi> get priorityKpis =>
      kpis.where((kpi) => kpi.priority).toList(growable: false);

  List<DashboardKpi> get secondaryKpis =>
      kpis.where((kpi) => !kpi.priority).toList(growable: false);
}

const dashboardNextActionsDemo = <DashboardNextAction>[
  DashboardNextAction(
    title: 'Consulter une alerte',
    subtitle: 'Priorisez les signaux qui peuvent gêner le prochain tour.',
    icon: Icons.notifications_active_rounded,
    color: Color(0xFFC89B3C),
  ),
  DashboardNextAction(
    title: 'Préparer une commande',
    subtitle: 'Vérifiez la cohérence entre stock, ventes et trésorerie.',
    icon: Icons.inventory_rounded,
    color: Color(0xFF2456A6),
  ),
  DashboardNextAction(
    title: 'Vérifier la trésorerie',
    subtitle:
        'Repérez les décisions qui consomment du cash avant de confirmer.',
    icon: Icons.account_balance_wallet_rounded,
    color: Color(0xFF2F855A),
  ),
];

const initialDashboardFacts = <DashboardFact>[
  DashboardFact(
    label: 'Capital souscrit',
    value: '10 000 TND',
    icon: Icons.account_balance_rounded,
    color: Color(0xFF2456A6),
  ),
  DashboardFact(
    label: 'Capital libéré',
    value: '3 000 TND',
    icon: Icons.savings_rounded,
    color: Color(0xFF2F855A),
  ),
  DashboardFact(
    label: 'Restant à libérer',
    value: '7 000 TND',
    icon: Icons.schedule_rounded,
    color: Color(0xFFC89B3C),
  ),
  DashboardFact(
    label: 'Dettes',
    value: '0 TND',
    icon: Icons.receipt_long_rounded,
    color: Color(0xFF177E89),
  ),
  DashboardFact(
    label: 'Créances',
    value: '0 TND',
    icon: Icons.request_quote_rounded,
    color: Color(0xFF5B4A91),
  ),
  DashboardFact(
    label: 'Machines',
    value: '0',
    icon: Icons.precision_manufacturing_rounded,
    color: Color(0xFF177E89),
  ),
  DashboardFact(
    label: 'Salariés',
    value: '0',
    icon: Icons.badge_rounded,
    color: Color(0xFF2456A6),
  ),
  DashboardFact(
    label: 'Local loué',
    value: '30 m²',
    icon: Icons.meeting_room_rounded,
    color: Color(0xFFC89B3C),
  ),
];

const initialDashboardKpis = <DashboardKpi>[
  DashboardKpi(
    id: 'cash',
    label: 'Trésorerie',
    value: '3 000',
    unit: 'TND',
    evolution: 'Initial',
    stateLabel: 'Disponible',
    icon: Icons.account_balance_wallet_rounded,
    color: Color(0xFF2456A6),
    progress: 0.30,
    priority: true,
    definition: 'Montant disponible pour financer les prochaines décisions.',
    importance:
        'Elle correspond au capital libéré au démarrage de l’entreprise.',
    interpretation:
        'Vous disposez de 3 000 TND de trésorerie et de 7 000 TND restant à libérer.',
    factors: ['Capital libéré', 'dépenses initiales', 'décisions à venir'],
    relatedKpis: ['Résultat', 'stock', 'capital restant'],
    commonMistake: 'Confondre capital souscrit et trésorerie disponible.',
    example:
        'Les 10 000 TND sont souscrits, mais seuls 3 000 TND sont libérés.',
    reflectionQuestion:
        'Quelle décision peut attendre avant de consommer du cash ?',
  ),
  DashboardKpi(
    id: 'profit',
    label: 'Résultat',
    value: '0',
    unit: 'TND',
    evolution: 'Initial',
    stateLabel: 'À construire',
    icon: Icons.query_stats_rounded,
    color: Color(0xFFC89B3C),
    progress: 0,
    priority: true,
    definition: 'Écart entre les revenus et les coûts du tour.',
    importance: 'Il indique si l’activité crée réellement de la valeur.',
    interpretation:
        'Au démarrage, aucune opération commerciale n’a encore généré de résultat.',
    factors: ['Ventes', 'charges', 'coûts', 'prix'],
    relatedKpis: ['Trésorerie', 'chiffre d’affaires', 'ventes'],
    commonMistake: 'Chercher un résultat avant d’avoir réalisé une activité.',
    example:
        'Le résultat reste à 0 TND tant qu’aucune décision n’a produit d’effet.',
    reflectionQuestion:
        'Quelle première décision peut préparer un résultat positif ?',
  ),
  DashboardKpi(
    id: 'revenue',
    label: 'Chiffre d’affaires',
    value: '0',
    unit: 'TND',
    evolution: 'Initial',
    stateLabel: 'Aucune vente',
    icon: Icons.payments_rounded,
    color: Color(0xFF2F855A),
    progress: 0,
    priority: true,
    definition: 'Total des ventes générées sur la période.',
    importance: 'Il montre la traction commerciale de l’offre.',
    interpretation:
        'Au premier accès, aucune vente n’a encore été enregistrée.',
    factors: ['Prix', 'demande', 'distribution', 'communication'],
    relatedKpis: ['Ventes', 'part de marché', 'résultat'],
    commonMistake: 'Lire le chiffre d’affaires avant le passage d’un tour.',
    example: 'Le chiffre d’affaires apparaîtra après les premières ventes.',
    reflectionQuestion: 'Quelle action prépare les premières ventes ?',
  ),
  DashboardKpi(
    id: 'stock',
    label: 'Stock',
    value: '0',
    unit: 'unité',
    evolution: 'Initial',
    stateLabel: 'À constituer',
    icon: Icons.inventory_2_rounded,
    color: Color(0xFF5B4A91),
    progress: 0,
    priority: true,
    definition: 'Quantité disponible pour répondre aux prochaines ventes.',
    importance: 'Il évite les ruptures et limite l’argent immobilisé.',
    interpretation:
        'Aucun stock n’est constitué au démarrage : les décisions de production ou d’achat viendront ensuite.',
    factors: ['Production', 'commande', 'ventes', 'délais'],
    relatedKpis: ['Trésorerie', 'ventes', 'satisfaction client'],
    commonMistake:
        'Supposer un stock initial alors qu’aucune commande n’a été passée.',
    example: 'Un stock à 0 unité est normal au premier accès au dashboard.',
    reflectionQuestion: 'Quel niveau de stock faudra-t-il préparer ?',
  ),
  DashboardKpi(
    id: 'missionProgress',
    label: 'Progression de la mission',
    value: '2/5',
    unit: 'étapes',
    evolution: 'Tour 1',
    stateLabel: 'En cours',
    icon: Icons.checklist_rounded,
    color: Color(0xFF177E89),
    progress: 0.40,
    definition: 'Avancement dans la mission pédagogique du premier tour.',
    importance:
        'Elle remplace les indicateurs de production tant que l’entreprise n’a ni machine ni salarié.',
    interpretation:
        'Deux repères sont déjà posés : l’entreprise est créée et le produit est choisi.',
    factors: [
      'Entreprise',
      'produit',
      'briefing',
      'visite',
      'première décision'
    ],
    relatedKpis: ['Trésorerie', 'stock', 'résultat'],
    commonMistake:
        'Chercher la productivité avant d’avoir une activité productive.',
    example:
        'La progression passe de 2/5 à 5/5 lorsque les étapes du tour sont prêtes.',
    reflectionQuestion: 'Quelle étape manque avant de lancer le premier tour ?',
  ),
  DashboardKpi(
    id: 'sales',
    label: 'Ventes',
    value: '0',
    unit: 'unité',
    evolution: 'Initial',
    stateLabel: 'À lancer',
    icon: Icons.shopping_bag_rounded,
    color: Color(0xFF177E89),
    progress: 0,
    definition: 'Nombre d’unités vendues pendant le tour.',
    importance: 'Il révèle l’attractivité concrète du produit.',
    interpretation:
        'Aucune vente n’a encore eu lieu au premier accès au dashboard.',
    factors: ['Prix', 'notoriété', 'qualité', 'capacité'],
    relatedKpis: ['Stock', 'satisfaction client', 'part de marché'],
    commonMistake: 'Comparer les ventes avant le premier passage de tour.',
    example: 'Les ventes restent à 0 unité tant que le tour n’est pas joué.',
    reflectionQuestion: 'Quelle décision peut favoriser les premières ventes ?',
  ),
  DashboardKpi(
    id: 'satisfaction',
    label: 'Satisfaction client',
    value: '',
    unit: '',
    evolution: 'En attente',
    stateLabel: 'Pas encore mesurable',
    icon: Icons.sentiment_satisfied_alt_rounded,
    color: Color(0xFF2F855A),
    progress: 0,
    applicability: DashboardKpiApplicability.nonMeasurable,
    availabilityLabel: 'Disponible après vos premières ventes',
    definition: 'Perception client de la valeur reçue.',
    importance: 'Elle influence la fidélité et la réputation.',
    interpretation:
        'Sans vente ni retour client, cet indicateur ne peut pas être calculé.',
    factors: ['Qualité', 'prix perçu', 'service', 'disponibilité'],
    relatedKpis: ['Ventes', 'part de marché', 'résultat'],
    commonMistake:
        'Afficher une satisfaction fictive avant les premiers clients.',
    example: 'La mesure apparaîtra après les premiers retours du marché.',
    reflectionQuestion:
        'Quelle promesse client voulez-vous tester lors du premier tour ?',
  ),
  DashboardKpi(
    id: 'marketShare',
    label: 'Part de marché',
    value: '',
    unit: '',
    evolution: 'En attente',
    stateLabel: 'Disponible après un tour',
    icon: Icons.pie_chart_rounded,
    color: Color(0xFF2456A6),
    progress: 0,
    applicability: DashboardKpiApplicability.availableAfterTurn,
    availabilityLabel: 'Disponible après le passage du tour',
    definition: 'Poids de votre entreprise dans le marché simulé.',
    importance: 'Elle situe votre position face aux concurrents.',
    interpretation:
        'La part de marché demande au moins un résultat de tour pour être calculée.',
    factors: ['Positionnement', 'prix', 'communication', 'innovation'],
    relatedKpis: ['Ventes', 'satisfaction client', 'chiffre d’affaires'],
    commonMistake: 'Attribuer une part de marché sans ventes comparables.',
    example: 'Après un tour, les ventes simulées permettront la comparaison.',
    reflectionQuestion: 'Quelle clientèle voulez-vous convaincre en priorité ?',
  ),
];

const postTurnDemoKpis = <DashboardKpi>[
  DashboardKpi(
    id: 'cash',
    label: 'Trésorerie',
    value: '42.5',
    unit: 'kDT',
    evolution: '+3%',
    stateLabel: 'Sain',
    icon: Icons.account_balance_wallet_rounded,
    color: Color(0xFF2456A6),
    progress: 0.68,
    priority: true,
    definition: 'Montant disponible pour financer les prochaines décisions.',
    importance: 'Elle protège l’entreprise contre les imprévus.',
    interpretation: 'Une trésorerie positive donne de la marge de manœuvre.',
    factors: ['Prix', 'volume vendu', 'stock', 'charges'],
    relatedKpis: ['Résultat', 'stock', 'ventes'],
    commonMistake: 'Confondre trésorerie et bénéfice.',
    example:
        'Une commande importante peut augmenter le stock mais réduire le cash.',
    reflectionQuestion:
        'Quelle décision pourrait consommer le plus de cash ce tour ?',
  ),
  DashboardKpi(
    id: 'profit',
    label: 'Résultat',
    value: '2.4',
    unit: 'kDT',
    evolution: '+4%',
    stateLabel: 'À consolider',
    icon: Icons.query_stats_rounded,
    color: Color(0xFFC89B3C),
    progress: 0.54,
    priority: true,
    definition: 'Écart entre les revenus et les coûts du tour.',
    importance: 'Il indique si l’activité crée réellement de la valeur.',
    interpretation:
        'Un résultat positif doit être comparé aux efforts engagés.',
    factors: ['Marge', 'charges', 'prix', 'qualité'],
    relatedKpis: ['Trésorerie', 'chiffre d’affaires', 'productivité'],
    commonMistake: 'Décider uniquement à partir du chiffre d’affaires.',
    example:
        'Un produit plus cher peut améliorer le résultat si la demande suit.',
    reflectionQuestion: 'Quel coût mérite d’être surveillé avant de décider ?',
  ),
  DashboardKpi(
    id: 'revenue',
    label: 'Chiffre d’affaires',
    value: '18.2',
    unit: 'kDT',
    evolution: '+8%',
    stateLabel: 'En hausse',
    icon: Icons.payments_rounded,
    color: Color(0xFF2F855A),
    progress: 0.62,
    priority: true,
    definition: 'Total des ventes générées sur la période.',
    importance: 'Il montre la traction commerciale de l’offre.',
    interpretation:
        'Une hausse est utile si elle reste cohérente avec les marges.',
    factors: ['Prix', 'demande', 'distribution', 'communication'],
    relatedKpis: ['Ventes', 'part de marché', 'résultat'],
    commonMistake: 'Chercher du volume sans surveiller la rentabilité.',
    example:
        'Une promotion peut augmenter le chiffre d’affaires sans garantir le résultat.',
    reflectionQuestion:
        'La croissance vient-elle du prix, du volume ou des deux ?',
  ),
  DashboardKpi(
    id: 'stock',
    label: 'Stock',
    value: '74',
    unit: 'unités',
    evolution: '-6%',
    stateLabel: 'À suivre',
    icon: Icons.inventory_2_rounded,
    color: Color(0xFF5B4A91),
    progress: 0.44,
    priority: true,
    definition: 'Quantité disponible pour répondre aux prochaines ventes.',
    importance: 'Il évite les ruptures et limite l’argent immobilisé.',
    interpretation: 'Un stock trop bas ou trop haut peut devenir risqué.',
    factors: ['Production', 'ventes', 'prévision', 'délais'],
    relatedKpis: ['Trésorerie', 'ventes', 'satisfaction client'],
    commonMistake: 'Commander sans relier stock et demande.',
    example: 'Un stock élevé rassure mais peut bloquer de la trésorerie.',
    reflectionQuestion:
        'Le stock actuel couvre-t-il la prochaine demande probable ?',
  ),
  DashboardKpi(
    id: 'sales',
    label: 'Ventes',
    value: '128',
    unit: 'unités',
    evolution: '+12%',
    stateLabel: 'Dynamique',
    icon: Icons.shopping_bag_rounded,
    color: Color(0xFF177E89),
    progress: 0.72,
    definition: 'Nombre d’unités vendues pendant le tour.',
    importance: 'Il révèle l’attractivité concrète du produit.',
    interpretation:
        'Des ventes fortes doivent rester compatibles avec le stock.',
    factors: ['Prix', 'notoriété', 'qualité', 'capacité'],
    relatedKpis: ['Stock', 'satisfaction client', 'part de marché'],
    commonMistake:
        'Ignorer les ruptures possibles après une hausse des ventes.',
    example:
        'Une demande forte peut créer une tension si le stock est trop faible.',
    reflectionQuestion: 'Votre capacité suit-elle le rythme des ventes ?',
  ),
  DashboardKpi(
    id: 'satisfaction',
    label: 'Satisfaction client',
    value: '82',
    unit: '/100',
    evolution: '+5 pts',
    stateLabel: 'Solide',
    icon: Icons.sentiment_satisfied_alt_rounded,
    color: Color(0xFF2F855A),
    progress: 0.82,
    definition: 'Perception client de la valeur reçue.',
    importance: 'Elle influence la fidélité et la réputation.',
    interpretation: 'Un bon niveau soutient la demande future.',
    factors: ['Qualité', 'prix perçu', 'service', 'disponibilité'],
    relatedKpis: ['Ventes', 'part de marché', 'résultat'],
    commonMistake: 'Penser qu’un prix bas suffit à satisfaire.',
    example:
        'Une meilleure qualité peut renforcer la confiance si le prix reste crédible.',
    reflectionQuestion:
        'Quel irritant client pourrait apparaître au prochain tour ?',
  ),
  DashboardKpi(
    id: 'marketShare',
    label: 'Part de marché',
    value: '7.8',
    unit: '%',
    evolution: '+0.8 pt',
    stateLabel: 'En progrès',
    icon: Icons.pie_chart_rounded,
    color: Color(0xFF2456A6),
    progress: 0.39,
    definition: 'Poids de votre entreprise dans le marché simulé.',
    importance: 'Elle situe votre position face aux concurrents.',
    interpretation:
        'Une progression lente peut être saine si elle reste rentable.',
    factors: ['Positionnement', 'prix', 'communication', 'innovation'],
    relatedKpis: ['Ventes', 'satisfaction client', 'chiffre d’affaires'],
    commonMistake: 'Chercher la part de marché à tout prix.',
    example: 'Gagner des parts peut demander plus d’efforts marketing.',
    reflectionQuestion: 'Quelle clientèle voulez-vous convaincre en priorité ?',
  ),
  DashboardKpi(
    id: 'productivity',
    label: 'Productivité',
    value: '68',
    unit: '/100',
    evolution: '+4 pts',
    stateLabel: 'Correct',
    icon: Icons.precision_manufacturing_rounded,
    color: Color(0xFF177E89),
    progress: 0.68,
    definition:
        'Capacité à produire efficacement avec les ressources disponibles.',
    importance: 'Elle influence les coûts, les délais et la qualité.',
    interpretation:
        'Un score moyen laisse une marge d’amélioration opérationnelle.',
    factors: ['Organisation', 'équipement', 'formation', 'charge'],
    relatedKpis: ['Stock', 'résultat', 'satisfaction client'],
    commonMistake: 'Augmenter la production sans vérifier l’efficacité.',
    example:
        'Un meilleur process peut soutenir les ventes sans exploser les coûts.',
    reflectionQuestion: 'Quelle ressource limite le plus votre performance ?',
  ),
];

const initialDashboardAlerts = <DashboardAlert>[
  DashboardAlert(
    title: 'Capital partiellement libéré',
    subtitle: '7 000 TND restent à libérer avant d’utiliser tout le capital.',
    icon: Icons.account_balance_rounded,
    color: Color(0xFFC89B3C),
  ),
  DashboardAlert(
    title: 'Activité productive inactive',
    subtitle:
        'Aucune machine ni salarié : la productivité n’est pas mesurable.',
    icon: Icons.precision_manufacturing_rounded,
    color: Color(0xFF2456A6),
  ),
];

const postTurnDemoAlerts = <DashboardAlert>[
  DashboardAlert(
    title: 'Stock à surveiller',
    subtitle: 'La baisse du stock peut limiter les ventes du prochain tour.',
    icon: Icons.inventory_2_rounded,
    color: Color(0xFFC89B3C),
  ),
  DashboardAlert(
    title: 'Cash disponible',
    subtitle: 'Gardez une marge pour absorber une décision coûteuse.',
    icon: Icons.account_balance_wallet_rounded,
    color: Color(0xFF2456A6),
  ),
];

const initialDashboardData = DashboardData(
  id: 'initial',
  statusLabel: 'Situation initiale',
  turnLabel: 'Tour 1',
  timerLabel: '12 min',
  zoneLabel: '1 zone active',
  localLabel: 'Local loué 30 m²',
  facts: initialDashboardFacts,
  kpis: initialDashboardKpis,
  nextActions: dashboardNextActionsDemo,
  alerts: initialDashboardAlerts,
);

const postTurnDemoDashboardData = DashboardData(
  id: 'postTurnDemo',
  statusLabel: 'Après un tour de démonstration',
  turnLabel: 'Tour 2',
  timerLabel: 'Simulation',
  zoneLabel: '3 zones actives',
  localLabel: 'Atelier pilote',
  facts: [
    DashboardFact(
      label: 'Trésorerie',
      value: '42.5 kDT',
      icon: Icons.account_balance_wallet_rounded,
      color: Color(0xFF2456A6),
    ),
    DashboardFact(
      label: 'Ventes',
      value: '128 unités',
      icon: Icons.shopping_bag_rounded,
      color: Color(0xFF177E89),
    ),
    DashboardFact(
      label: 'Stock',
      value: '74 unités',
      icon: Icons.inventory_2_rounded,
      color: Color(0xFF5B4A91),
    ),
    DashboardFact(
      label: 'Productivité',
      value: '68/100',
      icon: Icons.precision_manufacturing_rounded,
      color: Color(0xFF177E89),
    ),
  ],
  kpis: postTurnDemoKpis,
  nextActions: dashboardNextActionsDemo,
  alerts: postTurnDemoAlerts,
);

const dashboardKpis = initialDashboardKpis;
