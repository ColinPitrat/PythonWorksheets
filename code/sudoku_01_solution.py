#!/usr/bin/python
# -*- coding: utf8 -*-"

import pygame

BLACK = pygame.Color(0, 0, 0)
WHITE = pygame.Color(255, 255, 255)

BOARD_MARGIN = 50
BOARD_SIZE = 400

THICK_LINE = 9
THIN_LINE = 3

WIDTH, HEIGHT = BOARD_SIZE + 2*BOARD_MARGIN, BOARD_SIZE + 2*BOARD_MARGIN

class SudokuGrid(object):

  def __init__(self, size):
    self._size = size

  def sudoku_board(self):
      board = pygame.Surface((self._size, self._size))
      board.fill(WHITE)
      large_width = THICK_LINE
      small_width = THIN_LINE
      dl = large_width // 2
      ds = small_width // 2
      cell_size = (self._size - 4*THICK_LINE - 6*THIN_LINE) / 9
      # We have 4 thick lines separating 3 big blocks.
      # If we remove one thick line width from size, we get 3 times the delta between 2 thick lines.
      block_delta = (self._size - large_width) / 3
      large_lines_positions = [dl, block_delta+dl, 2*block_delta+dl, 3*block_delta+dl]
      # The thin lines positions are taken relative to the middle of the previous thick line.
      small_lines_positions = [dl+cell_size+ds, dl+2*cell_size+small_width+ds]
      for x in large_lines_positions:
          for y in large_lines_positions:
              pygame.draw.line(board, BLACK, (x, 0), (x, self._size), width=large_width)
              pygame.draw.line(board, BLACK, (0, y), (self._size, y), width=large_width)
              for dx in small_lines_positions:
                  for dy in small_lines_positions:
                      pygame.draw.line(board, BLACK, (x+dx, 0), (x+dx, self._size), width=small_width)
                      pygame.draw.line(board, BLACK, (0, y+dy), (self._size, y+dy), width=small_width)
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
