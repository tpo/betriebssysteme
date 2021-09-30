Aufgabe
-------

Letztes Mal haben wir Maschinen Code für
unsere Python CPU geschrieben, welcher
"Kooperatives Multitasking" macht. Der
Maschinen Code bestand aus folgenden
Teilen besteht:

* einem Scheduler
* einem Programm 1 (das nichts macht)
* einem Programm 2 (das auch nichts macht)

Der Scheduler springt in das Programm 1.
Das Programm 1 springt zurück in die
Mitte des Schedulers. Der Scheduler
springt ins Programm 2. Das Programm 2
sprint an den Anfang des Schedulers.
Der Ablauf fängt von vorn an.

Nun wollen wir nicht-kooperatives
Multitasking umsetzen.

Dazu erweitern wir unsere Python CPU.
Diese besteht nun aus 2 Teilen:

* einer CPU
* und einem Timer/Clock, welcher periodisch
  einen Interrupt setzt

Die CPU prüft nach jeder Ausführung
eines Maschinenbefehls, ob ein
Interrupt gesetzt wurde.

Wenn das der Fall ist, dann springt
die CPU in den Scheduler/Interrupt
Handler (ich verwende Scheduler/
Interrupt Handler unten synonym,
da wir im Moment ausschliesslich
den Scheduler haben, welcher bei
Interrupts aufgerufen wird). Dieser
entscheidet, welches der beiden
Programme er ausführen will
(bitte so einfach wie möglich, z.B
via round robin: 1-2-1-2-1-2...)
und springt dann in das entsprechende
Programm.

Ich habe dies alles Mal implementiert
und das ganze ist nicht trivial, es
ist aber machbar.

Weiter unten gebe ich diverse Hinweise,
wie verschiede anfallende Probleme
gelöst werden können. Wer alles
selbst lösen möchte, überliest die
entsprechenden Hinweise.

Wer das Multitasking im Alleingang
implementieren möchte soll das tun
(man gewinnt einiges an tieferer
Erkenntnis von CPUs, Maschinensprache
und Betriebssystemen, wenn man alle
anfallenden Probleme selbst lösen
muss). Aber sonst möchte ich
empfehlen, die Aufgabe in Gruppen
zu lösen und die Teilprobleme auf
einzelne Personen aufzuteilen und
diese laufend miteinander zu
integrieren. Dafür bietet sich
Github oder ähnlich an.

Die folgenden Probleme bieten sich
an teilautonom gelöst zu werden:

* CPU und Clock als Tasks. Kommunikation
  eines Interrupts von der Clock an die
  CPU. Die CPU erkennt den Interrupt und
  reagiert darauf am geeigneten Ort.

* https://github.com/tpo/kasm-generic/
  um eigene Assembler/Maschinensprache
  erweitern. Von Hand Maschinencode
  zu schreiben ist sehr aufwändig.
  Mit einem Assember erleichtert man
  sich die Aufgabe sehr.

