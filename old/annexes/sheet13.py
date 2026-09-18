import pygame
import random

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

asteroid = pygame.image.load('../resources/meteorite.png')
asteroid = pygame.transform.scale(asteroid, (128, 128))
asteroids = []

x, y = 0, 0
reload_in = 0
new_asteroid_in = 0

MIN_X, MIN_Y = 0, 0
MAX_X = screen.get_width() - spaceship.get_width()
MAX_Y = screen.get_height() - spaceship.get_height()
RELOAD_DELAY = 20
V_MISSILE = 10
V_SPACESHIP = 5
NB_STARS = 200
NEW_ASTEROID_EVERY = 50

class Asteroid:

    def __init__(self):
        self.x = screen.get_width()
        self.y = random.randint(-asteroid.get_height(), screen.get_height())
        self.vx = random.randint(1, 10)
        self.vy = random.randint(-self.vx, self.vx)
        self.life = random.randint(1, 10)

    # Returns False if the asteroid disappeared from the screen
    def move(self):
        self.x -= self.vx
        self.y += self.vy
        if self.x + asteroid.get_width() < 0:
            return False
        if self.y + asteroid.get_height() < 0 or self.y > screen.get_height():
            return False
        return True

    def draw(self, screen):
        screen.blit(asteroid, (self.x, self.y))


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

def init_stars():
    stars = []
    for i in range(NB_STARS):
        stars.append((random.randint(0, screen.get_width()), random.randint(0, screen.get_height())))
    return stars

def move_stars(stars):
    for i in range(NB_STARS):
        stars[i] = (stars[i][0]-1, stars[i][1])
        if stars[i][0] == 0:
            stars[i] = (screen.get_width(), random.randint(0, screen.get_height()))

def draw_stars(screen):
    for i in range(NB_STARS):
        screen.set_at(stars[i], "white")

def fire_missiles(missiles):
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

def move_missiles(missiles):
    for (i, m) in enumerate(missiles):
        missiles[i] = (m[0] + V_MISSILE, m[1])

def new_asteroid(asteroids):
    global new_asteroid_in
    if new_asteroid_in == 0:
        asteroids.append(Asteroid())
        new_asteroid_in = NEW_ASTEROID_EVERY
    else:
        new_asteroid_in -= 1

def move_asteroids(asteroids):
    asteroids = [a for a in asteroids if a.move()]

def draw():
    screen.fill("black")
    draw_stars(screen)
    screen.blit(spaceship, (x, y))
    for a in asteroids:
        screen.blit(asteroid, (a.x, a.y))
    for m in missiles:
        screen.blit(missile, m)
    pygame.display.flip()

stars = init_stars()

while running:
    handle_events()
    move_spaceship()

    fire_missiles(missiles)
    move_missiles(missiles)

    move_stars(stars)

    new_asteroid(asteroids)
    move_asteroids(asteroids)

    draw()

    clock.tick(60)  # limits FPS to 60

pygame.quit()
