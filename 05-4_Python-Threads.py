#!/usr/bin/python3

import threading
import time

interrupt_interval=5 # in Sekunden

# ACHTUNG:
# * `interrupt` ist "Shared State"!
# * ... und ist *nicht* synchronisiert!
# * -> das ist *nicht* korrekt!
#
interrupt=False

def interrupt_controller_thread():
  while True:
    global interrupt
    time.sleep(interrupt_interval)
    print("Triggering interrupt")
    interrupt=True

def cpu_handle_interrupt():
    global interrupt

    if interrupt == True:
      print("Woah I got an interrupt")
      # now act on the interrupt...
      interrupt = False

def cpu_print_result():
    True # a CPU doesn't print anything, it saves the
         # result somewhere instead...

def cpu_thread():
  while True:
    # Read, Eval, (optional: Print), Loop
    print("I am reading the next instruction")
    print("I am evaluating the instruction")
    time.sleep(1) # python threading doesn't really work
    cpu_handle_interrupt()

cpu = threading.Thread( target = cpu_thread )
pic = threading.Thread( target = interrupt_controller_thread )

cpu.start()
pic.start()

cpu.join()
pic.join()

