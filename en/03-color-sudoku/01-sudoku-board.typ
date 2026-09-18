#import "../template.typ": *

#show: doc => cs_sheet(
  title: "1. Creating a sudoku board",
  lang: "en",
  serie_icon: "resources/icons/sudoku.png",
  doc,
)

= The objective of this serie

Have you ever played sudoku?

In this serie, we want to create a game of sudoku in python. Instead of using numbers, we'll use colored beads.

This is what the game will look like:
#align(center)[#image("../../resources/screenshots/sudoku.png", height: 20em)]

The first thing we'll do, in this sheet, is write the code to create the board.

= Drawing lines

Pygame has a function to draw lines. You can find the documentation for it at https://www.pygame.org/docs/ref/draw.html#pygame.draw.line

The function takes 4 mandatory parameters and one optional parameter, and returns a rectangle that contains the line:

```
bounding_rect = pygame.draw.line(surface, color, start_pos, end_pos, width=1)
```

= Using lines to create a sudoku board

Type the following code:
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

You should see 2 vertical lines:
 - one thin line corresponding to `width=small_width`
 - one thick line corresponding to `width=large_width`

#practice[
Your objective now is to modify the `sudoku_board` function to draw the whole sudoku board. This will take multiple trials to get it right, there are many details to address.

There is a total of 20 lines to draw. But if you use some for loops, you could manage to write a function that only has 4 calls to `pygame.draw.line` or even less. Give it a try.
]

#attention[
If you try drawing a line from `(0, 0)` to `(0, size)` (or other combinations of 0 and size for horizontal and vertical lines on the border of the surface), you may notice that the line appears thiner than the other ones drawn with the same width in other places.

This is because the positions you give are the middle of the line, so half the line ends-up outside of the surface and is not drawn. If you want all lines to look the same, you have to find a way to compensate for that.

If you want the result to be perfect, you want all cells to have the same width and height.
]
