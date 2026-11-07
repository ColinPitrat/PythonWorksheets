#import "../template.typ": *

#show: doc => cs_sheet(
  title: "4. Placing a bead",
  lang: "en",
  serie_icon: "resources/icons/sudoku.png",
  doc,
)

= The objective of this sheet

In this sheet, we will place a bead (or remove the one present) when the player
clicks on the grid.

As we do this, we'll need to be able to differentiate hints (beads that are present from the start of the game) from beads placed by the player. We'll also make this difference visible to the player.

= Modifying the code

Let's introduce a new constant that will define the size of the border of hints. 
```
HINT_MARGIN = 1
```

We'll also introduce a function (that you'll have to complete) to find if a list
of elements has duplicates in it. This function is at the top level (not in any
class).
```
def has_duplicates(elements):
    # TODO: A function that returns true if the list passed has duplicates.
    return False
```

We need to change `SudokuGrid` class so that it identifies the hints.
Most of this code already exists. Only the lines starting with a `+` need to be
added.
```
class SudokuGrid(object):

  def __init__(self, size):
    self._size = size
    self._board = [[None for _ in range(9)] for _ in range(9)]
+   self._hints = [[None for _ in range(9)] for _ in range(9)]
    self._cell_size = (self._size - 4*THICK_LINE - 6*THIN_LINE) / 9
    self.init_centers()

  (...)
  def load(self, filename):
    with open(filename, "r") as file:
      (...)
      self._board = [[read_cell(c.strip()) for c in row.split(',')] for row in rows]
+     self._hints = [[read_cell(c.strip()) for c in row.split(',')] for row in rows]

  (...)
  def draw(self):
    surface = self.sudoku_board()
    for i in range(9):
        for j in range(9):
            val = self._board[j][i]
+           if self._hints[j][i]:
+               pygame.draw.circle(surface, BLACK, self._centers[i][j], BEAD_SIZE+HINT_MARGIN)
            if val:
                pygame.draw.circle(surface, COLORS[val-1], self._centers[i][j], BEAD_SIZE)
    return surface
```

We also need to add these new methods to `SudokuGrid`, most of which you'll need
to complete:
```
  def handle_click(self, x, y, selected):
    if selected is None:
        return
    # TODO: Insert a bead in the right cell (or remove it if selected=9)
    if self.won():
        print("Well done!")

  def is_valid(self):
    # TODO: Using has_duplicates, return True if there are duplicates in any row, column or box.
    return True

  def is_full(self):
    # TODO: Return true if all cells of the grid are filled.
    return False

  def won(self):
    return self.is_full() and self.is_valid()
```

A small change is needed in `BeadBand` to make `handle_click` return the
selected color:
```
class BeadBand(object):
    (...)
    def handle_click(self, x, y):
        click_point = pygame.math.Vector2(x, y)
        for i in range(len(COLORS)+1):
            if click_point.distance_to(self.centers[i]) <= BEAD_SIZE:
                self.selected = i
+       return self.selected
```

And finally, the `Game` class needs to track the selected color and pass click
events to `SudokuGrid`:

```
class Game(object):

    def __init__(self, level):
        self.grid = SudokuGrid(BOARD_SIZE)
        self.grid.load(level)
        self.bead_band = BeadBand(2*BOARD_MARGIN + BOARD_SIZE, BOTTOM_BAND_HEIGHT)
+       self.selected = None

    def game_loop(self, screen):
        exit = False
        while not exit:
            for event in pygame.event.get():
                (...)
                if event.type == pygame.MOUSEBUTTONDOWN:
                    x,y = event.pos
+                   grid_y = TOP_BAND_HEIGHT + BOARD_MARGIN
                    bottom_band_y = TOP_BAND_HEIGHT + 2*BOARD_MARGIN + BOARD_SIZE
+                   if y > grid_y and y < bottom_band_y:
+                       self.grid.handle_click(x-BOARD_MARGIN, y-grid_y, self.selected)
+                   elif y > bottom_band_y:
+                       self.selected = self.bead_band.handle_click(x, y-bottom_band_y)
            self.draw(screen)
            pygame.display.flip()
```

= Complete the code

The code contains some `TODO`s that you need to implement.

You can start with `handle_click` which should be the most satisfying part,
allowing you to finally place bead and play... but with no way of "winning".

You can then move to `is_full` which should be easy to implement.

Finally, implement `has_duplicates` which you'll need to be able to proceed
with `is_valid`. You'll need 3 loops, including a nested loop for the last one,
to call `has_duplicates` on all rows, all columns and finally all blocks.
