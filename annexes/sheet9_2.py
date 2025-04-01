import pygame

pygame.init()
screen = pygame.display.set_mode((800, 600))
clock = pygame.time.Clock()
running = True
ball = pygame.image.load('ball.png')
x, y = 0, 0
vx, vy = 0, 0

while running:
    # poll for events
    # pygame.QUIT event means the user clicked X to close your window
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_UP:
                # For "inertial" control, modify vx/vy
                #vy -= 10
                # For "direct" contrl, modify x/y
                #y -= 10
                print("Up pressed")
            if event.key == pygame.K_DOWN:
                #vy += 10
                #y += 10
                print("Down pressed")
            if event.key == pygame.K_LEFT:
                #vx -= 10
                #x -= 10
                print("Left pressed")
            if event.key == pygame.K_RIGHT:
                #vx += 10
                #x += 10
                print("Right pressed")

    pressed = pygame.key.get_pressed()
    if pressed[pygame.K_UP]:
        y -= 10
    if pressed[pygame.K_DOWN]:
        y += 10
    if pressed[pygame.K_LEFT]:
        x -= 10
    if pressed[pygame.K_RIGHT]:
        x += 10
    if x < 0:
        x = 0
    if x >= screen.get_width() - ball.get_width():
        x = screen.get_width() - ball.get_width()
    if y < 0:
        y = 0
    if y >= screen.get_height() - ball.get_height():
        y = screen.get_height() - ball.get_height()

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
