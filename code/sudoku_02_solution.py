#!/usr/bin/python
# -*- coding: utf8 -*-"

import pygame

BLACK = pygame.Color(0, 0, 0)
WHITE = pygame.Color(255, 255, 255)

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
BOARD_MARGIN = 50
BOARD_SIZE = 400

THICK_LINE = 9
THIN_LINE = 3

WIDTH, HEIGHT = BOARD_SIZE + 2*BOARD_MARGIN, BOARD_SIZE + 2*BOARD_MARGIN

class SudokuGrid(object):

  def __init__(self, size):
    self._size = size
    self._board = [[None for _ in range(9)] for _ in range(9)]
    self._cell_size = (self._size - 4*THICK_LINE - 6*THIN_LINE) / 9
    self.init_centers()

  def init_centers(self):
    self._centers = [[(0, 0) for _ in range(9)] for _ in range(9)]
    center_pos = []
    pos = THICK_LINE
    for i in range(9):
        center_pos.append(pos + self._cell_size/2)
        pos += self._cell_size
        if i % 3 != 2:
            pos += THIN_LINE
        else:
            pos += THICK_LINE
    for (i, x) in enumerate(center_pos):
        for (j, y) in enumerate(center_pos):
            self._centers[i][j] = (x, y)

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

  def sudoku_board(self):
    board = pygame.Surface((self._size, self._size))
    board.fill(WHITE)
    large_width = THICK_LINE
    small_width = THIN_LINE
    dl = large_width // 2
    ds = small_width // 2
    # We have 4 thick lines separating 3 big blocks.
    # If we remove one thick line width from size, we get 3 times the delta between 2 thick lines.
    block_delta = (self._size - large_width) / 3
    large_lines_positions = [dl, block_delta+dl, 2*block_delta+dl, 3*block_delta+dl]
    # The thin lines positions are taken relative to the middle of the previous thick line.
    small_lines_positions = [dl+self._cell_size+ds, dl+2*self._cell_size+small_width+ds]
    for x in large_lines_positions:
        for y in large_lines_positions:
            pygame.draw.line(board, BLACK, (x, 0), (x, self._size), width=large_width)
            pygame.draw.line(board, BLACK, (0, y), (self._size, y), width=large_width)
            for dx in small_lines_positions:
                for dy in small_lines_positions:
                    pygame.draw.line(board, BLACK, (x+dx, 0), (x+dx, self._size), width=small_width)
                    pygame.draw.line(board, BLACK, (0, y+dy), (self._size, y+dy), width=small_width)
    return board

  def draw(self):
    surface = self.sudoku_board()
    for i in range(9):
        for j in range(9):
            val = self._board[j][i]
            if val:
                pygame.draw.circle(surface, COLORS[val-1], self._centers[i][j], BEAD_SIZE)
    return surface


pygame.display.set_caption("Color sudoku")
screen = pygame.display.set_mode((WIDTH, HEIGHT))

exit = False
grid = SudokuGrid(BOARD_SIZE)
grid.load("grid.sud")
while not exit:
    screen.fill(WHITE)
    for event in pygame.event.get():
        if event.type==pygame.QUIT:
            exit = True
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_ESCAPE:
                exit = True
    screen.blit(grid.draw(), (BOARD_MARGIN, BOARD_MARGIN))
    pygame.display.flip()

pygame.quit()