* x86 CPUs speichern bei einem Interrupt
  [*nur* den PC/IP](https://wiki.osdev.org/Interrupt_Service_Routines#When_the_Handlers_are_Called)
  den Rest macht der Interrupt Handler:

  * das Speichern und Wiederherstellen
    des PCs auf Seiten CPU implementieren

  * das Spiechern und Wiederherstellen
    des Rests des CPU Zustandes auf Seiten
    Interrupt-Handler bzw. Scheduler
    implementieren.

* Stack Operationen implementieren,
  also PUSH und POP

* Zusätzliche CPU Befehle implementieren,
  welche die Aufgabe erleichtern. Im
  Moment hat meine CPU die folgenden
  Befehle:

  * `op_nop`        - don't do anything
  * `op_load`       - load ACC from address
  * `op_store`      - store ACC to address

    * unter Umständen erleichter man sich
      das Leben, wenn man op_load_value
      und op_store_value implementiert,
      welche den unmittelbaren gegebenen
      Wert ins Register/ACC laden, bzw.
      diesen im Speicher abspreichern

  * `op_jmp`        - jump to given address
  * `op_jsub`       - jump to subroutine

    * für diese Operation wird ein Stack
      verwendet! Siehe weiter unten

  * `op_sp_to_acc`  - copy SP to ACC

    * SP ist der Stack Pointer

  * `op_acc_to_sp`  - copy ACC to SP
  * `op_push`       - push given register to stack

    * momentan `op_push ACC`, `op_push PC`,
      `op_push EQ` und `op_push SP`,

  * `op_pop`        - pop register from stack

    * analog zu `op_push`

  * `op_ret`        - return from subroutine

    * Gegenstück zu `op_jsub`, pop't Adresse
      vom Stack

  * `op_eq`         - set EQ flag if ACC == value at given address

    * EQ ist ein Flag-Register

  * `op_jmp_eq`     - jump to given address if EQ is set
  * `op_set_int`    - copy ACC to interrupt handler pointer
  * `op_iret`       - copy ACC to interrupt handler pointer

    * pop't PC vom Stack

Ich werde nächstes Mal Studis
aufrufen, welche sich bei den
Aufgaben bisher noch nicht
gemeldet haben. Die Idee ist
zu zeigen, was man gemacht
hat und wie weit man gekommen
ist. Ich gehe davon aus, dass
man in der kommenden Woche
*ebenfalls* an dieser Aufgabe
arbeiten wird.

Diverse Hinweise:

* Bitte darauf achten, dass die CPU
  Register jeweils abgespeichert
  werden, bevor die CPU einen Kontext-
  Wechsel (also einen Wechsel vom
  Scheduler in ein Programm oder von
  einem Programm in den Scheduler)
  macht.

* Für die Umsetzung der CPU und des
  Timers kann der folgende Python
  Code als Vorlage genommen werden:

```
import time
import threading
 
def run_cpu():
    while True:
        print("hier würd ich read_and_execute_next_op() ausführen")
        # hier checken, ob interrupt anliegt etc.
 
def run_timer():
    while True:
        time.sleep(0.5)
        # hier CPU benachrichtigen, dass es einen
        # Interupt gabe
 
# Threads erstellen
cpu   = threading.Thread(target=run_cpu)
timer = threading.Thread(target=run_timer)
 
# Threads starten
cpu.start()
timer.start()
 
# Warten bis Threads beenden, was sie
# aber so nicht tun
t1.join()
t2.join()
```

* meine Implementation von `op_push`
  und `op_pop`:

```
  def op_push(self):
    self.sp = self.sp + 1

    if   self.operation_argument == ACC:
      value = self.acc
    elif self.operation_argument == PC:
      value = self.pc
    elif self.operation_argument == EQ:
      value = self.eq
    else:
      print("unknown operation_argument %d" % self.operation_argument)                                       
      self.halt()                                                                                       

    self.memory[self.sp] = value 
```

```
  def op_pop(self):
    stack_top = self.memory[self.sp]
    
    if   self.operation_argument == ACC:
      self.acc = stack_top
    elif self.operation_argument == PC:
      self.pc = stack_top
    elif self.operation_argument == EQ:
      self.eq = stack_top
    else:
      print("unknown operation_argument %d" % self.operation_argument)                                       
      self.halt()                                                                                       

    self.sp = self.sp - 1
```
* ich habe die Push und Pop Methoden
  erweitert, damit ich sie von innerhalb
  des CPU Codes selbst verwenden kann,
  da diverse Operationen `jsub`, `ret`,
  `iret` und der Interrupt Handler Aufruf
  ebenfalls den Stack verwenden:

```
  def op_pop(self, operation_argument = None):
    stack_top = self.memory[self.sp]
    
    if operation_argument == None:
      operation_argument = self.operation_argument
    
    if   operation_argument == ACC:
      self.acc = stack_top
    elif operation_argument == PC:
      self.pc = stack_top
    elif operation_argument == EQ:
      self.eq = stack_top
    else:
      print("unknown operation_argument %d" % operation_argument)                                       
      self.halt()                                                                                       

    self.sp = self.sp - 1
```

* analog für `op_push`


