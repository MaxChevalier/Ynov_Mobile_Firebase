# tp_final_firebase

### introduction

Ce projet est un projet de formation de dev Mobile. Il s'agit d'une application mobile qui permet de gérer des notes (création, modification, suppression, lecture) et de les stocker dans une base de données Firebase. Le projet est codé en Dart avec le framework Flutter.

### Prérequis

- Flutter
- dart

### Installation

- Cloner le projet
- Lancer la commande `flutter pub get` pour installer les dépendances
- Lancer la commande `flutter run` pour lancer l'application

### Fonctionnalités

- Création de notes
- Modification de notes
- Suppression de notes
- Lecture de notes
- Stockage des notes dans une base de données Firebase
- Authentification
- Création de compte
- Connexion
- Déconnexion
- Ajoue d'une image dans une note

### Problèmes rencontrés

Sur la Fin de projet, j'ai rencontré un problème avec la base de données Firebase. En effet, ceci bloquait toute interaction avec firebase. J'ai donc décidé de créer un nouveau projet et de réimplémenter les fonctionnalités de l'ancien projet. Malheureusement, Cela ne ces pas avrérer éfficasse et le problème est toujours présent. Suite a de nombreuses recherches, je n'ai pas trouvé de solution à ce problème. Le problème est surment lié a la VM utilisé pour tester l'application, En effet j'ai pu passer par le navigateur WEB pour tester l'application et cela fonctionnait.

### Defi

Le Principal défi rencontrer dans ce projet a été la gestion des images. En effet, j'ai du trouver un moyen de stocker les images dans la base de données Firebase. J'ai donc décidé de stocker les images dans le cloud. J'ai donc utilisé le package firebase_storage. Ce package permet de stocker des fichiers dans le cloud. J'ai utilisé ce package pour stocker les images des notes.

### Sécurité

Pour la sécurité, j'ai utilisé le package firebase_auth. Ce package permet de gérer l'authentification des utilisateurs. Il permet de créer un compte, de se connecter et de se déconnecter. Il permet aussi de récupérer l'utilisateur connecté. J'ai aussi utilisé le package firebase_storage. Ce package permet de stocker des fichiers dans le cloud. J'ai utilisé ce package pour stocker les images des notes. Enfin, j'ai utilisé le package cloud_firestore. Ce package permet de stocker des données dans le cloud. J'ai utilisé ce package pour stocker les notes.
pour authentifier l'utilisateur, j'ai utilisé l'authentification par email et mot de passe. le mot de passe n'est pas afficher lors de la saisie et il est haché par le systeme de firebase évitant ainsi de stocker le mot de passe en clair dans la base de données.



