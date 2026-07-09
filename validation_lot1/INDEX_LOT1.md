# Validation Lot 1 - Onboarding Biz Pulse

Date de préparation : 2026-07-03

Ce dossier sert uniquement à la validation visuelle, ergonomique et fonctionnelle du Lot 1. Aucun écran supplémentaire n'a été développé pour le produit final pendant cette préparation.

## 1. Parcours complet

Séquence Flutter actuelle :

| Ordre | Écran | Interaction principale | Retours et interactions secondaires | Feedback / transition |
|---:|---|---|---|---|
| 1 | Créer un compte | `Créer mon compte` | `J'ai déjà un compte` vers Connexion | Validation des champs obligatoires, acceptation des conditions, confirmation puis Connexion |
| 2 | Connexion | `Se connecter` | `Créer un compte`, lien `Mot de passe oublié ?` visible | Confirmation `Connexion confirmée.` puis Bienvenue |
| 3 | Bienvenue | `Commencer l'expérience` | `Écouter le message` ouvre une feuille d'aide | Transition vers Objectif |
| 4 | Objectif | `Continuer` | Retour vers Bienvenue, choix objectif + niveau d'expérience | Confirmation de sélection |
| 5 | Entreprise | `Créer mon entreprise` | Retour vers Objectif | Prévisualisation de la carte entreprise |
| 6 | Produit | `Confirmer ce produit` | Retour vers Entreprise, aide produit, comparaison | Sélection animée + feedback positif |
| 7 | Confirmation | `Confirmer mon choix` | `Comparer les produits` depuis l'écran précédent | Avertissement de choix définitif, transition Mission |
| 8 | Mission | `Commencer la mission` | `Écouter le briefing`, retour Confirmation | Message de mission en 3 blocs courts |
| 9 | Fonctionnement du tour | `Faire la visite` | Retour Mission | Explication en 5 étapes : analyser, décider, confirmer, passer le tour, comprendre |
| 10 | Visite guidée | `Suivant` / `Terminer` | `Retour`, `Passer la visite` | Progression interne sur 8 points |
| 11 | Dashboard simple | Fin du lot | Retour Visite, aide KPI, notification, vue experte verrouillée | Dashboard simplifié, directions visibles mais verrouillées |

La démonstration visuelle est disponible dans :

- `captures/contact_sheets/mobile_light_contact_sheet.png`
- `captures/contact_sheets/mobile_dark_contact_sheet.png`
- `captures/contact_sheets/tablet_light_contact_sheet.png`

## 2. Captures individuelles

Les 33 captures individuelles taille réelle sont dans `captures/screens/`.

Dimensions :

- Smartphone clair : `390 x 844`
- Smartphone sombre : `390 x 844`
- Tablette claire : `834 x 1112`

Nomenclature :

- `01_create_account_mobile_light.png`
- `01_create_account_mobile_dark.png`
- `01_create_account_tablet_light.png`
- ...
- `11_dashboard_mobile_light.png`
- `11_dashboard_mobile_dark.png`
- `11_dashboard_tablet_light.png`

## 3. États particuliers

Les captures d'états sont dans `captures/states/`.

| État | Fichier |
|---|---|
| Coach Biz avec notification | `captures/states/01_coach_biz_with_notification.png` |
| Coach Biz ouvert | `captures/states/02_coach_biz_open.png` |
| Lecture simulée en cours | `captures/states/03_coach_biz_reading_simulated.png` |
| Coach Biz fermé | `captures/states/04_coach_biz_closed.png` |
| Formulaire avec clavier mobile simulé | `captures/states/05_mobile_keyboard_form_focus.png` |
| Erreur de validation formulaire | `captures/states/06_form_validation_error.png` |
| Produit sélectionné | `captures/states/07_product_selected.png` |
| Confirmation produit | `captures/states/08_product_confirmation.png` |
| Aide KPI ouverte smartphone | `captures/states/09_kpi_help_mobile.png` |
| Aide KPI ouverte tablette | `captures/states/10_kpi_help_tablet.png` |
| Dashboard avec alertes | `captures/states/11_dashboard_with_alerts.png` |
| Vue experte visible mais verrouillée | `captures/states/12_expert_view_locked.png` |

Note : le clavier mobile est simulé par `viewInsets` Flutter dans un test widget. Le clavier système réel n'est pas rendu par `flutter_test`.

## 4. Audit du Dashboard Simple

