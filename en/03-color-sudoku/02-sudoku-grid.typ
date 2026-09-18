#import "../template.typ": *

#show: doc => cs_sheet(
  title: "2. Creating a sudoku grid",
  lang: "en",
  serie_icon: "resources/icons/sudoku.png",
  doc,
)

= The objective of this sheet

In the previous sheet, we saw how to draw the sudoku board. In this sheet, we will focus on representing the sudoku grid in the python code.

This will be necessary to know where the hints are, what beads have been placed by the player and do all the computations that will be needed to determine if there's an issue with the grid (like two times the same color in a row), if the player won, provide a solution, etc ...

= Representing the grid

Although we want to show the sudoku to the player using color beads, we'll represent it internally using numbers.

The sudoku grid is a 2 dimensional array (it has rows and columns) and python is able to represent that directly using an array of arrays. We'll store this data in a class that we'll call SudokuGrid.

Add the following to your existing program constants (at the beginning):

```
COLORS = [
    pygame.Color(255, 0, 0),     # Red
    pygame.Color(255, 128, 0),   # Orange
    pygame.Color(255, 255, 0),   # Yellow
    pygame.Color(128, 255, 128), # Light green
    pygame.Color(0, 128, 0),     # Dark green
    pygame.Color(180, 200, 255), # Light blue
    pygame.Color(0, 0, 255),     # Dark blue
    pygame.Color(255, 128, 255), # Pink
    pygame.Color(128, 0, 128),   # Purple
]

BEAD_SIZE = 15
```

And then modify the SudokuGrid class by updating the `__init__` function and introducing two new functions:
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

Finally, modify the code to create the grid, load it from a file and draw it on top of your board.
New lines are starting with a `+` (that you must not type!), lines to be removed are starting with a `-`:
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

This new code is loading a sudoku grid from a file called `grid.sud`. So create this file with the following content:
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
Your objective now is to draw all the beads from `self._board` instead of a single red one in a hard-coded position. You need to loop on all the rows and all the columns of the board, and decide which color to use based on the value that is stored at this position. Use `self._board[i][j]` to access the value stored at row `i` and column `j`. Be careful, rows and columns are numbered from 0 to 8, not 1 to 9.
]

#attention[
If you place beads regularly based on their position, you may notice that beads are not perfectly aligned with the grid. That's because the grid has some irregularity introduced by the larger lines, which means some cells are slightly bigger than others. If you want a perfect result, you'll need to take that into account.

As you do this, you may find some issues with your grid, in which case you'll need to modify it too!
]
