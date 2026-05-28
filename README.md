## gol-in-bf
The goal of this project is to create a simulator of Conway's game of life (later shortened as gol) in the esoteric programming language brainfuck.
One specificity of gol is that is is Turing-complete, horever this is only true if the grid size is truly infinite (or, more realistically, the grid grows as needed).
So, unlike other projects doing a similar thing, the grid size in this project grows by one at each iteration, ensuring a true border-less model of Conway's gol.
Sadly, I have for now only implemeted the expansion on the left and right side of the grid, but I'm satisfied with it.

## How to install and run:
Simply download the project and a brainfuck interpretor/compiler of you choice (there is a lot online, like this one https://github.com/susam/bfc).
Then, run the program with as input a text representing the state of the grid like in the example files.
Due to technical limitation, it is advised to have at least 2 rows/lines of empty cells separating any alive cell to the sides of the grid.
The project will run a fixed number of iterations of gol and then print the current state of the board.
It is possible to modify in whitch directions the grid extends, the number of iterations and if the programs prints each individual iteration at line 66-69 of the main file.
