# **Projet GSB Gestion de Médecins - Alexandre G.**

<br>
<br>

## **Introduction**
GSB Gestion de Médecins, qui est la seconde variante des projets GSB (AP 4) proposés, est un sujet qui doit être réalisé dans le cadre du BTS SIO.
Ce projet fera partie d'un bouquet de quatre projets réalisés par l'étudiant au cours de ses deux années
de BTS. Le candidat devra présenter deux de ses projets dans le cadre de l'examen oral qui aura lieu en fin de deuxième année.

<br>

#### Contexte du projet :
- La documentation technique est disponible [ici](Documentation_Technique.docx).


## **Description**
En plus des attentes et éxigences exprimées dans le sujet lui-même, certaines restrictions fûrent imposées afin de réaliser un projet
qui soit conforme aux attentes de l'entretien oral, à savoir:

- Le projet doit s'articuler autour d'une méthode de programmation orientée objet (OOP)
- Le projet doit être disponible et déployable sur mobile (OS Android)
- Le système de Gestion de Base de Données Relationnel (SGBDR) PostgreSQL devra être utilisé
- Le language ou Framework utilisé devra se distinguer de ceux présents dans les trois autres projets
- Le projet devra contenir une documentation utilisateur, expliquant les modalités d'utilisation de l'application web, ainsi qu'une documentation technique, expliquant son fonctionnement

<br>

Afin de mener mon projet à bien, j'ai décidé de le décomposer en deux applications:

- Une API récupérant les données, et prenant à ça charge l'authentification et l'autorisation
  L'API sera codée en [**Java**](https://www.java.com/fr/) au travers du Cadriciel [**Spring**](https://spring.io/).
  
- Une application ciblant Android, permettant à un utilisateur de mener des opérations de CRUD
  L'application, elle, sera construite en [**Dart**](https://dart.dev/) au travers du Framework [**Flutter**](https://flutter.dev/).

<br>

## **Installation**
Cette partie du projet est dédiée à l'application mobile.
Le projet tel qu'il est dans le répo est presque fonctionnel, cependant, quelques vérifications et opérations sont à prévoir:

<br>

- Cloner le projet GitHub sur votre appareil

> Une fois git installé sur votre appareil, l'utilisation de VCS (ou SSH) est recommandée afin de cloner le projet à partir de son lien.

<br>

- Installer Flutter (complet) depuis la branche stable du projet
[**Installation Windows**](https://docs.flutter.dev/get-started/install/windows).
[**Installation Linux**](https://docs.flutter.dev/get-started/install/linux).
[**Installation Mac**](https://docs.flutter.dev/get-started/install/macos).

<br>

- Une fois installé, vérifiez que l'ensemble des éléments nécessaires à la mise en place de flutter soient au vert
  ```shell
  flutter doctor
  ```

<br>

- Récupérer les dépendances du projet:
  ```shell
  flutter pub get
  ```
  
<br>

- Mettre en place un émulateur (Selon votre IDE)

<br>

- Vérifier que l'API fonctionne convenablement, que des utilisateurs sont créés et que les tables sont pleines

<br>

- Lancer l'application (avec no-sound-null-safety)
  ```shell
  flutter run --no-sound-null-safety
  ```