| KPI | Icône Flutter | Valeur | Unité | Évolution | Statut | Explication courte | Action disponible |
|---|---|---:|---|---|---|---|---|
| Trésorerie | `account_balance_wallet_rounded` | 42.5 | kDT | +3% | Sain | Montant disponible pour financer les prochaines décisions. | Bouton info : aide KPI + question de réflexion |
| Chiffre d'affaires | `payments_rounded` | 18.2 | kDT | +8% | En hausse | Total des ventes générées sur la période. | Bouton info : aide KPI + question de réflexion |
| Résultat | `query_stats_rounded` | 2.4 | kDT | +4% | À consolider | Écart entre les revenus et les coûts du tour. | Bouton info : aide KPI + question de réflexion |
| Ventes | `shopping_bag_rounded` | 128 | unités | +12% | Dynamique | Nombre d'unités vendues pendant le tour. | Bouton info : aide KPI + question de réflexion |
| Stock | `inventory_2_rounded` | 74 | unités | -6% | À suivre | Quantité disponible pour répondre aux prochaines ventes. | Bouton info : aide KPI + question de réflexion |
| Satisfaction client | `sentiment_satisfied_alt_rounded` | 82 | /100 | +5 pts | Solide | Perception client de la valeur reçue. | Bouton info : aide KPI + question de réflexion |
| Part de marché | `pie_chart_rounded` | 7.8 | % | +0.8 pt | En progrès | Position de l'entreprise dans le marché simulé. | Bouton info : aide KPI + question de réflexion |
| Productivité | `precision_manufacturing_rounded` | 68 | /100 | +4 pts | Correct | Capacité à produire efficacement avec les ressources disponibles. | Bouton info : aide KPI + question de réflexion |

KPI visibles avant défilement :

- Smartphone : 1 KPI complet visible, avec le début du suivant après défilement.
- Tablette : 3 KPI complets visibles, avec le début du 4e.

Alertes :

- Les alertes sont regroupées sous `Alertes prioritaires`.
- Ordre actuel : `Stock à surveiller`, puis `Cash disponible`.
- La notification du header synthétise ces deux alertes dans une feuille basse.
- Le statut ne dépend pas uniquement de la couleur : chaque alerte a un titre, une icône et une explication.

Bloc `Que faire maintenant ?` :

- Généré pour l'instant depuis une liste de démonstration statique.
- Actions affichées : `Consulter une alerte`, `Préparer une commande`, `Vérifier la trésorerie`.
- Le moteur de calcul n'est pas connecté dans ce lot, donc ces actions ne sont pas encore personnalisées par simulation réelle.

## 5. Audit des visuels

Photos conservées :

- `assets/brand/biz-pulse-logo.png`
- `assets/onboarding/strategy-office.png`
- `assets/onboarding/incubator.png`
- `assets/onboarding/boardroom.png`
- `assets/onboarding/smart-factory.png`
- `assets/onboarding/analytics-cockpit.png`

Photos remplacées :

- Aucune photo n'a été remplacée pendant la préparation de ce dossier de validation.
- Les visuels génériques/incohérents ont été évités dans le Lot 1 en utilisant les cinq photos métier existantes.

Illustrations ajoutées ou utilisées dans Flutter :

- Identité / compte
- Rocket / bienvenue
- Objectif
- Entreprise
- Produits
- Mission
- Fonctionnement du tour
- Visite guidée
- Dashboard

Icônes ajoutées ou utilisées :

- `psychology_alt_rounded`, `route_rounded`, `trending_up_rounded`, `account_balance_wallet_rounded`, `handshake_rounded`, `auto_awesome_rounded`, `groups_rounded`
- `flight_takeoff_rounded`, `smart_toy_rounded`, `chair_rounded`
- `flag_rounded`, `timer_rounded`, `navigation_rounded`, `speed_rounded`, `info_rounded`, `tune_rounded`, `verified_rounded`, `skip_next_rounded`
- `notifications_active_rounded`, `lock_rounded`, `dashboard_rounded`

Visuels produits :

- Drone intelligent : illustration produit dédiée avec forme aérienne et rotors.
- Robot professionnel intelligent : illustration produit dédiée avec corps robotisé.
- Chaise multifonction intelligente : illustration produit dédiée avec silhouette de chaise.

Confirmation : les trois familles possèdent des visuels clairement distincts.

## 6. Responsive

Smartphone :

- Parcours en colonne unique.
- Stepper horizontal compact.
- CTA principal en bas de chaque écran.
- Coach Biz flottant en bas à droite.
- Cartes produit empilées.
- Dashboard en une colonne.

Tablette :

- Mise en page à deux zones : panneau marque/progression à gauche, contenu à droite.
- Stepper vertical.
- Visuels plus larges.
- Dashboard en grille de 2 colonnes pour les KPI.
- Coach Biz reste flottant, libellé `COACH BIZ`.

Mode clair :

