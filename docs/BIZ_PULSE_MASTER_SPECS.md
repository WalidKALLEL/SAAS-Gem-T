# 🚀 BIZ Pulse — La Bible de Spécifications Globales

### Cahier des Charges Fonctionnel, UX/UI, Business & Architecture Technique (v1.0 - Étape 6)

---

## 🏛️ 1. Cadrage Produit & Proposition de Valeur

**BIZ Pulse** est la déclinaison mobile native de la plateforme de simulation *BIZ Experience* de la marque `bsuccess.tn`. Conçue pour rompre avec la lourdeur et la rigidité des simulateurs d'entreprise traditionnels basés sur le web (type Cesim ou Capsim), l'application propose une expérience immersive, fluide et hautement rejouable, optimisée pour des sessions courtes de **10 à 20 minutes** exploitables en mobilité.

### 1.1. Les Différenciateurs Stratégiques

* **Moteur d'Adaptation Sémantique & Cognitive :** L'application adapte dynamiquement la complexité des graphiques, le niveau de jargon financier et les recommandations de sa coach vocale (Emma Martin) en fonction du profil de maturité saisi par l'apprenant à l'onboarding.
* **Assessment Center Technologique (B2B RH) :** Une infrastructure d'analyse passive permet d'utiliser la simulation comme un outil d'aide à la décision d'embauche pour les entreprises. Elle évalue simultanément les compétences techniques de gestion (*Hard Skills*) et les comportements décisionnels sous stress concurrentiel (*Soft Skills*).

### 1.2. Cartographie des Modes de Jeu

* **Mode SOLO vs IA :** Le joueur pilote sa structure face à 10 entreprises virtuelles dotées d'algorithmes comportementaux réalistes (stratégies low-cost, opportunisme marketing, spéculation ou prudence logistique).
* **Mode MULTIJOUEUR PRIVÉ :** Salons fermés générés par code d'invitation ou QR Code, dédiés aux examens académiques des universités partenaires ou aux séminaires d'intégration d'entreprises.
* **Mode MULTIJOUEUR OUVERT :** Matchmaking public associant des joueurs de forces équivalentes au sein d'un classement mondial basé sur un score Elo de gestion et un système de ligues.

---

## 📊 2. Game Design, Écosystème de Marché & Moteur Économique

Le cœur algorithmique de BIZ Pulse simule un **marché à somme nulle** : le volume de demande capté par un joueur est directement soustrait du potentiel de conversion de ses concurrents directs. Toutes les variables de calcul sont centralisées côté serveur.

### 2.1. Catalogue des Produits & Gammes

L'apprenant sélectionne un produit technologique unique au lancement du scénario, ce qui reconfigure l'univers textuel et les cas pratiques de l'interface :

1. **Robot intelligent :** Axé sur l'automatisation industrielle, l'assistance technique et la performance d'usine.
2. **Drone intelligent :** Axé sur la logistique urbaine, l'inspection technique, la sécurité et l'agilité de livraison.
3. **Chaise intelligente :** Axée sur la santé posturale, l'ergonomie, la connectivité et la productivité au travail.

Chaque produit se déploie sur 3 gammes asymétriques :

