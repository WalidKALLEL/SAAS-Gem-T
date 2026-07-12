Product Requirements Document (PRD) — BIZ Pulse1. Cadrage Stratégique & Positionnement Produit1.1 Exclusivité B2C & B2B Recrutement (Pure SaaS)Zéro Académique : BIZ Pulse est une application mobile 100% autonome (Zero-Touch). L'enseignement et la formation académique sont strictement réservés à la solution web BIZ Experience.Zéro Animation : Aucun animateur, formateur ou consultant humain n'intervient dans l'écosystème de l'application mobile.Cibles Principales :B2C : Arène compétitive grand public permettant aux joueurs de se mesurer entre eux et de valoriser leur score de compétence.B2B Recrutement : Solution d'évaluation automatisée (Assessment Center) permettant aux directions RH de cartographier précisément le profil managérial des candidats.1.2 Gestion de la Temporalité & NotificationsConfiguration Souple : La durée de chaque tour est entièrement paramétrable et modifiable par le joueur (en B2C) ou le recruteur (en B2B) selon ses disponibilités.Sessions Longues Immersives : Cycles de décision analytiques d'un minimum de 5 minutes par trimestre, pour des sessions globales s'étalant sur 2h30 minimum.Système d'Alertes Push : Envoi de notifications intelligentes et non intrusives basées sur les préférences configurées par l'utilisateur pour lui rappeler de jouer son tour avant l'échéance.2. Game Design & Règles du Moteur Économique2.1 Algorithme à Somme Nulle et Gestion des StocksIndice d'Attractivité ($I_A$) : Le serveur répartit la demande du marché au prorata de la performance de chaque joueur, sans aucun facteur aléatoire :$$I_A = \text{Prix Net (40\%)} + \text{Budget Marketing (30\%)} + \text{Capacité de Livraison (30\%)}$$La Règle Critique des 180 Unités : L'entrepôt logistique dispose d'une capacité maximale de 180 unités. Si le stock d'invendus d'un joueur dépasse ce seuil à la fin d'un trimestre, le moteur applique automatiquement une Pénalité d'Asphyxie Logistique : malus de 15% sur la Capacité d'Autofinancement (CAF) pour le tour en cours.2.2 Mode 3 : L'Arène Globale (Multijoueur Ouvert) & Mécanique de "Catch-Up"Compétition Humaine Pure : Ce mode repose exclusivement sur la confrontation entre de réels joueurs humains (pas d'IA) appairés selon leur score de classement ELO.Intégration en Cours de Route : Un joueur peut demander à intégrer une session active (créée par autrui ou via une demande d'intégration) ou créer une nouvelle session. L'entrée dans une session active est autorisée jusqu'au 10ème tour maximum.Dotation de Rattrapage (Catch-Up) : Pour garantir l'équité face aux joueurs déjà avancés, le serveur initialise le nouvel entrant avec des valeurs calquées sur les médianes de la cohorte active au tour $N-1$ :Trésorerie d'entrée : Valeur médiane de la caisse disponible du marché.Stock d'entrée : Valeur médiane des stocks du marché (soumise au plafond des 180 unités).Parts de marché initiales : Prélevées de manière équitable sur la zone client neutre ou recalculées à somme nulle dès le premier arbitrage.3. Spécifications UX/UI & Data Visualization3.1 L'Audit Visuel en 3 SecondesCharte Graphique : Dark Mode Premium strict. Fond Marine Profond (#0A0F1D), Blocs Bleu Nuit (#161F38), Textes Blanc Mat (#E2E8F0), Éléments d'Action Or Premium (#D4AF37).Jauges Néon Interactives : Trois jauges circulaires dynamiques (Trésorerie, Parts de Marché, Stocks) indiquent instantanément la santé de l'entreprise.Analyses et Croisements au Toucher : Un simple tapotement sur une jauge déploie des graphiques en courbes lissées pour analyser les interdépendances financières majeures (croisement EBITDA, BFR avancé, et CAF).3.2 Saisie Ergonomique "Nano Banana"Contrôle au Pouce : Tous les curseurs de décision (Sliders de prix, volume de production, budgets marketing) sont regroupés sur les 35% inférieurs de l'écran pour un pilotage confortable à une seule main.4. Matrice de Monétisation & Profiling RH4.1 Règle d'Étanchéité des SiègesAnti-Partage : L'infrastructure impose la règle technique 1 Compte = 1 Siège Payant = 1 Seule Session Active. Si un joueur est engagé dans une session multijoueur, sa partie solo est gelée par le serveur.4.2 Grille Tarifaire B2CAccès Standard (Gratuit) : Limité strictement aux Niveaux 1 et 2. Présence de publicités interstitielles obligatoires de 12 secondes pendant la résolution du serveur. Aucun rapport de fin de jeu accessible.Abonnement Annuel Élite : 119 TND / an (Payable en une fois). Suppression des publicités, accès à tous les niveaux supérieurs (Niveaux 3 à 8+) et déblocage complet des indicateurs financiers.Pass Lifetime (À Vie) : 200 TND (Paiement unique). Mêmes avantages que l'abonnement annuel, débloqués de manière permanente.Micro-transactions optionnelles : Rapport Analytique IA PDF à 5 TND | Pack de 3 Jetons de Survie à 5 TND (Mode Solo uniquement).4.3 Le Cockpit Recruteur B2B & Profiling de Job MatchingLes responsables RH accèdent à un tableau de bord d'administration pour configurer des sessions d'évaluation entièrement prédéfinies et automatisées :Volume des sessions : Fixé entre 20 et 25 tours maximum.Niveaux de difficulté du moteur : Niveau 4 pour l'évaluation de profils juniors/débutants | Niveau 8 pour l'évaluation de managers, cadres et directeurs.Variables de Session Paramétrables : Sélection fine des événements de marché à déclencher, de la durée exacte de chaque tour, et des phases du cycle de vie du produit (Lancement, Croissance, Maturité, Crise).Rapport de Job Matching : Génération automatique d'une cartographie croisant la réactivité au stress (télémétrie temporelle) et la rigueur de gestion du candidat. Le système fournit un profil psychométrique et managérial exact pour valider l'adéquation avec le poste ciblé.5. Architecture Technique & Schéma de Base de Données5.1 Principes d'IngénierieServeur Autoritaire : L'application Flutter agit comme un terminal d'affichage. L'intégralité des calculs à somme nulle, le middleware des paywalls et le suivi des timers Redis résident sur le serveur.Sauvegarde Passive Locale : Chaque mouvement de curseur effectué dans la zone "Nano Banana" est enregistré en arrière-plan sur le téléphone via SharedPreferences pour éviter toute perte de saisie en cas de micro-coupure réseau.5.2 Structure de la Base de Données (/backend/schema.sql)SQL-- Table des Utilisateurs & Statuts de Facturation
CREATE TABLE users (
    id VARCHAR(255) PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    elo_score INT DEFAULT 1000,
    subscription_type VARCHAR(50) DEFAULT 'FREE', -- 'FREE', 'YEARLY_ELITE', 'LIFETIME'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table de Contrôle d'Étanchéité des Sessions (1 Siège = 1 Session Active)
CREATE TABLE active_sessions (
    session_id UUID PRIMARY KEY,
    creator_id VARCHAR(255) REFERENCES users(id),
    current_quarter INT DEFAULT 1,
    max_quarters INT DEFAULT 25, 
    level_difficulty INT DEFAULT 4, -- Niveau 4 (Juniors) ou Niveau 8 (Cadres/Managers)
    is_b2b_recruitment BOOLEAN DEFAULT FALSE,
    time_limit_seconds INT DEFAULT 300, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Ingestion des Arbitrages Sliders au Pouce
CREATE TABLE quarter_decisions (
    id SERIAL PRIMARY KEY,
    session_id UUID REFERENCES active_sessions(session_id) ON DELETE CASCADE,
    player_id VARCHAR(255) REFERENCES users(id),
    quarter_number INT NOT NULL,
    selling_price NUMERIC(10, 2) NOT NULL,
    production_volume INT NOT NULL,
    marketing_mass_budget NUMERIC(10, 2) NOT NULL,
    marketing_sales_force_budget NUMERIC(10, 2) NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(session_id, player_id, quarter_number)
);

-- Historique Financement et Logistique (Lecture 3 secondes)
CREATE TABLE quarter_results (
    id SERIAL PRIMARY KEY,
    session_id UUID REFERENCES active_sessions(session_id) ON DELETE CASCADE,
    player_id VARCHAR(255) REFERENCES users(id),
    quarter_number INT NOT NULL,
    market_share_percentage NUMERIC(5, 2) NOT NULL,
    cash_balance NUMERIC(12, 2) NOT NULL,
    ebitda NUMERIC(12, 2) NOT NULL,
    bfr NUMERIC(12, 2) NOT NULL,
    caf NUMERIC(12, 2) NOT NULL,
    current_stock INT NOT NULL,
    has_asphyxia_penalty BOOLEAN DEFAULT FALSE
);
5.3 Pipeline d'Intelligence Artificielle & AutomatisationModèle Éco-Performant : Utilisation exclusive de l'API Gemini Flash via son SDK officiel pour le traitement textuel asynchrone (Briefing d'Emma Martin et synthèse comportementale de Job Matching). L'IA n'intervient jamais dans la résolution mathématique des équations comptables.