- Fond principal très légèrement coloré.
- Cartes blanches, bordures douces, accents bleu/or/vert/violet.

Mode sombre :

- Structure sombre contrôlée par le Design System.
- Visuels et chips conservés.
- Contraste renforcé sur les textes et boutons.

Éléments vérifiés :

- Navigation : flux complet + retours.
- Stepper : horizontal mobile, vertical tablette.
- Cartes : objectifs, produits, KPI.
- Formulaires : compte, connexion, entreprise.
- Coach Biz : visible, ouvert, notification, lecture simulée.
- Feuilles d'aide : produit, mission, KPI, vue experte verrouillée.
- CTA : un CTA principal par écran.
- Dashboard : header, sélecteur simple/expert, KPI, actions, alertes, directions verrouillées.

## 7. Accessibilité

Résultats vérifiés :

- Contrastes : palette Design System avec textes foncés/clairs et surfaces distinctes. Pas de test automatisé WCAG encore branché.
- Zones tactiles : Coach Biz min. 48 px, sélecteur dashboard 44 px, boutons et icônes interactives avec zones adaptées.
- Labels accessibles : logo, images d'étape, Coach Biz, boutons info et boutons de thème/langue exposent des labels ou tooltips.
- Ordre de lecture : colonne logique sur smartphone ; tablette avec progression à gauche puis contenu principal.
- Lecteur d'écran : `Semantics` sur Coach Biz et illustrations, `SemanticsService.announce` pour la lecture simulée.
- Réduction des animations : non automatisée dans ce lot. Les animations sont courtes, mais aucun réglage explicite `reduce motion` n'est encore implémenté.
- Statuts sans dépendance couleur : KPI et alertes combinent texte, icône, valeur et libellé de statut.

## 8. Tests

Tests du Lot 1 exécutés : `41` tests OK.

Catégories :

- Navigation : parcours complet compte -> dashboard.
- Formulaires : champs obligatoires, acceptation des conditions, accès connexion.
- Onboarding : bienvenue, objectif, entreprise, mission, tour, visite guidée.
- Produit : sélection, aide produit, confirmation.
- Coach Biz : bouton visible, panneau pédagogique, actions principales.
- Responsive : 11 captures smartphone clair, 11 smartphone sombre, 11 tablette claire.
- Golden tests : 33 captures validées.
- Accessibilité : couverture indirecte par semantics/tooltips dans les widgets ; pas encore d'audit WCAG automatisé.
- Reprise de session : reprise technique par `initialStep` couverte partiellement dans les tests ; persistance réelle non implémentée.

Tests complémentaires du dossier de validation :

- `6` tests de capture d'états particuliers OK via `validation_lot1/tools/capture_validation_states_test.dart`.

Aspects non encore couverts automatiquement :

- Contraste WCAG chiffré.
- Navigation clavier exhaustive tablette.
- Test lecteur d'écran réel iOS/Android.
- Persistance réelle de session.
- Test d'intégration sur appareils physiques.

## 9. Livraison portable

Chemin relatif du dossier :

- `validation_lot1/`

Contenu principal :

- `validation_lot1/INDEX_LOT1.md`
- `validation_lot1/MANIFEST_LOT1.md`
- `validation_lot1/captures/screens/`
- `validation_lot1/captures/states/`
- `validation_lot1/captures/contact_sheets/`
- `validation_lot1/tools/capture_validation_states_test.dart`

Sauvegarde avant Lot 1 :

- `/Users/apple/Documents/Codex/2026-07-02/je-s/outputs/_backups_lot1_dev/biz-pulse-player-portal-flutter-before-lot1-dev-20260703`

Instructions depuis la racine du projet Flutter :

```bash
cd outputs/biz-pulse-player-portal-flutter
../../.tools/flutter/bin/flutter run -d chrome
../../.tools/flutter/bin/flutter analyze
../../.tools/flutter/bin/flutter test
../../.tools/flutter/bin/flutter test --update-goldens test/player_onboarding_screenshots_test.dart
../../.tools/flutter/bin/flutter test --update-goldens validation_lot1/tools/capture_validation_states_test.dart
```

## 10. Clarification sur `mobile_contact_sheet.png`

Il ne s'agit pas d'une erreur de contenu.

- `screenshots/mobile_contact_sheet.png` est la version courante de travail.
- `screenshots/after_lot1_dev/mobile_contact_sheet.png` est une copie figée pour comparaison avant/après.
- `validation_lot1/captures/contact_sheets/mobile_light_contact_sheet.png` est la copie portable utilisée dans ce dossier.

Donc le fichier apparaît plusieurs fois parce qu'il existe sous trois rôles différents : courant, archive après Lot 1, livraison portable.
