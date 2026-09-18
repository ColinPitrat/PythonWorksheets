#import "../template.typ": *

#show: doc => cs_sheet(
  title: "1. Opérations basiques - Variables - Entrées utilisateur",
  lang: "en",
  doc,
)

= Lancer Python

Python est un langage de programmation. Il permet de faire faire ce que l’on veut à un ordinateur, du moment que l’on sait comment lui demander. Python est fourni avec un EDI (environnement de développement intégré) appelé IDLE, que l’on va utiliser dans ces fiches.

Pour le lancer, trouve l’icône IDLE sur le bureau ou dans le menu des application. Il devrait ressembler à celà: #box(image("../../resources/icons/python.svg", height: 1em))

= Opérations basiques

Lorsque tu lances IDLE, tu devrais voir quelque chose comme cela:
#image("../../resources/screenshots/idle_start.png")

C’est ce que l’on appelle un shell, ou REPL (#strong[R]ead #strong[E]val #strong[P]rint #strong[L]oop, c’est à dire boucle lecture-évaluation-affichage).

Tu peux entrer des commandes après `>>>` et elles seront exécutées immédiatement.

Essaie par exemple:
```
3+4
12-3
10*5
100/20
(10*5)+7
```

#experiment[
Essaie d’autres opérations. Peux-tu faire que l’ordinateur se trompe ? Peux-tu obtenir des résultats surprenants ?
Comprends-tu tout ce qui se passe ?
]

= Variables

Tu peux stocker le résultat d’un calcul dans une variable. C’est une manière de donner un nom à un résultat que tu veux réutiliser plus tard.

Essaie par exemple:
```
a = 3+4
b = 12-3
c = a+b
```

Que se passe-t-il ? Qu’est-ce qui a changé par rapport à avant?

#block(breakable: false)[
Maintenant essaie:
```
c
```
]

= Entrées utilisateur

Pour finir cette fiche, voyons comment faire lire quelque chose à l’ordinateur (input signifie "entrée" en anglais):
```
nom = input(“Quel est ton nom?”)
```

Puis:
```
“Salut, %s” % nom
```

= Pratique

Mettons ce que tu as appris en pratique.

== Factorielles

En mathématiques, la factorielle d'un nombre est ce que tu obtiens quand tu le multiplies par tous les nombres plus petit que lui, jusqu'à 1. On l'écrit avec un `!` juste après le nombre.
Par exemple: $4! = 4 times 3 times 2 times 1$

Calucle $10!$ en utilisant python.

== Plus de factorielles, plus vite

Dans le shell, tu peux rappeler la commande précédente avec la combinaison de touches `Alt + P`.

Nous allons utiliser celà pour afficher les factorielles des nombres en partant de 1. En python, on peut mettre plusieurs instructions sur une seule ligne en les séparant par un point-virgule `;`.

Tape:
```
n=1; r=1
r=r*n; n=n+1; r
```

Ensuite presse `Alt + P` suivi de la touche `Entrée`. Répête celà autant que tu le veux.

#experiment[
Les nombres grandissent vite, n'est-ce pas? Peux tu trouver un moyen de les faire grandir encore plus vite? Peux-tu arriver à un point où "quelque chose casse"? Lit le message attentivement. Peux tu trouver un moyen d'aller encore plus loin?
]
