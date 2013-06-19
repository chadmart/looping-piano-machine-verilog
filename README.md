looping-piano-machine-verilog
=============================

EE 201 final project
Abstract

The Looping Piano Machine is a continuous sound player which loops through 4, 8 or 16 bits melody. The project consists of 4 main parts:
•  the core machine which iterates through states and sends the appropriate address to note frequency generator
•	the note frequency generator, which sends the desired note frequency to the speaker
•	the VGA output, which visually shows the grid of bits and the currently played bits
•	the top design, which connects the parts above.

This design could be used to:
•	create the melody for the greeting cards
•	be integrated into toys as music
					
Introduction and background
The Looping Piano Machine project became possible to implement after learning series of very important concepts, such as debouncer, state machine, one-hot method, clock divider and etc.’.
Piano Machine successfully utilizes all of these useful concepts stated above in addition to speaker and VGA output.
					
Design

User Interface

Inputs
Piano machine utilizes significant number of inputs in order to set up the bit  melody, tempo and length of the music cycle.

The challenging part is to provide the user with convenient way to enable or disable any of the 80 bits, where during every iteration 5 bits are scanned. In order to provide to the user an efficient set up process, the Piano machine has got the following features:
•	Button Left  resets the Piano Machine
•	Button Up restores the default tempo
•	Button Right starts the looping
•	Button Down stops the iteration
•	Button Center toggles the pitch range of the notes 
o	toggles between upper and lower 32 bits of ROM
•	External Button 1  speeds up the  tempo
•	External Button 0  slows down the  tempo
 
•	Switches 3-7 are used to select any bit (out of 5 bits available) at any particular state of the Piano Machine.
•	Switch 2 pauses the loop
•	Switch 1 enables 4  bit cycle music
•	Switch 0 enables 8 bit cycle music, as long as Switch 1 is not selected
•	If switches 1 and 0 are not selected, then 16 bit cycle music is played by default.

The user has to press the buttons in the following order:
•	Program FPGA
•	Press START and ensure that the Piano Machine begins looping through inactive bits.
•	Pause the iteration by SWITCH 2
•	Enable any 5 bits at the state where Piano Machine paused
•	Release PAUSE SWITCH and ensure the Machine moves to another state
•	Pause Machine again as needed
•	The Piano Machine ought to play the sound according to the selected bits

Outputs:

VGA
The VGA output is shown as a colorful grid (16X5), where each element of the grid is a square of 4 possible colors:
•	green: the bit is not activated and not selected
•	red: the bit is activated and selected
•	yellow: the bit is not activated and selected
•	blue: the bit is activated and not selected

 
When the user starts the Piano Machine, the default speed is 6 Hz. However, by pressing either the BUTTON 0 or BUTTON 1 the frequency could be in the range from 1.5 Hz to 12 Hz.

Sound:
The Piano Machine at each iteration plays the activated bits in the selected column of the grid. Each column has 5 bits which provide the variety of choices for the desired sound. There 2^5 choices of the bit sound at each column.
The sound generator receives 50 MHz clock and converts it into 50 KHz clock. It counts the pulses of the 50 KHz clock until JK Flip Flop toggles to produce right frequency note in the hearing range 15-18,000 HZ.
When the user presses the BUTTON CENTER, it toggles the sound module, which either selects the upper bound or lower bound of different 32 bit sounds.

 
LED’s and SSD’s
The Piano Machine uses LED’s for showing which switch has been used. When SWITCH2 is up the LED above this switch will light up and indicate that the Piano Machine is paused. Similarly, if the Machine is running, the LED’s above bit selectors (SWITCHES 3-7) will be continuously on. In addition, if user selects only 4 or 8 bit cycle length, then the LED’s above Switch 0 or 1 will turn on respectively.

The SSD’s are displaying the current data address from the Note64X16ROM (This ROM is used by note frequency generator). However, when the Machine is in Idle state, then the SSD’s just show 0’s.

Block-Level description

The Piano Machine design utilizes in the file drum_machine_SM.v with finite state machine, to transition between states. The transition begins once the user presses START button. Every SYSTEM CLOCK the state machine transitions to a new state which causes the Piano Machine to select the new group of bits.

In the same file the designer uses a 5-bit wide 16-to-1 mux to select the playing bits at current state, where there are 80 bits in total and only combination of 5 bits is played at any system clock cycle.

