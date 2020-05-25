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

# VGA resolution
VGA_SIZE       = (200, 60)


# Window size. The screen can be bigger than needed for the VGA, so in the
# extra space we may render buttons, leds, etc
SCREEN_SIZE       = (200, 60)



# Initalize the screen (game window). The VGA pixels will be rendered in a
# surface which will be drawn on the screen
def init_screen():
    pygame.init()
    screen = pygame.display.set_mode((SCREEN_SIZE))
    #surface=pygame.Surface((VGA_SIZE))
    
    n_player=pygame.image.load('Normal.png').convert_alpha()
    a_player=pygame.image.load('Ataque.png').convert_alpha()
    d_player=pygame.image.load('Defensa.png').convert_alpha()

    images=[n_player,a_player,d_player]
    

    
   #surface=pygame.transform.scale(pygame.image.load('background.jpg').convert(),(VGA_SIZE))
   # screen.blit(surface,(0,0))
    return screen,images

@cocotb.coroutine
def update_screen(dut, screen,images): #(x, y, color):
    while True:
        yield RisingEdge(dut.clk)
        screen.fill((255,255,255))
        print(type(dut.estado_lucha))
        if dut.estado_lucha =='00':
            screen.blit(images[0], (0,0))
        if dut.estado_lucha == '01':
            screen.blit(images[1], (0,0))
        if dut.estado_lucha == '10':
            screen.blit(images[2], (0,0))        
        

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
                    dut.up = 1
                elif event.key == pygame.K_DOWN:
                    dut._log.info("DOWN key pressed")
                    dut.down = 1
               # elif event.key == pygame.K_LEFT:
               #     dut._log.info("LEFT key pressed")
               #     dut.button_left = 1
               # elif event.key == pygame.K_RIGHT:
               #     dut._log.info("RIGHT key pressed")
               #     dut.button_right = 1
            elif event.type == pygame.KEYUP:
                if event.key == pygame.K_UP:
                    dut._log.info("UP key released")
                    dut.up = 0
                elif event.key == pygame.K_DOWN:
                    dut._log.info("DOWN key released")
                    dut.down = 0
               # elif event.key == pygame.K_LEFT:
               #     dut._log.info("LEFT key released")
               #     dut.button_left = 0
               # elif event.key == pygame.K_RIGHT:
               #     dut._log.info("RIGHT key released")
               #     dut.button_right = 0

@cocotb.test()
def test(dut):
    dut._log.info("Running test")

    # All buttons begin non-pressed (avoid 'U' values)
    dut.up = 0
    dut.down = 0
   # dut.button_left = 0
   # dut.button_right = 0

    # Init screen
    screen,images = init_screen() 
 

    # Fork coroutine that continuosly updates the screen
    cocotb.fork(update_screen(dut, screen,images))

    # Fork coroutine that continuosly checks for button presses
    cocotb.fork(check_for_events(dut))

    # Manage clock
    dut._log.info("Starting clock manager")
    c = Clock(dut.clk, CLK_PERIOD, 'ns')
    cocotb.fork(c.start())

    # Assert and deassert reset
    dut.rst = 1
    yield Timer(RESET_DURATION, units='ns')
    dut.rst = 0

    # Wait until desired time
    dut._log.info("Entering for loop")
    for i in range (1, TEST_DURATION):
        yield Timer(1, units='ms')
        dut._log.info("%d ms simulated", i);

    dut._log.info("End of test")
