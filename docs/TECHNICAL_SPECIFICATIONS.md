Markdown# Cahier des Charges Technique & Architecture Système — BIZ Pulse

## 1. Architecture Globale & Flux d'Information

Le système est découplé en trois couches indépendantes pour assurer une maintenance transparente, une sécurité totale (anti-triche) et une scalabilité horizontale lors des pics de connexions B2B.

```text
[ APPLICATION FLUTTER (Client) ]
       │       ▲
       │(JSON) │ (UI Dynamique & Graphiques)
       ▼       │
[ API GATEWAY / REQUÊTES ASYNCHRONES ]
       │
       ├───────────> [ CACHE REDIS (Sessions Uniques, TTL Horloges, Lobbies) ]
       │
       ├───────────> [ BACKEND NODE.JS / GO (Moteur Somme Nulle & Équations) ]
       │                      │
       │                      ▼
       └───────────> [ DB POSTGRESQL (Grands Livres Comptables & Config Admin) ]
                              │
                              ▼
                     [ API GEMINI FLASH (Génération PDF Job Matching) ]
2. Stack Technique Recommandée2.1 Frontend (Application Mobile Mobile-First)Framework : Flutter (Dart). Choix stratégique pour compiler nativement à 60 FPS sur iOS et Android avec un code-base unique.State Management : BLoC / Cubit (flutter_bloc). Pattern obligatoire pour séparer proprement l'interface graphique de la logique réseau.Cache Local Durant le Tour : shared_preferences pour enregistrer de manière passive les mouvements de curseurs au pouce de l'utilisateur.2.2 Backend & Moteur de Calcul (Serveur)Technologie principale : Node.js (TypeScript avec NestJS) pour sa flexibilité sémantique face aux payloads JSON, ou Go (Golang) si l'on priorise une vitesse de calcul brute instantanée sous la milliseconde pour les résolutions à somme nulle.Communication Temps Réel : WebSockets (socket.io) pour la synchronisation immédiate des salons de l'Arène Globale (Mode 3).2.3 Couche de Données & CacheBase de Données Principale (Persistance) : PostgreSQL. Essentiel pour stocker les structures comptables strictes (Grands livres des trimestres), la configuration universelle de l'administration et les logs de facturation.Base de Données In-Memory (Cache & Sockets) : Redis. Utilisé pour stocker les lobbies actifs, vérifier l'étanchéité des comptes (1 Compte = 1 Session Active) et gérer les comptes à rebours des trimestres.3. Synchronisation Multijoueur & Résilience Réseau3.1 Gestion de la Temporalité Asynchrone (Horloges Redis TTL)Pour chaque salon de jeu actif, le serveur initialise une clé Redis expirant à la fin du chrono choisi (ex: 5 minutes en B2C, dégressif en B2B).À chaque validation de joueur (submitQuarter()), le statut passe à READY dans Redis.Dès que tous les joueurs sont prêts, ou dès que la clé Redis TTL expire (Atteinte du temps limite), le serveur ferme le trimestre et bascule sur le calcul algorithmique.3.2 La Règle du "Joueur Fantôme" & Sauvegarde PassiveSi l'utilisateur perd sa connexion 4G/Wi-Fi (tunnel, zone blanche, batterie faible) :Côté Client : Chaque modification des curseurs dans la Zone Nano Banana exécute un hook asynchrone qui sauvegarde les inputs dans les SharedPreferences du téléphone.Côté Serveur : Si le chrono du tour expire sans action du joueur, le serveur interroge la dernière trame reçue. S'il n'y en a aucune, il applique la règle du Joueur Fantôme définie dans l'administration : reconduction automatique des décisions précédentes et application immédiate du Malus de Passivité de 5% sur la productivité de l'usine.À la reconnexion : Le GameSessionCubit de l'application Flutter interroge l'API /api/v1/session/status et resynchronise l'écran à la seconde près sur l'état central du serveur.4. Pipeline d'Intelligence Artificielle Éco-PerformantePour garantir la rentabilité de l'abonnement annuel à 119 TND, l'usage des LLM est strictement contingenté et isolé des calculs mathématiques :Plaintext[ Données Chiffrées Brut (Postgres) ] ──> [ Formatage Prompt JSON ]
                                                   │
  [ Rapport PDF RH Final ] <─── [ API Gemini Flash ] ┘
  (Génération de la synthèse textuelle de Job Matching)
Calcul Comptable (Coût Serveur $0$) : Le serveur Node.js/Go calcule les parts de marché, les stocks finaux et les pénalités des 180 unités de manière purement algorithmique.Payload Sémantique : Une fois le bloc de résultats du 25ème tour écrit dans PostgreSQL, le serveur extrait une matrice compacte de scores (Temps moyen de validation, ratio BFR/Trésorerie, occurrences de pénalités de stock).Appel API : Ce JSON est injecté dans un template de prompt strict envoyé au SDK Gemini Flash. Le modèle génère uniquement les paragraphes textuels de la synthèse de personnalité managériale d'Emma Martin.Compilation du Livrable : Le texte renvoyé par l'IA est fusionné dans un template HTML-to-PDF (puppeteer ou un moteur de rendu léger) pour générer instantanément le rapport final de Job Matching envoyé au recruteur B2B.5. Stratégie de Sécurité & Guardrail Paywall5.1 Le Verrou de Session Unique (Anti-Abus)À chaque tentative d'authentification ou d'ouverture de partie, le backend écrit dans Redis un token d'état : user_session:{userId} -> {sessionId} avec un TTL d'activité. Si une requête arrive avec le même userId mais depuis un appareil distinct (partage de compte frauduleux), l'ancienne session est instantanément close avec un code HTTP 409 (Conflict).5.2 Middleware de Dynamic Config UIAu chargement de n'importe quel niveau, l'application mobile exécute une requête unique : /api/v1/session/config.Le serveur intercepte la requête, vérifie les droits d'accès (subscription_type de l'utilisateur ou validité du pack de recrutement B2B) :Si le joueur gratuit tente d'ouvrir le Niveau 3, le serveur renvoie un code ERR_PAYWALL_LOCKED. L'application Flutter intercepte ce code via le Cubit et affiche l'écran natif d'achat d'abonnement ou de pass Lifetime.Si l'accès est valide, le serveur renvoie le dictionnaire complet des variables dynamiques (paliers des 3 gammes, taux d'IS, prix de la machine). L'application mobile instancie ses sliders et ses jauges à partir de ce JSON. Aucun élément n'est modifiable localement de manière permanente.
---

## 🧱 Fin de l'Étape 5 : Ton Dépôt Git est Prêt pour le Code

Walid, ce cahier des charges technique vient de lier l'intégralité de nos réflexions. Ton dépôt `/docs` contient désormais les spécifications produit, le game design, le parcours UX/UI, le plan de monétisation, l'hyper-cockpit d'administration et l'architecture technique. 

Nous sommes arrivés au bout du cycle analytique. Toutes les briques fonctionnelles et d'ingénierie étant scellées, nous pouvons générer le livrable final.

**Souhaites-tu valider ce cahier des charges technique (Étape 5) pour que je compile la Synthèse
