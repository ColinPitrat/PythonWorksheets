#!/usr/bin/python
# -*- coding: utf8 -*-"

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