* **Gamme Référence (Entrée de gamme) :** Produit de masse. Prix pivot recommandé : **800 TND** (Plancher de rejet prix à 500 TND, Plafond d'exclusion à 1100 TND).
* **Gamme Premium Accessible (Milieu de gamme) :** Équilibre qualité-prix. Prix moyen : **1850 TND**.
* **Gamme Prestige TECH (Haut de gamme) :** Innovation et statutaire. Prix moyen : **2950 TND**.

### 2.2. Les 3 Zones Macroéconomiques du Pays

La simulation découpe le marché national en trois territoires géographiques distincts :

| Indicateurs Structurels | 🔴 Zone 1 : Grand Centre Urbain | 🟡 Zone 2 : Hub Régional | 🟢 Zone 3 : Zone Périphérique |
| --- | --- | --- | --- |
| **Typologie Territoriale** | Métropolitaine / Masse | Intermédiaire / Corporate | Émergente / Grands Comptes |
| **Segmentation Client** | 45% B2C / 55% B2B Revendeurs | 30% B2C / 70% B2B PME | 10% B2C / 90% Grandes Entreprises |
| **Dispersion Géographique** | **Faible (Clients très concentrés)** | Moyenne | **Très Élevée (Clients très dispersés)** |
| **Logistique & Ventes** | Trajets courts, coûts logistiques bas | Flotte de livraison standard | Frais de couverture terrain élevés |
| **Préférence de Gamme** | Référence (80%) et Premium | Premium Accessible majoritaire | Prestige TECH exclusive (100%) |
| **Sensibilité Communication** | **Très Forte** (Saturation publicitaire) | **Forte** (Salons pro, démos) | **Moyenne** (Bouche-à-oreille, confiance) |
| **Risques Stratégiques** | Guerre des prix féroce, marges faibles | Ruptures de stock, pénalités | Obsolescence rapide, bad buzz |

### 2.3. Équations Fondamentales du Moteur Économique (Backend)

À chaque fin de trimestre $T$, pour une zone $z$ et une gamme $g$ données :

#### Demande Totale du Marché ($D_{\text{Total}}$)

$$D_{\text{Total}(z,g)} = (N_{\text{joueurs}} \times Base_{\text{Segment}(z,g)}) \times (1 + \text{Croissance}_{T(z)}) \times \text{Saisonnalité}_{T}$$

#### Score d'Attractivité Stratégique ($A_j$) du joueur $j$

Le score marketing prend en compte l'effort de branding et un coefficient de différenciation concurrentielle pour pénaliser la saturation d'un même axe de communication par trop de joueurs simultanés :


$$Score_{\text{Marketing\_Brut}} = (Score_{\text{Produit}} \times W_{\text{Prod}}) + (Score_{\text{Branding}} \times W_{\text{Brand}})$$

$$Score_{\text{Marketing\_Final}} = \text{clamp}\big((Score_{\text{Marketing\_Brut}} \times Coef_{\text{Diff\_Marketing}}) - Malus_{\text{Volatilité}} + \text{Mémoire}_{T-1}, 0, 100\big)$$

$$Coef_{\text{Diff\_Marketing}} = \frac{1}{1 + K_{\text{diff}} \times (Nb_{\text{Joueurs\_Même\_Axe}} - 1)}$$

L'attractivité finale croise l'indice du prix de vente net ($P_j$) et la synergie de la force de vente terrain :


$$A_j = \left( \left( \frac{1}{P_j} \right) \times \text{Sensibilité}_{\text{Prix}(z)} + Score_{\text{Marketing\_Final}} \times \text{Sensibilité}_{\text{Mkt}(z)} \right) \times Coef_{\text{Synergie}(j)}$$

#### Allocation des Ventes & Règle d'Or Logistique

$$PDM_j = \frac{A_j}{\sum_{k=1}^{N} A_k}$$

$$V_j = \min(D_{\text{Total}} \times PDM_j, \text{Stock Disponible}_j)$$

L'entrepôt possède une capacité recommandée fixe de **180 unités**. Si le stock d'invendus résiduels dépasse ce seuil en fin de tour, le moteur applique une pénalité financière et détruit **1%** du volume excédentaire par obsolescence ou détérioration physique :


$$\text{Frais de Surstockage}_j = \text{Stock}_{\text{Invendu}(j)} \times 5 \text{ TND}$$

$$\text{Unités Perdues} = \max(0, \text{Stock}_{\text{Invendu}(j)} - 180) \times 1\%$$

### 2.4. Algorithme de Rattrapage en Session ("Catch-up")

Pour préserver l'équité en multijoueur ouvert ou en cours magistral, tout joueur rejoignant une session après le Trimestre 1 bénéficie d'un alignement automatique calculé par le serveur :

* **Ajustement de Trésorerie :** Dotation en cash égale à la **médiane** de la trésorerie des joueurs actifs.
* **Mémoire Marketing :** Indexation de ses scores de notoriété sur la moyenne basse du marché pour lui permettre de concourir sans retard structurel.

---

## 🎨 3. UX/UI Mobile-First & Traduction Sémantique

L'interface applique la charte premium de bsuccess.tn : **Dark Mode d'entreprise (Fonds Marine `#0A0F1D`, Textes Blanc Mat `#E2E8F0`, Curseurs, titres et indicateurs majeurs Or `#D4AF37`)**.

### 3.1. Ergonomie "Nano Banana"

Tous les composants interactifs (curseurs de décision, sélecteurs d'axes) sont rassemblés sur le tiers inférieur de l'écran pour une manipulation exclusive au pouce. Les tableaux comptables denses sont remplacés par des jauges analytiques colorées claires, respectant la règle des 3 secondes pour la prise d'information.

### 3.2. Dictionnaire Adaptatif Dynamique

L'application filtre la complexité lexicale affichée au joueur selon son profil d'onboarding :

| Concept Macroéconomique | Profil Avancé / Pro | Profil Junior / Novice | Définition Tooltip (Bulle d'aide intégrée) |
| --- | --- | --- | --- |
| **Élasticité-Prix** | Élasticité-Prix | Sensibilité au Prix | "Mesure si vos clients fuient chez la concurrence dès que vous augmentez votre prix d'un dinar." |
| **Dispersion Terrain** | Couverture Commerciale / CAC | Difficulté des Ventes Terrain | "L'argent et le temps investis par vos équipes sur la route pour visiter et livrer vos clients." |
| **Densité Urbaine** | Taux d'Urbanisation | Concentration en Ville | "Le pourcentage de clients regroupés dans les métropoles denses par rapport aux zones rurales dispersées." |
| **Prix Plancher** | Seuil de pression prix | Seuil de tension concurrentielle | "Le prix minimal en dessous duquel le client rejette votre offre, suspectant une mauvaise qualité." |

---

## 💼 4. Ingénierie Commerciale & Monétisation SaaS B2B

BIZ Pulse structure ses revenus autour de parcours utilisateurs étanches selon le contexte d'accès.

### 4.1. Matrice des Offres et Fonctionnalités du Moteur

| Fonctionnalités du Moteur | 🔴 Solo Gratuit (B2C) | 🟡 BIZ Pass Premium (B2C) | 🏫 Licence Académique (B2B) | 💼 Licence Recrutement Pro (B2B RH) |
| --- | --- | --- | --- | --- |
| **Périmètre accessible** | **Zone 1 uniquement** | Zones 1, 2 et 3 | Zones 1, 2 et 3 | **Scénario d'Évaluation Dédié** |
| **Modes de Jeu** | Solo vs IA | Solo + Matchmaking Public | Salons Privés Promotion | Tournois / Sessions Entreprise |
| **Gestion de crise** | Jetons de Survie payants | Bourse & Négociations | Bourse & Négociations | **Pas de résurrection** (Crash définitif) |
| **Restitution** | Score de survie brut | Rapport individuel | Grille de notation Prof | **Dashboard Comparatif RH** |
| **Facturation** | Gratuit | 9.99 TND / mois | 15 à 25 TND / étudiant / an | **Paiement In-App ou Crédits Entreprise** |

### 4.2. Le Module "Recrutement Pro" : Évaluation RH 100% Automatisée

Ce module clé permet aux entreprises de tester des candidats en situation réelle.

* **Grille Tarifaire :** Pack PME (Jusqu'à 5 candidats) à **250 TND** / Pack Cabinet (Jusqu'à 20 candidats) à **800 TND**.
* **Difficulté Adaptative selon le Poste Cible :**
* *Profil Assistant / Junior :* Conditions de marché linéaires, pas de pannes logistiques, aides d'Emma Martin actives.
* *Profil Manager / Chef de Produit :* Capacité d'entrepôt réduite, taux de pièces non conformes en usine haussé à **8%**, volatilité modérée de la demande.
* *Profil Directeur / CFO / Executive :* Désactivation complète de la coach IA, forte volatilité macroéconomique, prix critiques changeants à chaque trimestre pour forcer un calcul rigoureux du BFR sous stress.



#### Workflow d'Automatisation Fin de Session ("Zero-Touch")

Dès que le candidat termine son scénario (ou fait faillite), le serveur s'exécute de manière autonome :

1. **Validation :** Blocage instantané de la partie. L'achat de jetons de survie est rendu structurellement impossible en mode recrutement.
2. **Compilation :** Le backend extrait la télémétrie UX (Soft Skills) et les rapports comptables (Hard Skills).
3. **Rapport Candidat :** Envoi par email d'un bilan pédagogique constructif et bienveillant valorisant ses forces de gestion.
4. **Rapport Recruteur Exclusif :** Expédition instantanée au responsable RH d'un **Rapport de Benchmarking Comparatif PDF** classant l'ensemble des candidats de la session selon leur vision systémique, leur profil DISC en jeu et leurs indices de triche.

---

## 🛠️ 5. Télémétrie Passive, Psychométrie & Architecture Technique

Pour garantir la sécurité et l'absence de triche, **l'intégralité des calculs macroéconomiques et des profils psychométriques s'exécute côté serveur**.

### 5.1. Variables de Télémétrie UX (Capture Transparente et Consentie)

Si et seulement si le joueur a validé la case d'autorisation RGPD (`telemetryConsent`), l'application journalise les variables d'interaction suivantes sous forme de buffers JSON légers transmis en fin de trimestre :

* `duration_decision_loop` : Temps passé en secondes sur le centre de décision avant envoi.
* `count_revision_inputs` : Nombre de modifications de valeurs d'un curseur avant sa validation (mesure l'hésitation ou l'impulsivité).
* `help_open_frequency` : Nombre d'ouvertures de l'icône d'aide ou des bulles de définitions sémantiques.
* `time_focus_by_department` : Répartition du temps de focus de l'écran entre les onglets Finance, Logistique, Marketing et RH.
* `std_dev_pricing_strategy` : Écart-type des variations de prix d'un tour à l'autre (mesure la constance stratégique).
* `reaction_time_overstock_alert` : Variable binaire mesurant si le joueur a réduit son plan de production au trimestre immédiatement consécutif au déclenchement de l'alerte surstock des 180 unités.

### 5.2. Algorithmes de Scoring Psychométriques

#### Modèle de Profilage DISC en Situation

* **D : Dominance :** Alimenté par une `duration_decision_loop` < 30s, des choix de réponses de quiz orientés vers la performance quantitative brute et des hausses agressives de production. Décrémenté par l'hyper-consultation des guides.
* **I : Influence :** Marqué par des investissements marketing supérieurs à **25%** des charges d'exploitation et par des choix de quiz privilégiant les relations publiques et la gestion de l'image de marque face aux crises.
* **S : Stabilité :** Capté par un `std_dev_pricing_strategy` proche de zéro (constance des prix) et par des choix de réponses axés sur la médiation humaine et la recherche de consensus inter-départements.
* **C : Conformité :** Indexé sur le temps de focus approfondi des dashboards comptables, l'ouverture systématique des aides intégrées et le respect millimétré des contraintes logistiques d'entrepôt (maintien du stock sous les 180 unités).

#### Modèle d'Intelligence Émotionnelle (Modèle Genos)

* **Connaissance de soi :** Corrélation objective entre l'auto-évaluation initiale du niveau business faite à l'inscription et la rentabilité financière réelle (ROI) obtenue en fin de session.
* **Conscience des autres :** Temps passé à analyser l'onglet RH et le profil asymétrique des clients par zone avant de soumettre son plan d'approvisionnement.
* **Authenticité :** Mesure de cohérence fonctionnelle entre l'Axe Marketing sélectionné à l'écran et la nature réelle des arguments commerciaux activés sur le terrain pour la force de vente.
* **Raisonnement émotionnel :** Capacité à intégrer des facteurs éthiques ou environnementaux (Sourcing RSE) au sein d'arbitrages de coûts complexes, sans exclure les indicateurs de rentabilité.
* **Gestion de soi :** Évaluation de la maîtrise émotionnelle sous stress. Si la trésorerie frôle la zone critique, un nombre de révisions d'inputs (`count_revision_inputs`) faible indique un excellent contrôle des impulsions.
* **Capacité à inspirer la performance :** Mesurée par sa capacité à maintenir une trajectoire de croissance stable de ses parts de marché tout en stabilisant les conflits internes de ses directeurs de filiales.

#### Algorithme du Score de Confiance du Profil ($SC$)

Pour s'assurer de la fiabilité de la typologie comportementale transmise aux recruteurs, le système applique l'équation suivante :


$$SC = \left( \frac{\text{Trimestres Validés}}{\text{Trimestres Totaux}} \times 0.40 \right) + \left( \frac{\text{Quiz Répondus}}{\text{Quiz Totaux}} \times 0.30 \right) + \left( \text{Cohérence}_{\text{Télémétrie-Quiz}} \times 0.30 \right)$$

---

## 💻 7. Architecture Technique de Référence (Flutter Codebase)

L'implémentation logicielle suit une structure **Feature-First** stricte inspirée de la *Clean Architecture*. La couche de présentation (*Presentation*) dépend exclusivement de la couche domaine (*Domain*), assurant une étanchéité absolue vis-à-vis de la couche de données (*Data*).

> 📝 **Note de Livraison :**
> Les composants de code ci-dessous constituent un **socle Clean Architecture avancé, prêt pour implémentation production après validation des contrats API et des tests**.

### 7.1. Le Modèle de Profilage Utilisateur : `user_profile_model.dart`

```dart
// lib/features/onboarding/data/models/user_profile_model.dart

import '../../../../core/domain/session/session_purpose.dart';

enum StudySpecialty { marketing, commercial, finance, logistics, production, rd, hr, quality, generalManagement, beginner }
enum BusinessLevel { novice, intermediate, advanced, expert }
enum ReadingPreference { simplified, professional, expert }
enum GameObjective { discover, deepen, prepareProject, improveManagement, assessment, recruitment, justForFun }
enum AgeGroup { under16, from16To18, from19To25, from26To35, over35 }

class UserProfileModel {
  final String userId;
  final String username;
  final AgeGroup ageGroup;
  final String educationLevel;
  final StudySpecialty specialty;
  final BusinessLevel businessLevel;
  final ReadingPreference readingPreference;
  final GameObjective objective;
  final SessionPurpose sessionPurpose;
  final String selectedProductId;
  final String selectedProductName;
  final String languageCode;
  final bool telemetryConsent;
  final bool psychometricConsent;
  final DateTime syncedAt;
  final String? organizationId; // Requis pour l'usage Corporate B2B RH
  final String? cohortId;       // Requis pour l'usage Académique

  const UserProfileModel({
    required this.userId,
    required this.username,
    required this.ageGroup,
    required this.educationLevel,
    required this.specialty,
    required this.businessLevel,
    required this.readingPreference,
    required this.objective,
    required this.sessionPurpose,
    required this.selectedProductId,
    required this.selectedProductName,
    required this.languageCode,
    required this.telemetryConsent,
    required this.psychometricConsent,
    required this.syncedAt,
    this.organizationId,
    this.cohortId,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    if (json['userId'] == null || (json['userId'] as String).trim().isEmpty) {
      throw const FormatException("Sécurité Onboarding : 'userId' critique manquant.");
    }
    if (json['syncedAt'] == null) {
      throw const FormatException("Sécurité Synchronisation : 'syncedAt' serveur requis.");
    }
    if (json['sessionPurpose'] == null) {
      throw const FormatException("Sécurité Contexte : 'sessionPurpose' obligatoire absent.");
    }

    return UserProfileModel(
      userId: json['userId'] as String,
      username: json['username'] as String? ?? 'Candidat Anonyme',
      ageGroup: _parseEnum(AgeGroup.values, json['ageGroup'], AgeGroup.from19To25),
      educationLevel: json['educationLevel'] as String? ?? 'Non renseigné',
      specialty: _parseEnum(StudySpecialty.values, json['specialty'], StudySpecialty.beginner),
      businessLevel: _parseEnum(BusinessLevel.values, json['businessLevel'], BusinessLevel.novice),
      readingPreference: _parseEnum(ReadingPreference.values, json['readingPreference'], ReadingPreference.simplified),
      sessionPurpose: SessionPurpose.values.firstWhere(
        (e) => e.name == json['sessionPurpose'],
        orElse: () => throw FormatException("Parsing bloqué - Contexte Session inconnu: ${json['sessionPurpose']}"),
      ),
      objective: _parseEnum(GameObjective.values, json['objective'], GameObjective.discover),
      selectedProductId: json['selectedProductId'] as String? ?? '',
      selectedProductName: json['selectedProductName'] as String? ?? '',
      languageCode: json['languageCode'] as String? ?? 'fr',
      telemetryConsent: json['telemetryConsent'] as bool? ?? false,
      psychometricConsent: json['psychometricConsent'] as bool? ?? false,
      syncedAt: DateTime.parse(json['syncedAt'] as String),
      organizationId: json['organizationId'] as String?,
      cohortId: json['cohortId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'username': username,
    'ageGroup': ageGroup.name,
    'educationLevel': educationLevel,
    'specialty': specialty.name,
    'businessLevel': businessLevel.name,
    'readingPreference': readingPreference.name,
    'objective': objective.name,
    'sessionPurpose': sessionPurpose.name,
    'selectedProductId': selectedProductId,
    'selectedProductName': selectedProductName,
    'languageCode': languageCode,
    'telemetryConsent': telemetryConsent,
    'psychometricConsent': psychometricConsent,
    'syncedAt': syncedAt.toIso8601String(),
    'organizationId': organizationId,
    'cohortId': cohortId,
  };
}

T _parseEnum<T extends Enum>(List<T> values, dynamic rawValue, T fallback) {
  if (rawValue == null) return fallback;
  return values.firstWhere((e) => e.name == rawValue, orElse: () => fallback);
}

```

### 7.2. Le Modèle de Rapport Financier Complet : `financial_report_model.dart`

```dart
// lib/features/game_session/data/models/financial_report_model.dart

import '../../domain/entities/financial_report.dart';

class FinancialReportModel extends FinancialReport {
  const FinancialReportModel({
    required super.revenue,
    required super.cogs,
    required super.grossMargin,
    required super.ebitda,
    required super.netProfit,
    required super.roi,
    required super.cash,
    required super.debt,
    required super.liquidityRatio,
    required super.workingCapitalRequirement,
    required super.selfFinancingCapacity,
    required super.marketShare,
  });

  factory FinancialReportModel.fromJson(Map<String, dynamic> json) {
    return FinancialReportModel(
      revenue: (json['revenue'] as num? ?? 0.0).toDouble(),
      cogs: (json['cogs'] as num? ?? 0.0).toDouble(),
      grossMargin: (json['grossMargin'] as num? ?? 0.0).toDouble(),
      ebitda: (json['ebitda'] as num? ?? 0.0).toDouble(),
      netProfit: (json['netProfit'] as num? ?? 0.0).toDouble(),
      roi: (json['roi'] as num? ?? 0.0).toDouble(),
      cash: (json['cash'] as num? ?? 0.0).toDouble(),
      debt: (json['debt'] as num? ?? 0.0).toDouble(),
      liquidityRatio: (json['liquidityRatio'] as num? ?? 0.0).toDouble(),
      workingCapitalRequirement: (json['workingCapitalRequirement'] as num? ?? 0.0).toDouble(),
      selfFinancingCapacity: (json['selfFinancingCapacity'] as num? ?? 0.0).toDouble(),
      marketShare: (json['marketShare'] as num? ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'revenue': revenue,
    'cogs': cogs,
    'grossMargin': grossMargin,
    'ebitda': ebitda,
    'netProfit': netProfit,
    'roi': roi,
    'cash': cash,
    'debt': debt,
    'liquidityRatio': liquidityRatio,
    'workingCapitalRequirement': workingCapitalRequirement,
    'selfFinancingCapacity': selfFinancingCapacity,
    'marketShare': marketShare,
  };

  FinancialReport toEntity() {
    return FinancialReport(
      revenue: revenue, cogs: cogs, grossMargin: grossMargin, ebitda: ebitda,
      netProfit: netProfit, roi: roi, cash: cash, debt: debt, liquidityRatio: liquidityRatio,
      workingCapitalRequirement: workingCapitalRequirement, selfFinancingCapacity: selfFinancingCapacity, marketShare: marketShare,
    );
  }
}

```

### 7.3. Les États du BLoC/Cubit : `game_session_state.dart`

```dart
// lib/features/game_session/presentation/cubit/game_session_state.dart

import '../../domain/entities/financial_report.dart';
import '../../domain/entities/game_alert.dart';

abstract class GameSessionState {}

class GameSessionInitial extends GameSessionState {}

class GameSessionLoading extends GameSessionState {
  final String message;
  GameSessionLoading(this.message);
}

class GameSessionActive extends GameSessionState {
  final int currentQuarter;
  final int stockUnits;
  final FinancialReport financialReport;
  final List<GameAlert> activeAlerts;
  final bool allowSurvivalToken;
  final String? organizationId;
  final String? cohortId;

  GameSessionActive({
    required this.currentQuarter,
    required this.stockUnits,
    required this.financialReport,
    required this.activeAlerts,
    required this.allowSurvivalToken,
    this.organizationId,
    this.cohortId,
  });
}

class GameSessionBankruptcy extends GameSessionState {
  final int failedQuarter;
  final FinancialReport financialReport; 
  final bool allowSurvivalToken;
  final String? organizationId;
  final String? cohortId;

  GameSessionBankruptcy({
    required this.failedQuarter,
    required this.financialReport, 
    required this.allowSurvivalToken,
    this.organizationId,
    this.cohortId,
  });
}

class GameSessionFailure extends GameSessionState {
  final String message;
  GameSessionFailure(this.message);
}

```

### 7.4. Le Contrôleur de Session : `game_session_cubit.dart`

```dart
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

```
