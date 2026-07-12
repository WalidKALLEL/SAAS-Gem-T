Game Design & Spécifications du Moteur Économique — BIZ Pulse
1. Algorithme de Résolution du Marché (Serveur Autoritaire)
Le moteur de jeu fonctionne de manière purement déterministe, sans aucun facteur de chance ou d'aléatoire. La demande totale du marché à un trimestre T est répartie à somme nulle entre les entreprises selon leur Indice d'Attractivité (I_A).

1.1 Équation de l'Indice d'Attractivité (I_A)
Pour chaque joueur, le serveur calcule trois composantes pondérées :

Composante Prix (C_P — Poids 40%) : Mesure l'écart entre le prix net du joueur et le prix moyen du marché. Un prix trop élevé détruit l'attractivité de manière exponentielle.

Composante Marketing (C_M — Poids 30%) : Évalue l'efficacité cumulée des budgets de masse (Branding) et ciblés (Force de vente).

Composante Logistique (C_L — Poids 30%) : Bonus de compétitivité si l'entreprise dispose d'un stock de sécurité au trimestre précédent pour éviter la rupture.

Formule de calcul :
I_A = (0.4 * C_P) + (0.3 * C_M) + (0.3 * C_L)

1.2 La Règle de Saturation des 180 Unités
La capacité maximale de stockage d'urgence sur mobile est limitée à 180 unités.

Formule du stock de fin de trimestre : Stock_T = Stock_T-1 + Production_T - Ventes_T

Pénalité d'Asphyxie Logistique : Si Stock_T > 180, le serveur applique automatiquement un malus destructeur de 15% sur la Capacité d'Autofinancement (CAF) du trimestre en cours pour simuler les frais de stockage d'urgence.

2. Mode 3 : Arène Globale & Algorithme de "Catch-Up"
Le Mode 3 permet à un joueur humain d'intégrer une session multijoueur déjà lancée par d'autres utilisateurs.

Limite d'accès : L'intégration est autorisée jusqu'au 10ème tour maximum.

Dotation d'Équité Logistique et Financière : Pour éviter qu'un joueur entrant en cours de route ne commence en faillite, le serveur calcule la valeur médiane de la cohorte active au trimestre N-1 pour l'initialiser :

Trésorerie_Initiale = Médiane(Trésoreries_Marché_Trimestre_N-1)

Stock_Initial = Minimum(180, Médiane(Stocks_Marché_Trimestre_N-1))

Parts_de_Marché_Initiales = Prélevées équitablement sur la zone neutre (clients non captés) du marché.

3. Système de Progression ELO & Paramétrage B2B
3.1 Classement B2C (Ligues)
Chaque joueur possède un score ELO dynamique (base 1 000). Les gains et pertes de points dépendent de la performance financière relative face au score ELO des adversaires du salon. Les paliers définissent 5 Ligues : Bronze, Argent, Or, Élite, et Prestige Tech.

3.2 Configurations Prédéfinies du Cockpit B2B (Recrutement)
Le recruteur RH sélectionne une matrice de crash-test automatisée sans aucune animation humaine :

Profils Juniors / Débutants : Session bloquée à 20 tours max, difficulté fixée au Niveau 4 (variables macroéconomiques stables, cycle de vie produit linéaire).

Profils Managers / Cadres : Session bloquée à 25 tours max, difficulté fixée au Niveau 8 (haute volatilité, chocs d'inflation, crises logistiques, cycles de vie courts).

3.3 Télémétrie pour le Rapport de Job Matching
Le moteur enregistre en continu deux indicateurs comportementaux pendant la phase de réflexion du joueur :

Hard_Skills_Index = Capacité à maintenir la trésorerie positive en optimisant le BFR avancé sous la contrainte des 180 unités de stock.

Soft_Skills_Index = Vitesse de réaction face aux notifications de crise et agilité stratégique (variabilité calculée des prix d'un tour à l'autre).

🛠️ Plan d'Action pour ton IDE (Cursor / Windsurf)
Dès que ce fichier est déposé dans ton Git, tu as ta brique "Game Design" prête. Au moment de coder le backend, il te suffira d'ouvrir ton fichier de script et d'ordonner à ton assistant : "Implémente la logique de calcul de l'Indice d'Attractivité et la pénalité des 180 unités en lisant les règles du fichier /docs/GAME_DESIGN.md".

🧱 Validation de l'Étape 2
Maintenant que ce document est prêt à être déposé dans ton répertoire de travail, nous avons verrouillé les fondations mathématiques et logiques de l'application.
