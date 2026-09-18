import pygame

pygame.init()
screen = pygame.display.set_mode((800, 600))
clock = pygame.time.Clock()
running = True

spaceship = pygame.image.load('../resources/spaceship.png')
# Our spaceship points up, make it point right.
spaceship = pygame.transform.rotate(spaceship, -90)
spaceship = pygame.transform.scale(spaceship, (64, 64))

missile = pygame.image.load('../resources/fireball.png')
missile = pygame.transform.scale(missile, (16, 16))
missiles = []

x, y = 0, 0
reload_in = 0

MIN_X, MIN_Y = 0, 0
MAX_X = screen.get_width() - spaceship.get_width()
MAX_Y = screen.get_height() - spaceship.get_height()
RELOAD_DELAY = 20
V_MISSILE = 10
V_SPACESHIP = 5

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

def fire_missiles():
    global reload_in
    if reload_in == 0:
        pressed = pygame.key.get_pressed()
        if pressed[pygame.K_SPACE]:
            reload_in = RELOAD_DELAY
            # Positions of canons in (512, 512) spaceship:
            #   (360, 25), (480, 105), (480, 370), (360, 450)
            # We're placing a (16, 16) missile sprite, so shifting y by ~-8
            # Scaling the result for a (64, 64) spaceship.
            missiles.append((x+43, y-2))
            missiles.append((x+43, y+50))
            missiles.append((x+60, y+8))
            missiles.append((x+60, y+42))
    else:
        reload_in -= 1

def move_missiles():
    for (i, m) in enumerate(missiles):
        missiles[i] = (m[0] + V_MISSILE, m[1])

def draw():
    screen.fill("black")
    screen.blit(spaceship, (x, y))
    for m in missiles:
        screen.blit(missile, m)
    pygame.display.flip()

while running:
    handle_events()
    move_spaceship()

    fire_missiles()
    move_missiles()

    draw()

    clock.tick(60)  # limits FPS to 60

pygame.quit()
