# Lot 1 — Refonte UX/UI du parcours de première prise en main

## Périmètre réalisé

Le lot couvre uniquement le parcours de première prise en main du Portail Joueur :

1. Créer un compte
2. Se connecter
3. Bienvenue, entrepreneur du futur
4. Définir son objectif d’apprentissage
5. Créer son entreprise
6. Choisir la famille de produits
7. Confirmer le choix du produit
8. Découvrir la mission du premier tour
9. Comprendre comment fonctionne un tour
10. Visite guidée courte
11. Dashboard simplifié du Tour 1

Aucun lien vers le Portail Administrateur n’a été ajouté. Le dashboard reste volontairement simple et ne développe pas les directions métier complètes.

## Choix UX effectués

- Réduction des textes principaux : chaque écran se limite à un titre fort, une phrase courte, une illustration et une action principale.
- Divulgation progressive : le joueur avance écran par écran, sans exposition anticipée aux directions complètes.
- Flux obligatoire respecté : création du compte, connexion, bienvenue, objectif, entreprise, produit, confirmation, mission, fonctionnement du tour, visite guidée, dashboard simple.
- Création de compte complétée : prénom ou pseudo, email, mot de passe, confirmation et acceptation des conditions.
- Objectif joueur étendu : six objectifs illustrés et une question d’expérience business game.
- Entreprise enrichie : slogan facultatif et aperçu de carte entreprise.
- Lisibilité renforcée : titres, textes courants, labels, boutons et champs respectent mieux les seuils smartphone/tablette.
- Progression visible : tablette avec états Terminé, Actif, À venir, Verrouillé et Facultatif ; smartphone avec “Étape X sur 11” et liste complète en feuille basse.
- COACH BIZ flottant : composant plus visible, panneau d’aide, lecture audio sémantique, consignes, tutoriel court et écoute éventuelle.
- Photos business intégrées : bureaux, incubateur, usine intelligente, boardroom et cockpit analytique remplacent les visuels trop abstraits.
- Icônes contextuelles : chaque scène affiche des signaux visuels liés à l’action en cours sans alourdir l’écran.
- Choix produits visuels : chaque famille possède une illustration distincte, des usages, un bouton d’information, et une sélection animée.
- Confirmation produit : grand visuel produit, résumé, objectif lié et avertissement sur le caractère définitif du choix.
- Mission Tour 1 : trois blocs maximum, objectif, moyens disponibles et actions à réaliser.
- Fonctionnement d’un tour : cinq étapes illustrées, analyser, décider, confirmer, passer le tour, comprendre les résultats.
- Visite guidée : huit repères maximum avec suivant, retour, passer la visite et terminer.
- Dashboard simple renforcé : en-tête entreprise, Tour 1, temps restant, notifications, vue simple, vue experte verrouillée, 8 KPI, directions verrouillées et actions contextuelles.
- Aide KPI : chaque KPI dispose d’un bouton “i” avec définition, importance, interprétation, facteurs, KPI liés, erreur fréquente, exemple et question de réflexion.
- Constantes applicatives : `APP_NAME = "Biz Pulse"` et `CHECK_IN = "Check-in"` sont centralisés.
- Palette business premium : noir BIZ, or adouci, bleu confiance, vert progression sobre, violet innovation profond et turquoise maîtrisé.
- Réduction des couleurs trop ludiques : opacités plus faibles, fonds moins saturés, assistant BIZ plus discret.
- Micro-interactions : transitions d’écrans, sélection animée, feedback positif immédiat, progression visuelle.
- Accessibilité : zones tactiles Material, contraste renforcé, labels sémantiques, icônes associées aux couleurs, support clair/sombre.

## Captures générées

- `screenshots/mobile_contact_sheet.png`
- `screenshots/tablet_contact_sheet.png`
- `screenshots/dark_mobile_contact_sheet.png`
- Captures individuelles dans `screenshots/`
- Comparaison de cette exécution dans `screenshots/before_lot1_dev/` et `screenshots/after_lot1_dev/`

## Vérifications

- `flutter analyze` : aucun problème.
- `flutter test` : tous les tests passent.
- Captures golden : 11 écrans mobile clair, 11 écrans tablette clair, 11 écrans mobile sombre.

## Arrêt

Le lot s’arrête ici et attend validation officielle avant toute interface suivante.
