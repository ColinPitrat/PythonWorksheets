#import "../template.typ": *

#show: doc => cs_sheet(
  title: "3. Selection de la couleur à jouer",
  lang: "en",
  serie_icon: "resources/icons/sudoku.png",
  doc,
)

= L'objectif de cette fiche

Dans cette fiche, nous allons ajouter l'interface permettant au joueur de choisir la couleur à jouer. Il y aura aussi une 10ème option pour enlever les billes.

Nous allons introduire deux bandeaux: un en haut et un en bas. Seul le deuxième sera utilisé pour l'instant. Celui du haut servira plus tard (annuler, recommencer la partie, sauvegarder, etc ...)

= Modification du code

Nous allons faire évoluer notre code pour simplifier les futurs changements. On appele cela *refactoriser*.

Introduisons de nouvelles constantes:
```
GREY = pygame.Color(128, 128, 128)
LIGHT_GREY = pygame.Color(192, 192, 192)
RED = pygame.Color(255, 0, 0)

SELECTION_MARGIN = 2
CROSS_SIZE = 6
CROSS_LINE_WIDTH = 3
TOP_BAND_HEIGHT = 60
BOTTOM_BAND_HEIGHT = 60

WIDTH, HEIGHT = BOARD_SIZE + 2*BOARD_MARGIN, TOP_BAND_HEIGHT + BOARD_SIZE + 2*BOARD_MARGIN + BOTTOM_BAND_HEIGHT
```

#attention[
La dernière ligne existe déjà dans le code, nous modifions juste `HEIGHT` pour prendre en compte les bandeaux.
Il faut modifier la ligne de code existante et non en introduire une nouvelle. Assures toi que la ligne est *après* les constantes qu'elle utilise.
]

Introduisons une nouvelle classe pour gérer le bandeau du bas:
```
class BeadBand(object):

    def __init__(self, width, height):
        self.width = width
        self.height = height
        self.surface = pygame.Surface((self.width, self.height))
        self.selected = None
        self.compute_centers_pos()

    def compute_centers_pos(self):
        # TODO: Compute the position of the centers of each button
        # We'll need 10 buttons: one for each bead and one for removing beads.

    def draw(self):
        # TODO: Draw 10 beads: one for each color and one for removing beads.
        # Use a grey background. Use a light grey bead with a red X for removing beads.
        # Identify the selected item with a white circle around it.
        # Use the computed centers to place the beads.
        return self.surface

    def handle_click(self, x, y):
        # TODO: Select the bead that was clicked on (if the click was on a bead).
        pass
```

Et bougeons la logique du jeu dans une classe dédiée:
```
class Game(object):

    def __init__(self, level):
        self.grid = SudokuGrid(BOARD_SIZE)
        self.grid.load(level)
        self.bead_band = BeadBand(2*BOARD_MARGIN + BOARD_SIZE, BOTTOM_BAND_HEIGHT)

    def game_loop(self, screen):
        exit = False
        while not exit:
            for event in pygame.event.get():
                if event.type==pygame.QUIT:
                    exit = True
                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_ESCAPE:
                        exit = True
                if event.type == pygame.MOUSEBUTTONDOWN:
                    x,y = event.pos
                    # TODO: call self.bead_band.handle_click with the right values
            self.draw(screen)
            pygame.display.flip()

    def draw(self, surface):
        surface.fill(GREY)
        pygame.draw.rect(surface, WHITE, (0, TOP_BAND_HEIGHT, BOARD_SIZE+2*BOARD_MARGIN, BOARD_SIZE+2*BOARD_MARGIN))
        surface.blit(self.grid.draw(), (BOARD_MARGIN, TOP_BAND_HEIGHT + BOARD_MARGIN))
        surface.blit(self.bead_band.draw(), (0, TOP_BAND_HEIGHT + 2*BOARD_MARGIN + BOARD_SIZE))
```

Cette nouvelle classe contient du code qui était auparavant dans notre code principal. Nous pouvons supprimer ce code et le remplacer par notre classe:

```
game = Game("grid.sud")
game.game_loop(screen)
```

= Finaliser le code

Le code que nous venons d'écrire contient des `TODO`s ("à faire" en anglais). Il faut que tu les implémente.

Chaque fonction a une petite tâche, mais pas toujours simple. Certaines nécessiteront de bien y penser. N'hésites pas à utiliser un papier et un crayon, et prends ton temps pour y réfléchir.

#pro_tip[
Pour représenter un point, tu peux utiliser `pygame.math.Vector2`. Tu peux ajouter deux de ces objets pour bouger un point dans une certaine direction.
Par exemple, tu peux dessiner un `X` rouge avec:
```
center = pygame.math.Vector2(x, y)
delta1 = pygame.math.Vector2(CROSS_SIZE, CROSS_SIZE)
delta2 = pygame.math.Vector2(CROSS_SIZE, -CROSS_SIZE)
pygame.draw.line(surface, RED, center-delta1, center+delta1)
pygame.draw.line(surface, RED, center-delta2, center+delta2)
```
]
