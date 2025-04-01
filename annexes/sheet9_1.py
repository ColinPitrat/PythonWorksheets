import pygame

pygame.init()
screen = pygame.display.set_mode((800, 600))
clock = pygame.time.Clock()
running = True
ball = pygame.image.load('ball.png')
x, y = 0, 0
vx, vy = 10, 10

while running:
    # poll for events
    # pygame.QUIT event means the user clicked X to close your window
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # fill the screen with a color to wipe away anything from last frame
    screen.fill("black")

    # show the ball
    screen.blit(ball, (x, y))

    # move the ball
    x += vx
    y += vy
    if x < 0 or x >= screen.get_width() - ball.get_width():
        vx = -vx
    if y < 0 or y >= screen.get_height() - ball.get_height():
        vy = -vy

    # flip() the display to put your work on screen
    pygame.display.flip()

    clock.tick(60)  # limits FPS to 60

pygame.quit()
