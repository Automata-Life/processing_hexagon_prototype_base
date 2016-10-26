#### Processing Hexagon Prototype Base

This repository contains a prototype base to test game mechanics using
processing.

##### Dependencies

- processing 3.2.1

##### Installing

    git clone https://github.com/Automata-Life/processing_hexagon_prototype_base.git
    cd processing_hexagon_prototype_base

    wget http://download.processing.org/processing-3.2.1-linux64.tgz
    tar xvf processing-3.2.1-linux64.tgz

##### Running

    ./processing-3.2.1/processing

Inside the IDE, click `File > Open` and select the project file
`processing_hexagon_prototype_base.pde`. Finally, click `Sketch > Run` and
follow the on-screen instructions.

##### Playing

Each game turn starts with the **red** player, then moves to the **green**
player, then simulates the **Game of Life** for a set amount of turns.

Each player spawns **cells** of their **color** during their turn.  Click in a
**gray** hexagon to spawn a **cell** of your color.  You can only spawn a set
amount of **cells**, so plan accordingly.

You can **kill** a **cell** that you own, gaining more **cells** to spawn. To
do that, press **A** to change the **brush** color to **gray**, then click the
**cells** you want to **kill**. Press **A** to change the **brush** back to
your **color**.

The game **ends** after a set amount of **turns**, or after
all the **cells** owned by a player **die**, or if a
player reaches a certain **score**, or if a player
dominates a certain portion of the **map**.
