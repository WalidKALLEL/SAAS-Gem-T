Markdown
# Spécifications UX/UI & Parcours Écrans — BIZ Pulse

## 1. Principes Ergonomiques & Design System

### 1.1 Palette de Couleurs & Accessibilité
- `COLOR_BG` = `#0A0F1D` (Marine Profond Mat - Fond de l'application)
- `COLOR_CARD` = `#161F38` (Bleu Nuit Surélevé - Cartes et containers)
- `COLOR_TEXT` = `#E2E8F0` (Blanc Mat - Lisibilité et forts contrastes)
- `COLOR_PRIMARY` = `#D4AF37` (Or Premium - Boutons critiques, indicateurs positifs)
- `COLOR_ALERT` = `#EF4444` (Rouge Écarlate - Alertes de faillite, surproduction)

### 1.2 Concepts de Navigation
- **Audit en 3 Secondes :** Remplacement des grilles de données par des anneaux de progression interactifs.
- **Zone Nano Banana :** Concentration des sliders de décision sur les 35% inférieurs de l'écran pour un usage exclusif à une seule main.
- **Micro-interactions Haptiques :** Chaque déplacement de slider ou validation de trimestre déclenche une micro-vibration du smartphone (feedback physique de l'action).

---

## 2. Descriptif des Écrans Majeurs (Wireframes Textuels)

### Écran 1 : Le Hub Principal & Connexion (`hub_screen.dart`)
Cet écran gère l'accueil de l'utilisateur, l'affichage de son profil de compétences et l'aiguillage vers les modes de jeu autonomes.

```text
+-------------------------------------------------------------+
| [Top]    [Logo Bbsuccess.tn - Or #D4AF37]                   |
|          Profil : @WalidK_Tunis | Rang : Ligue Élite        |
|          Score ELO actuel : 1 845 pts                       |
+-------------------------------------------------------------+
| [Middle] Menu Principal (B2C & B2B)                         |
|                                                             |
|          [🏆 MODE 1 : ENTRAÎNEMENT SOLO VS IA]              |
|          -> Reprendre Niveau 4 : Gestion de Crise          |
|                                                             |
|          [👥 MODE 3 : ARÈNE GLOBALE MULTIJOUEUR]           |
|          -> Créer ou Intégrer une session active (Max T10)  |
|                                                             |
|          -------------------------------------------------  |
|          (Si l'utilisateur est un Recruteur B2B identifié) :|
|          [💼 COCKPIT RECRUTEUR RH - CONFIGURATEUR]          |
|          -> Lancer un Assessment Center (20-25 Tours)       |
+-------------------------------------------------------------+
| [Bottom] Paramètres utilisateur :                           |
|          [⚙️ Configuration des Notifications & Rappels de Tour]|
+-------------------------------------------------------------+
Interactions : Un clic sur "Configuration des Notifications" ouvre un tiroir permettant au joueur de choisir ses préférences (ex: "Me rappeler de jouer mon tour toutes les 4 heures").

Écran 2 : Le Tableau de Bord Stratégique (dashboard_screen.dart)
L'écran de contrôle principal où s'effectue l'audit financier et logistique en cours de partie.

Plaintext
+-------------------------------------------------------------+
| [Top]    [Trimestre 4 / 25]               [⌛ Chrono : 04:12] |
|          Trésorerie Disponible : 142 500 TND                |
+-------------------------------------------------------------+
| [Middle] Les 3 Jauges Néon (Audit Visuel en 3 secondes)     |
|                                                             |
|    ( TRÉSORERIE )       ( PARTS MARCHÉ )      ( STOCK USINE )|
|      142.5K TND               24%               110 / 180   |
|     [Jauge Verte]        [Jauge Or]          [Jauge Orange] |
|                                                             |
|    -----------------------------------------------------    |
|    [📊 Section Graphique Déployée au Toucher]               |
|    Graphique en courbes lissées (Croisement des indicateurs)|
|    - Courbe Or : EBITDA  | - Courbe Rouge : BFR avancé      |
|    - Courbe Verte : Capacité d'Autofinancement (CAF)        |
|                                                             |
|    [💬 Message Emma Martin : "Attention au stockage !"]     |
+-------------------------------------------------------------+
| [Bottom] Zone Nano Banana :                                 |
|          [▲ SWIPE UP : PRENDRE MES DÉCISIONS (SLIDERS) ▲]   |
+-------------------------------------------------------------+
Interactions Fondamentales :

Tapoter sur "Stock Usine" fait clignoter le graphique en rouge si la valeur flirte avec la limite critique des 180 unités maximales.

Faire glisser son doigt le long des courbes lissées affiche une infobulle avec les chiffres comptables exacts du trimestre sélectionné.

Écran 3 : Le Panneau d'Arbitrage au Pouce (decision_panel.dart)
Ce panneau coulisse depuis le bas de l'écran après un Swipe Up et se superpose au Dashboard pour les saisies financières.

Plaintext
+-------------------------------------------------------------+
| [Top]    [▼ SWIPE DOWN : REVENIR AUX GRAPHIQUES]            |
|          Impact Budgétaire Estimé : -35 000 TND             |
+-------------------------------------------------------------+
| [Middle] Mini-Rappel : Trésorerie Prévisionnelle 107.5K TND  |
+-------------------------------------------------------------+
| [Bottom] Zone Nano Banana (Contrôle au Pouce)               |
|                                                             |
|          Prix de Vente Net Unitaire                         |
|          [-] ------------------● (920 TND) ---------------- [+] |
|                                                             |
|          Volume de Production Usine                         |
|          [-] -----------● (75 unités) --------------------- [+] |
|                                                             |
|          Allocation Budgétaire Marketing                    |
|          [ < Branding de Masse > ]    [ Force de Vente ]    |
|                                                             |
|          [🚀 APPUYÉ LONG (2s) : VALIDER LE TRIMESTRE]        |
+-------------------------------------------------------------+
Interactions Fondamentales :

Bouger le curseur de prix ou de production recalcule instantanément le compteur de "Trésorerie Prévisionnelle" pour simuler l'impact avant envoi. Chaque cran passé émet une vibration haptique.

La validation requiert un appui long de 2 secondes avec jauge de chargement circulaire sur le bouton Or pour éviter les validations accidentelles.

Gestion de la friction Freemium : Si le joueur est en mode gratuit, la validation déclenche instantanément une transition masquant l'interface par un interstitiel publicitaire de 12 secondes pendant que le serveur calcule le marché à somme nulle.

Écran 4 : Le Lobby de Matchmaking & Catch-Up (lobby_screen.dart)
Cet écran permet de rejoindre l'Arène Globale (Mode 3) ou d'accepter une intégration tardive.

Plaintext
+-------------------------------------------------------------+
| [Top]    Arène Globale — Recherche de Sessions Humaines      |
+-------------------------------------------------------------+
| [Middle] Liste des Salles Actives                           |
|                                                             |
|          [ Salon #8892 - Niveau 4 (Élast. Stable) ]         |
|          Statut : T3 / 20  | 4 Joueurs actifs | [REJOINDRE] |
|                                                             |
|          [ Salon #4410 - Niveau 8 (Haute Volatilité) ]      |
|          Statut : T8 / 25  | 6 Joueurs actifs | [REJOINDRE] |
|          ⚠️ Alerte Catch-Up : Injection au Trimestre 8.     |
|          Votre dotation calculée : 120K TND | 45 unités.    |
+-------------------------------------------------------------+
| [Bottom] Action Client :                                    |
|          [ CREER UN NOUVEAU SALON HUMAIN HÉBERGÉ ]          |
+-------------------------------------------------------------+
Écran 5 : Le Rapport de Job Matching B2B (report_screen.dart)
Généré en fin de parcours pour les entreprises ou acheteurs de rapports, cet écran présente le croisement analytique et le profil du joueur.

Plaintext
+-------------------------------------------------------------+
| [Top]    Bilan d'Évaluation RH — BIZ Pulse                  |
|          Candidat : @WalidK_Tunis | Session #4410 (Niveau 8)|
+-------------------------------------------------------------+
| [Middle] Analyse des Croisements & Télémétrie               |
|                                                             |
|          SCORE DE MATCHING DE POSTE : [ 92% - COMPATIBLE ]  |
|          Poste visé : Manager Opérationnel / Cadre Dirigeant|
|                                                             |
|          [📊 Radar Chart : Profil Managérial Évalué]       |
|          - Rigueur Budgétaire (Gestion BFR) : Élevée (88%)  |
|          - Résistance au Stress Temporel   : Maximale (95%) |
|          - Agilité Stratégique (Pricing)   : Modérée (60%)  |
|                                                             |
|          💡 Synthèse Emma Martin : "Profil très analytique,  |
|          excellent contrôle des flux logistiques sous la    |
|          contrainte stricte des 180 unités. Prise de        |
|          décision rapide lors des phases de crise."          |
+-------------------------------------------------------------+
| [Bottom] Actions de Fin de Session :                        |
|          [📥 EXPORTER LE RAPPORT EN PDF COMPLET (RH)]       |
|          [🔗 PARTAGER MON BADGE DE LIGUE SUR LINKEDIN]      |
+-------------------------------------------------------------+

---

### 🧱 Validation de l'Étape 3

Le parcours utilisateur complet, les wireframes textuels incluant les indicateurs de stock (180 unités), la zone de contrôle au pouce (Nano Banana) et les écrans de Job Matching B2B sont configurés. Tu peux copier ce bloc directement dans ton fichier `/docs/UX_UI.md`.

**Ces spécifications UX/UI (Étape 3) te conviennent-elles pour ton master plan, et sommes-nous prêts à passer à l'Étape 4 (Business & Monétisation) afin d'articuler finement les grilles tarifaires de tes offres B2C et de tes packs de recrutement B2B ?**
