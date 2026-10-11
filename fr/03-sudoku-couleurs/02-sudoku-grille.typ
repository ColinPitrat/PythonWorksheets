#import "../template.typ": *

#show: doc => cs_sheet(
  title: "2. Afficher un jeu de sudoku",
  lang: "en",
  serie_icon: "resources/icons/sudoku.png",
  doc,
)

= L'objective de cette fiche

Dans la fiche précédente, nous avons vu comment dessiner le fond. Dans cette fiche, nous allons voir comment représenter en mémoire et afficher une grille de sudoku.

La représentation mémoire sera nécessaire pour savoir où sont les indices, quelles billes ont été placées par le joueur et faire les calculs nécessaires pour déterminer si le joueur à gagné où s'est trompé quelque part, calculer une solution, etc ...

= Représenter la grille

Bien que nous voulions montrer une grille de sudoku utilisant des billes colorées au joueur, en interne nous allons la représenter avec des nombres.

La grille de sudoku est un tableau à deux dimensions (lignes et colonnes). En python, on peut représenter cela directement avec un tableau de tableaux. Nous allons stoquer cela dans la classe `SudokuGrid`.

Ajoute les constantes suivantes à ton programme (au début):

```
COLORS = [
    pygame.Color(255, 0, 0),     # Rouge
    pygame.Color(255, 128, 0),   # Orange
    pygame.Color(255, 255, 0),   # Jaune
    pygame.Color(128, 255, 128), # Vert clair
    pygame.Color(0, 128, 0),     # Vert sombre
    pygame.Color(180, 200, 255), # Bleu clair
    pygame.Color(0, 0, 255),     # Bleu sombre
    pygame.Color(255, 128, 255), # Rose
    pygame.Color(128, 0, 128),   # Violet
]

BEAD_SIZE = 15
```

Puis modifie la classe `SudokuGrid` en changeant le constructuer `__init__` et en ajoutant deux nouvelles fonctions:
```
class SudokuGrid(object):

  def __init__(self, size):
    self._size = size
    self._board = [[None for _ in range(9)] for _ in range(9)]

  def load(self, filename):
    with open(filename, "r") as file:
      rows = file.readlines()
      board = []
      def read_cell(value):
        if value == ".":
          return None
        if len(value) != 1 or value < "1" or value > "9":
          raise Exception(f"Invalid cell value '{value}' in '{filename}'")
        return int(value)
      self._board = [[read_cell(c.strip()) for c in row.split(',')] for row in rows]

  def draw(self):
    surface = self.sudoku_board()
    pygame.draw.circle(surface, COLORS[0], (2*self._size/9 + self._size/18, 5*self._size/9 + self._size/18), BEAD_SIZE)
    return surface
```

Enfin, modifie le code pour créer la grille, la charger depuis un fichier et la dessiner sur le fond.
Les nouvelles lignes (les seules à taper) sont celles qui commencent par `+` (qu'il ne faut pas taper!), les lignes à enlever commencent par un `-`:
```
   grid = SudokuGrid(BOARD_SIZE)
+  grid.load("grid.sud")
   while not exit
(...)
               exit = True
-  screen.blit(grid.sudoku_board(), (BOARD_MARGIN, BOARD_MARGIN))
+  screen.blit(grid.draw(), (BOARD_MARGIN, BOARD_MARGIN))
   pygame.display.flip()
```

Ce code charge une grille de sudoku depuis un fichier appelé `grid.sud`. Crée ce fichier, avec le contenu suivant:
```
1,.,.,.,.,9,.,.,.
.,.,.,2,.,8,.,.,.
5,.,8,3,1,6,.,.,.
.,1,.,5,.,7,8,.,.
3,5,6,.,.,1,7,.,.
.,.,7,6,.,4,.,.,1
6,.,1,.,8,.,9,2,.
.,.,.,.,4,.,5,1,6
.,.,5,.,.,2,4,.,7
```

#practice[
Ton objectif est de dessiner toutes les billes qui sont dans `self._board` au lieu d'une seule bille rouge. Pour cela, il faut boucler sur toutes les lignes et colonnes de la grille et décider de la couleur en fonction de la valeur stockée à cette position. Utilise `self._board[i][j]` pour accéder à la valeur stockée à la ligne `i` et la colonne `j`. Fais attention: les lignes et colones vont de 0 à 8, pas de 1 à 9. Par contre, les "couleurs" dans `grid.sud` vont de 1 à 9.
]

#attention[
Si tu places les billes régulièrement, tu remarqueras qu'elle ne sont pas parfaitement alignées sur la grille. C'est parce que la grille est irrégulière à cause des lignes qui ont des largeurs variables. Pour un résultat parfait, il faut en tenir compte.

Il est possible qu'en faisant cela, tu te rendes compte que ta grille n'est pas aussi parfaite que tu le pensais. Il faudra revenir en arrière et la corriger. Cela arrive souvent quand on programme !
]