Please refer to the Appendix 2 for the State Machine

In VGA-demo.v file the FPGA board displays on the screen the grid of size 16X5 squares at the frequency of 100MHz. The challenging part is to display all 80 squares (bits) in 4 possible colors. The developer used 320 conditions (4 for each square), which let FPGA board to scan the entire screen and based on the region, to draw the square in the correct color.

The Drum_Machine_Top.v is where the core components are connected and synchronized with appropriate clock frequencies. The clock division concept is used to divide the board clock into different system clocks.
In addition the certain buttons are debounced in order to create single and clean pulse, when the user presses the button. One of the few debounced buttons is: External Buttons 0 and 1, Button Up and Button Center.

Since some of the buttons control the speed of the iteration, the designer integrated the debouncer, because it is crucial to increase or decrease the tempo only by 1 unit, every time the button is being pressed. The debouncer algorithm is utilized from the ee201 lab session.

Finally, the HEX-to-SSD converter is used to enable correct cathodes for SSD’s. SSD’s represent current data address from the Note64X16ROM. 

State machine

The state machine is Mealy type of one hot method. It consists of 17 states with asynchronous RESET. The Piano Machine remains in Initial state until the user presses START button. After that the Piano Machine iterates through 16 consecutive states, from PLAY0 to PLAY 15 respectively. However, if at any time RESET is pressed, the Piano Machine will go to Initial State.
The state machine uses 5 arrays of 16 bit each. When the user customizes the melody, each element of the array can be active or inactive. The states PLAY0 to PLAY15 select associate element in each array and if the element is active, then the Piano Machine will play matched sound to the active bits combination. If the RESET is pressed, then all the user input will be reset once the state machine transitions to the initial state.

Testing

The test bench has been written for the state machine in order to test whenever the Machine transitions through all the states from PLAY0 to PLAY15. The developer didn’t test exhaustively for all possible data combination, because the desire was to connect to VGA module. Once the VGA was successfully connected, the state machine went through complete testing. During the experiments couple bugs were found and resolved.

Issues 

Issues with debouncer
The initial design had START and STOP feature associated with BUTTON LEFT. Since clean pulse was required, .the programmer used debouncer. However, once the VGA module was successfully initiated in the top design, the BUTTON LEFT didn’t have the desired functionality. The solution to the problem was separation START and STOP features. The user interface was modified with making BUTTON DOWN as STOP and BUTTON RIGHT as Start. As a result, the debouncer became redundant and was removed.

1) Issues with Speaker
Incorrect frequency, the frequency produced by the note frequency generator was not within the hearable range. The note frequency generator was expecting a 50 KHz clock and was receiving a 50 MHz clock. Converting the clock  to 50 KHz fixed this issue.

2) Loops once and becomes silent
The counter counting the number of 50 KHz pulses before toggling the JK-FF, which controlling the note frequency, was not cleared in between states. This caused an inconsistent behavior of the note frequency. Clearing the counter while the clock, used in the state machine, is high fixed this issue.

3) Issues with VGA
When Piano Machine ran the first time, the simulation revealed couple disabled bits in the lower part of the grid. After careful inspection, the programmer found mistype in the input selector. The quick correction fixed the bug. 

Conclusion

Throughout the semester, the complexity of the labs built up on top of each other in a sensible manner. This enabled us to easily learn how to code in Verilog and to be able to complete the complicated final project. The final project was the perfect way to utilize all the concepts, which we have learned during this semester in the labs.

Suggestions for enhancements:
•	As part of the enhancement the EE201 students can scale up this design and utilize more buttons and switches, so the final user can get more bit sound selection.
•	The students can increase the length of the melody, so the iteration won’t be limited by 16 bits. It is possible to implement by dividing the melody into 16 bit chunks and let the Piano Machine display one chunk at a time.
•	Students can use field I/O to enable the Piano Machine to read from file. Reading from file would greatly simplify the bit selection; as well as, allow the user to play an entire song.
•	Since nearly half of the screen remains unused throughout the design, the students ought to use this space to display special Easter Eggs when certain combinations of notes are being played. (i.e. when the USC fight song is played, then USC could be written in red and yellow in the unused space)
•	During EE201 students are working on different projects. However, the students have never integrated 2 designs into one. Future students should try to integrate different projects with Piano Machine. For example, alarm clock design could utilize the Piano Machine for custom made alarm sounds.



