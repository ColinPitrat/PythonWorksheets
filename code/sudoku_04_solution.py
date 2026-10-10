#!/usr/bin/python
# -*- coding: utf8 -*-"

import pygame

BLACK = pygame.Color(0, 0, 0)
GREY = pygame.Color(128, 128, 128)
LIGHT_GREY = pygame.Color(192, 192, 192)
WHITE = pygame.Color(255, 255, 255)
RED = pygame.Color(255, 0, 0)

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
HINT_MARGIN = 1
SELECTION_MARGIN = 2
CROSS_SIZE = 6
CROSS_LINE_WIDTH = 3
BOARD_MARGIN = 50
BOARD_SIZE = 400
TOP_BAND_HEIGHT = 60
BOTTOM_BAND_HEIGHT = 60

THICK_LINE = 9
THIN_LINE = 3

WIDTH, HEIGHT = BOARD_SIZE + 2*BOARD_MARGIN, TOP_BAND_HEIGHT + BOARD_SIZE + 2*BOARD_MARGIN + BOTTOM_BAND_HEIGHT

def has_duplicates(elements):
    return len(set(list(elements))) != len(list(elements))

class SudokuGrid(object):

  def __init__(self, size):
    self._size = size
    self._board = [[None for _ in range(9)] for _ in range(9)]
    self._hints = [[None for _ in range(9)] for _ in range(9)]
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
      self._hints = [[read_cell(c.strip()) for c in row.split(',')] for row in rows]

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
            if self._hints[j][i]:
                pygame.draw.circle(surface, BLACK, self._centers[i][j], BEAD_SIZE+HINT_MARGIN)
            if val:
                pygame.draw.circle(surface, COLORS[val-1], self._centers[i][j], BEAD_SIZE)
    return surface

  def handle_click(self, x, y, selected):
    if selected is None:
        return
    click_point = pygame.math.Vector2(x, y)
    for (i, column) in enumerate(self._centers):
        for (j, c) in enumerate(column):
            if click_point.distance_to(c) <= BEAD_SIZE:
                if self._hints[j][i]:
                    # It's not allowed to overwrite a hint!
                    return
                if selected < len(COLORS):
                    self._board[j][i] = selected+1
                else:
                    self._board[j][i] = None
    if self.won():
        print("Well done!")

  def is_valid(self):
    for (i, row) in enumerate(self._board):
        row = [c for c in row if c is not None]
        if has_duplicates(row):
            return False
    for j in range(len(self._board)):
        column = [self._board[i][j] for i in range(len(self._board)) if self._board[i][j] is not None]
        if has_duplicates(column):
            return False
    for i in range(3):
        for j in range(3):
            elems = [self._board[i+di][j+dj] for di in range(3) for dj in range(3) if self._board[i+di][j+dj] is not None]
            if has_duplicates(column):
                return False
    return True

  def is_full(self):
    for row in self._board:
        for cell in row:
            if cell is None:
                return False
    return True

  def won(self):
    return self.is_full() and self.is_valid()


class BeadBand(object):

    def __init__(self, width, height):
        self.width = width
        self.height = height
        self.surface = pygame.Surface((self.width, self.height))
        self.selected = None
        self.compute_centers_pos()

    def compute_centers_pos(self):
        # Total space not used by beads.
        # BEAD_SIZE is the radius, hence the factor 2.
        spacing = (self.width - (len(COLORS)+1)*2*BEAD_SIZE)/(len(COLORS)+2)
        # There's one less interval between beads than beads
        centers_spacing = spacing + 2*BEAD_SIZE
        # but there's also 2 half intervals on each side.
        border_spacing = spacing + BEAD_SIZE
        # 1 button per bead color + 1 button to erase
        self.centers = []
        for i in range(len(COLORS)+1):
            self.centers.append(pygame.math.Vector2(int(centers_spacing*i + border_spacing), int(self.height/2)))

    def draw(self):
        self.surface.fill(GREY)
        self.compute_centers_pos()
        for (i, c) in enumerate(self.centers):
            if self.selected == i:
                pygame.draw.circle(self.surface, WHITE, self.centers[i], BEAD_SIZE+SELECTION_MARGIN)
            if i < len(COLORS):
                pygame.draw.circle(self.surface, COLORS[i], self.centers[i], BEAD_SIZE)
            else:
                pygame.draw.circle(self.surface, LIGHT_GREY, self.centers[i], BEAD_SIZE)
                pygame.draw.line(self.surface, RED,
                        self.centers[i]-pygame.math.Vector2(CROSS_SIZE+1, CROSS_SIZE),
                        self.centers[i]+pygame.math.Vector2(CROSS_SIZE, CROSS_SIZE),
                        width=CROSS_LINE_WIDTH)
                pygame.draw.line(self.surface, RED,
                        self.centers[i]-pygame.math.Vector2(CROSS_SIZE+1, -CROSS_SIZE),
                        self.centers[i]+pygame.math.Vector2(CROSS_SIZE, -CROSS_SIZE),
                        width=CROSS_LINE_WIDTH)
        return self.surface

    def handle_click(self, x, y):
        click_point = pygame.math.Vector2(x, y)
        for i in range(len(COLORS)+1):
            if click_point.distance_to(self.centers[i]) <= BEAD_SIZE:
                self.selected = i
        return self.selected


class Game(object):

    def __init__(self, level):
        self.grid = SudokuGrid(BOARD_SIZE)
        self.grid.load(level)
        self.bead_band = BeadBand(2*BOARD_MARGIN + BOARD_SIZE, BOTTOM_BAND_HEIGHT)
        self.selected = None

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
                    grid_y = TOP_BAND_HEIGHT + BOARD_MARGIN
                    bottom_band_y = TOP_BAND_HEIGHT + 2*BOARD_MARGIN + BOARD_SIZE
                    if y > grid_y and y < bottom_band_y:
                        self.grid.handle_click(x-BOARD_MARGIN, y-grid_y, self.selected)
                    elif y > bottom_band_y:
                        self.selected = self.bead_band.handle_click(x, y-bottom_band_y)
            self.draw(screen)
            pygame.display.flip()

    def draw(self, surface):
        surface.fill(GREY)
        pygame.draw.rect(surface, WHITE, (0, TOP_BAND_HEIGHT, BOARD_SIZE+2*BOARD_MARGIN, BOARD_SIZE+2*BOARD_MARGIN))
        surface.blit(self.grid.draw(), (BOARD_MARGIN, TOP_BAND_HEIGHT + BOARD_MARGIN))
        surface.blit(self.bead_band.draw(), (0, TOP_BAND_HEIGHT + 2*BOARD_MARGIN + BOARD_SIZE))


pygame.display.set_caption("Color sudoku")
screen = pygame.display.set_mode((WIDTH, HEIGHT))

game = Game("grid.sud")
game.game_loop(screen)

pygame.quit()
