# To use cocotb
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.triggers import RisingEdge
from cocotb.handle import Force, Release, Deposit

# Import pygame for graphical representation
import pygame

#class Personaje:
#    def __init__(self,image,height,speed):
#        self.speed=speed
#        self.image=image
#        self.pos=image.get_rect().move(0,height)
#    def move(self):
#        self.pos=self.pos.move(0,self.speed)
#        if self.pos.right > 600:
#            self.pos.left=0

#personaje1=Personaje()
#personaje2=Personaje()
            
# Times in nanoseconds
CLK_PERIOD     = 20
RESET_DURATION = 20

# Times in miliseconds
TEST_DURATION  = 20


# Window size. The screen can be bigger than needed for the VGA, so in the
# extra space we may render buttons, leds, etc
SCREEN_SIZE       = (200, 60)



# Initalize the screen (game window). The VGA pixels will be rendered in a
# surface which will be drawn on the screen
def init_screen():
    pygame.init()
    screen = pygame.display.set_mode((SCREEN_SIZE))
    
    n_player1=pygame.image.load('Normal.png').convert_alpha()
    a_player1=pygame.image.load('Ataque.png').convert_alpha()
    d_player1=pygame.image.load('Defensa.png').convert_alpha()

    images1=[n_player1,a_player1,d_player1]

    n_player2=pygame.transform.flip(n_player1,True,False)
    a_player2=pygame.transform.flip(a_player1,True,False)
    d_player2=pygame.transform.flip(d_player1,True,False)


    images2=[n_player2,a_player2,d_player2]

    background=pygame.transform.scale(pygame.image.load('background.jpg').convert(),(SCREEN_SIZE))
    game_over=pygame.transform.scale(pygame.image.load('game_over.jpg').convert(),(SCREEN_SIZE))

    layouts=[screen,background,game_over]
    
    return layouts,images1,images2

@cocotb.coroutine
def update_screen(dut,layouts,images1,images2): #(x, y, color):
    while True:
        yield RisingEdge(dut.clk)
        if dut.fin_juego==1:
            layouts[0].blit(layouts[2],(0,0))
        else:
            layouts[0].blit(layouts[1],(0,0))
            if dut.estado_luchad1 ==0b00:
                layouts[0].blit(images1[0], (dut.pos1,10))
            if dut.estado_luchad1 == 0b01:
                layouts[0].blit(images1[1], (dut.pos1,10))
            if dut.estado_luchad1 == 0b10:
                layouts[0].blit(images1[2], (dut.pos1,10))
            if dut.estado_luchad2 ==0b00:
                layouts[0].blit(images2[0], (dut.pos2,10))
            if dut.estado_luchad2 == 0b01:
                layouts[0].blit(images2[1], (dut.pos2,10))
            if dut.estado_luchad2 == 0b10:
                layouts[0].blit(images2[2], (dut.pos2,10))

        pygame.display.flip()

# Check for key presses. Key reference is at:
# https://www.pygame.org/docs/ref/key.html
@cocotb.coroutine
def check_for_events(dut):
    while True:
        yield RisingEdge(dut.clk)
        for event in pygame.event.get():
            #dut._log.info("Event: %r", event)
            if event.type == pygame.QUIT:
                raise SystemExit
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_UP:
                    dut._log.info("UP key pressed")
                    dut.UP = 1
                elif event.key == pygame.K_DOWN:
                    dut._log.info("DOWN key pressed")
                    dut.DOWN = 1
                elif event.key == pygame.K_LEFT:
                    dut._log.info("LEFT key pressed")
                    dut.LEFT = 1
                elif event.key == pygame.K_RIGHT:
                    dut._log.info("RIGHT key pressed")
                    dut.RIGHT = 1
                if event.key == pygame.K_w:
                    dut._log.info("W key pressed")
                    dut.W = 1
                elif event.key == pygame.K_s:
                    dut._log.info("S key pressed")
                    dut.S = 1
                elif event.key == pygame.K_a:
                    dut._log.info("A key pressed")
                    dut.A = 1
                elif event.key == pygame.K_d:
                    dut._log.info("D key pressed")
                    dut.D = 1
            elif event.type == pygame.KEYUP:
                if event.key == pygame.K_UP:
                    dut._log.info("UP key released")
                    dut.UP = 0
                elif event.key == pygame.K_DOWN:
                    dut._log.info("DOWN key released")
                    dut.DOWN = 0
                elif event.key == pygame.K_LEFT:
                    dut._log.info("LEFT key released")
                    dut.LEFT = 0
                elif event.key == pygame.K_RIGHT:
                    dut._log.info("RIGHT key released")
                    dut.RIGHT = 0
                if event.key == pygame.K_w:
                    dut._log.info("W key released")
                    dut.W = 0
                elif event.key == pygame.K_s:
                    dut._log.info("S key released")
                    dut.S = 0
                elif event.key == pygame.K_a:
                    dut._log.info("A key released")
                    dut.A = 0
                elif event.key == pygame.K_d:
                    dut._log.info("D key released")
                    dut.D = 0

@cocotb.test()
def test(dut):
    dut._log.info("Running test")

    # All buttons begin non-pressed (avoid 'U' values)
    dut.UP = 0
    dut.DOWN = 0
    dut.LEFT = 0
    dut.RIGHT = 0
    dut.W = 0
    dut.A = 0
    dut.S = 0
    dut.D = 0

    # Init screen
    layouts,images1,images2 = init_screen() 
 
    # Fork coroutine that continuosly updates the screen
    cocotb.fork(update_screen(dut,layouts,images1,images2))

    # Fork coroutine that continuosly checks for button presses
    cocotb.fork(check_for_events(dut))

    # Manage clock
    dut._log.info("Starting clock manager")
    c = Clock(dut.clk, CLK_PERIOD, 'ns')
    cocotb.fork(c.start())

    # Assert and deassert reset
    dut.reset = 1
    yield Timer(RESET_DURATION, units='ns')
    dut.reset = 0

    # Wait until desired time
    dut._log.info("Entering for loop")
    for i in range (1, TEST_DURATION):
        yield Timer(1, units='ms')
        dut._log.info("%d ms simulated", i);

    dut._log.info("End of test")
