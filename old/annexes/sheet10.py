import pygame

pygame.init()
screen = pygame.display.set_mode((800, 600))
clock = pygame.time.Clock()
running = True

spaceship = pygame.image.load('../resources/spaceship.png')
# Our spaceship points up, make it point right.
spaceship = pygame.transform.rotate(spaceship, -90)
spaceship = pygame.transform.scale(spaceship, (64, 64))
x, y = 0, 0

MIN_X, MIN_Y = 0, 0
MAX_X = screen.get_width() - spaceship.get_width()
MAX_Y = screen.get_height() - spaceship.get_height()

def handle_events():
    global running
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

def move_spaceship():
    global x, y
    pressed = pygame.key.get_pressed()
    if pressed[pygame.K_UP]:
        y -= V_SPACESHIP
    if pressed[pygame.K_DOWN]:
        y += V_SPACESHIP
    if pressed[pygame.K_LEFT]:
        x -= V_SPACESHIP
    if pressed[pygame.K_RIGHT]:
        x += V_SPACESHIP
    if x < 0:
        x = 0
    if x >= screen.get_width() - spaceship.get_width():
        x = MAX_X
    if y < 0:
        y = 0
    if y >= MAX_Y:
        y = MAX_Y

def draw():
    screen.fill("black")
    screen.blit(spaceship, (x, y))
    pygame.display.flip()

while running:
    handle_events()
    move_spaceship()
    draw()

    clock.tick(60)  # limits FPS to 60

pygame.quit()
