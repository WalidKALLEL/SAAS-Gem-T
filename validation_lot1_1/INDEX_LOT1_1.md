# Validation Lot 1.1 - Corrections ciblées

Date : 2026-07-04

Ce dossier documente uniquement les corrections Lot 1.1 demandées après validation technique du Lot 1.

## Corrections appliquées

- Création de compte : ouverture automatique de session et passage direct vers `Bienvenue`.
- Connexion conservée pour les joueurs déjà inscrits, déconnectés ou en reprise de session.
- Dashboard initial corrigé avec les données métier validées.
- Séparation explicite :
  - `initialDashboardData`
  - `postTurnDemoDashboardData`
- KPI `Productivité` retiré du premier dashboard.
- KPI `Progression de la mission` ajouté au démarrage.
- Règle d'applicabilité KPI ajoutée : actif, non mesurable, verrouillé, disponible après condition, disponible après un tour.
- KPI non mesurables affichés sans fausse valeur, avec aide explicative accessible.
- Grille mobile compacte pour les KPI prioritaires : Trésorerie, Résultat, Chiffre d'affaires, Stock.
- Bloc `Que faire maintenant ?` conservé comme données de démonstration centralisées avec note technique.

## Captures avant

- `captures/before/01_before_dashboard_mobile_light.png`
- `captures/before/02_before_dashboard_mobile_dark.png`
- `captures/before/03_before_dashboard_tablet_light.png`

## Captures après demandées

- `captures/after/01_initial_dashboard_mobile_light.png`
- `captures/after/02_initial_dashboard_mobile_dark.png`
- `captures/after/03_initial_dashboard_tablet_light.png`
- `captures/after/04_post_turn_demo_dashboard_mobile_light.png`
- `captures/after/05_kpi_non_measurable_help_mobile.png`
- `captures/after/06_create_account_to_welcome.png`

## Données initiales représentées

- Capital souscrit : 10 000 TND.
- Capital libéré : 3 000 TND.
- Capital restant à libérer : 7 000 TND.
- Trésorerie disponible : 3 000 TND.
- Chiffre d'affaires : 0 TND.
- Résultat : 0 TND.
- Ventes : 0 unité.
- Stock : 0 unité.
- Dettes : 0 TND.
- Créances : 0 TND.
- Machines : 0.
- Salariés : 0.
- Local loué : 30 m².
- Zone active : 1.

## Sauvegarde

Sauvegarde complète avant Lot 1.1 :

`/Users/apple/Documents/Codex/2026-07-02/je-s/outputs/_backups_lot1_1/biz-pulse-player-portal-flutter-before-lot1-1-20260704`

## Commandes de vérification

Depuis la racine du projet Flutter :

```bash
../../.tools/flutter/bin/flutter analyze
../../.tools/flutter/bin/flutter test
../../.tools/flutter/bin/flutter test --update-goldens test/player_onboarding_screenshots_test.dart
../../.tools/flutter/bin/flutter test --update-goldens validation_lot1_1/tools/capture_lot1_1_states_test.dart
```

## Hors périmètre conservé

Non développé dans ce lot :

- autres directions ;
- abonnements ;
- publicités ;
- moteur de calcul ;
- vue experte ;
- rapport final.
