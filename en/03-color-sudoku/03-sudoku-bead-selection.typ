#import "../template.typ": *

#show: doc => cs_sheet(
  title: "3. Selecting the color to play",
  lang: "en",
  serie_icon: "resources/icons/sudoku.png",
  doc,
)

= The objective of this sheet

In this sheet, we will add a user interface element to select the color to play.
There will also be a special 10th "action" to remove a bead from the grid.

We'll introduce space for two bands: one at the top and one at the bottom.
We'll only use the bottom one for now. The top one will be useful later to add more actions (undo/redo, new game, reset grid, save, etc...).

= Modifying the code

We'll need to evolve our code a bit to make things easier for us. This is called *refactoring*.

Let's introduce some new constants. Be sure to keep your constants organized!
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
The last line already exists in your code, we're only modifying `HEIGHT` to take into account the new bands.
You need to modify the existing line of code, not add a new one. Make sure this line is *after* all the constants it's using.
]

Now let's introduce a new class to handle our bottom band:
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

And move our game logic in a dedicated object:
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

This new class contain some code that was previously in our main code. We can remove this old code and replace it with our new class:

```
game = Game("grid.sud")
game.game_loop(screen)
```

= Complete the code

The code that you just typed contains some `TODO`s. You'll have to implement them.

Each function is a small, but not always easy, task. Some of them will require some thinking. Take a pen and paper to draw what you're trying to do and think about it carefully.

#pro_tip[
To represent a point, you can use `pygame.math.Vector2`. You can then add two of these ojects to move a point by a given value.
For example, you can draw a red `X` with the following code:
```
center = pygame.math.Vector2(x, y)
delta1 = pygame.math.Vector2(CROSS_SIZE, CROSS_SIZE)
delta2 = pygame.math.Vector2(CROSS_SIZE, -CROSS_SIZE)
pygame.draw.line(surface, RED, center-delta1, center+delta1)
pygame.draw.line(surface, RED, center-delta2, center+delta2)
```
]
