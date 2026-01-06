# Event Manager

**Event Manager** est une application mobile Flutter permettant la gestion et la réservation d’événements. Elle offre une expérience fluide pour les utilisateurs et un contrôle complet pour les administrateurs. L’application est conçue pour illustrer les bonnes pratiques Flutter, l’intégration Firebase, la gestion d’état, les animations et les appels API REST.

## Fonctionnalités principales

### Pour les utilisateurs

* Inscription et connexion sécurisées via **FirebaseAuth**
* Consultation de la liste des événements avec **API REST**
* Détails complets pour chaque événement : date, lieu, description, image
* Réservation d’événements et gestion des **favoris** via **Cloud Firestore**
* Visualisation de la localisation de l’événement sur **Google Maps**
* Gestion du profil utilisateur (modification des informations personnelles)
* Navigation intuitive avec **Drawer et BottomNavigationBar**
* Animations fluides pour les transitions et interactions (Hero, AnimatedContainer, Lottie)
* Gestion des erreurs et des états de chargement (SnackBar, CircularProgressIndicator)

### Pour les administrateurs

* Dashboard pour visualiser les statistiques et les événements
* Création, modification et suppression d’événements
* Gestion des réservations et suivi des participants
* Accès sécurisé basé sur le rôle stocké dans Firestore

## Technologies utilisées

* **Flutter** pour le développement mobile cross-platform
* **Firebase** : Authentification, Cloud Firestore
* **HTTP / REST API** pour récupérer les événements
* **Google Maps** pour la localisation des événements
* **Provider / Riverpod** pour la gestion d’état
* Animations : **Hero, AnimatedContainer, AnimatedOpacity, Lottie**

## Objectifs pédagogiques

Ce projet a été développé pour :

* Illustrer la navigation complexe dans Flutter avec routes nommées, Drawer et BottomNavigationBar
* Démontrer l’intégration de Firebase et la gestion de rôles utilisateur
* Implémenter la récupération de données via une API REST
* Gérer les états et les erreurs dans une application mobile moderne
* Créer une expérience utilisateur riche avec des animations et une interface réactive

## Structure du projet

* `auth/` : connexion, inscription, gestion utilisateur
* `events/` : liste et détails des événements
* `reservations/` : réservations et favoris
* `admin/` : dashboard et gestion des événements pour l’administrateur
* `profile/` : écran et édition du profil
* `shared/` : widgets réutilisables, thèmes, animations
* `services/` : API, Firestore, Auth
* `navigation/` : routes, Drawer, BottomNavigationBar

Si tu veux, je peux aussi rédiger une **version courte et impactante** pour l’afficher directement sur GitHub, avec badges et résumé technique prêt à copier-coller. Veux‑tu que je fasse ça ?
