#import "../template.typ": *

#show: doc => cs_sheet(
  title: "1. Creating a sudoku board",
  lang: "en",
  serie_icon: "resources/icons/sudoku.png",
  doc,
)

= L'objectif de cette série

As-tu déjà joué au sudoku? Dans cette série, nous allons créer un jeu de sudoku en python. Au lieu d'utiliser des chiffres, nous allons utiliser des billes colorées.
Le résultat ressemblera à cela:
#align(center)[#image("../../resources/screenshots/sudoku.png", height: 18em)]

La première chose que nous allons faire, dans cette fiche, est de dessiner la grille.

= Tracer des lignes

Pygame a une fonction permettant de tracer des lignes. La documentation est disponible, en anglais, ici: https://www.pygame.org/docs/ref/draw.html#pygame.draw.line

Cette fonction prends 4 paramètres oligatoires et un paramètre optionnel, et retourne un rectangle qui contient la ligne:
```
bounding_rect = pygame.draw.line(surface, color, start_pos, end_pos, width=1)
```

= Utiliser des lignes pour dessiner une grille de sudoku

Essaie le code suivant:
```
import pygame

BLACK = pygame.Color(0, 0, 0)
WHITE = pygame.Color(255, 255, 255)

BOARD_MARGIN = 50
BOARD_SIZE = 400

WIDTH, HEIGHT = BOARD_SIZE + 2*BOARD_MARGIN, BOARD_SIZE + 2*BOARD_MARGIN

class SudokuGrid(object):

  def __init__(self, size):
    self._size = size
  
  def sudoku_board(self):
      board = pygame.Surface((self._size, self._size))
      board.fill(WHITE)
      large_width = 9
      small_width = 3
      pygame.draw.line(board, BLACK, (self._size/9, 0), (self._size/9, self._size), width=small_width)
      pygame.draw.line(board, BLACK, (self._size/3, 0), (self._size/3, self._size), width=large_width)
      return board

pygame.display.set_caption("Color sudoku")
screen = pygame.display.set_mode((WIDTH, HEIGHT))

exit = False
grid = SudokuGrid(BOARD_SIZE)
while not exit:
    screen.fill(WHITE)
    for event in pygame.event.get():
        if event.type==pygame.QUIT:
            exit = True
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_ESCAPE:
                exit = True
    screen.blit(grid.sudoku_board(), (BOARD_MARGIN, BOARD_MARGIN))
    pygame.display.flip()

pygame.quit()
```

Le code peut sembler un peu long en vue du résultat: deux lignes verticales:
 - une ligne fine correspondant à l'appel avec `width=small_width`
 - une ligne large correspondant à l'appel avec `width=large_width`

#practice[
Ton objectif est de modify la fonction `sudoku_board` pour dessiner la grille complète. Cela prendra sûrement plusieurs essais. Il y a beaucoup de détails à gérer. Sois patient et persiste. Demande de l'aide si nécessaire.

Il y a 20 lignes à dessiner au total. Mais avec l'aide de boucles, tu peux écrire une fonction qui n'appelle que 4 fois `pygame.draw.line`, ou même moins. Essaie! (mais attention à ne pas perdre ton code qui marche)
]

#attention[
Si tu essaies de tracer une ligne de `(0, 0)` à `(0, size)` (ou autre combinaison de 0 et size pour des lignes horizontales ou verticales), tu te rendras comptes que ces lignes semblent plus fines que les lignes tracées ailleurs.

C'est parce que la position donnée à `line` est le milieu de la ligne. Donc au bord, la moitié de la ligne est en dehors de la surface et n'est donc pas dessinée. Si tu veux que toutes les lignes aient la même taille, il faudra compenser cela.

Pour un résultat parfait, il faut que toutes les cases aient la même largeur et hauteur, et ce n'est pas si simple que ça. Mais c'est possible !
]
