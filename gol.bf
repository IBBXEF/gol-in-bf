>> >> >> >> >> we leave room for global variables

our list layout modulo 7 :
    0: 1 if end of row (included at the end) 0 else
    1: 1 if end or start of rows list (included at the end) 0 else
    2: actual data (is_alive)
    3: actual data (is_flagged)
    4: actual data (neighbour count)
    5: temp data
    6: temp data

+>+>>>>>> start of data marker

read input : 0 1 and /n are the expected symbols
>> move to data slot (offset 2)
-,
[->+>+<<] copy to 2 temp
>>[-<<+>>]<< copy back 2nd to base
>>+<< >[>[-]<[-]]< setup flag if zero
>>[<<[-]->>[-]]<< set to 255 if flag is set
+ read input

[-

    [- >+ >+ <<] copy input to the 2 next slots while removing it
    >> [- << + >>] << move the second slot back into the base one

    > move to second to test
    ---------- 10 i e  \n

    >+< set newline flag to other slot to true
    [ if char is not newline
        >-< clear flag
        [-] erase current cell to stop loop
    ]
    > [<<<< + >>>> [-]] < moving flag to end_line
    < moving back to first data slot with input char

    ---------------------------------------------------------------------------------------- 88 aka X
    >+< set flag
    [ input char is not X
        >-< clear flag
        [-] clear data
    ]
    >[-<+>]< setting data to 1 if input is indeed an X (offset 2)

    >>>>> moving to next slot
    >> moving to next data slot (offset 2)

    -,
    [->+>+<<] copy to 2 temp
    >>[-<<+>>]<< copy back 2nd to base
    >>+<< >[>[-]<[-]]< setup flag if zero
    >>[<<[-]->>[-]]<< set to 255 if flag is set
    + read input

]
>>>>> moving to next grid point (offset 0)
+>+< setting end marker
<<<<<<< moving to previous slot

>-[+<<<<<<< -] +< going back to the start of the grid

main loop

<<[-]+>> setting does print at each iteration (remove/add (plus) to disable/enable)
<<<<<[-]+->>>>> setting has_infinite_grid_left
<<<<<<[-]+>>>>>> setting has_infinite_grid_right
<[-]-> setting iteration_count (255) (we assume underflow)
<[>

    printing the grid
    <<[[-]<[-]+<[-]+>>] <<[[-]>>[-]+<<]>
    [ [-]>>>
        >>>>>>>
        >-[+> go to data slot (offset 2)
            [[-]>>>[-]+>[-]+<<<<] >>>>[[-]<<<<[-]+>>>>] < copying data to temp 1
            > [-]++++++++++++++++++++++++++++++++ < putting a space to temp2
            [if cell alive
                [-]
                >++++++++++++++++++++++++++++++++++++++++++++++++++++++++< turn space into X
            ]
            >.[-] print
            <<<<<< go back to newline flag (offset 0)
            [[-]>>>>>[-]+>[-]+<<<<<<] copy it to the 2 temp slots
            >>>>>>[[-]<<<<<<+>>>>>>] move 2nd back into original
            < go to 1st temp slot (offset 5)
            [[-]++++++++++.[-]] print \n if nonzero
            >>> - go to next end of data flag and test (offset 1)
        ]+<


        <<<<<<< moving to previous slot
        >-[+<<<<<<< -]
            ++++++++++..[-] newline
        +< going back to the start of the grid
    <<<
    ]>>>

    counting neighbours:

    propagating neighbours in the grid:

    >>>>>>>

    -[+ for each one in the first line

        currently point to newline flag (offset 0)

        <<<<<<<
        >-[+<<<<<<< -] +< going back to the start of the grid
        >>>>>>> move to first cell

        flag the first unflagged cell of each line
        >-[+for each cell

            currently point to end of data flag (offset 1) (in first cell in first iteration)

            >> move to data 2 (offset 3)
            
            [ move to first non flagged
                >>>>> move to next eod (offset 1)
                [[-]>>>>[-]+>[-]+<<<<<] copy to 2 temp
                >>>>>[[-]<<<<<[-]+>>>>>]<<<<< move back
                >>>> [ if eod (offset 5)
                    [-]<<[-]>> reset flag
                ]
                << test flag (offset 3)
            ]
            [-]+ flag it

            <<<-[+>>>>>>>-]+ move until end of line (offset 0)
            >[<<<<<<<]< move back if end of data
            >>>>>>> move to start of line

            >- test if eod
        ] +<
        
        <<<<<<< moving to previous slot
        >-[+<<<<<<< -] +< going back to the start of the grid
        >>>>>>> moving to first cell

        propagate neighbourhood
        >-[+for each cell (offset 1)
            >> for all flagged cells (offset 3)
            [ move to first non flagged
                >>>>> move to next eod (offset 1)
                [[-]>>>>[-]+>[-]+<<<<<] copy to 2 temp
                >>>>>[[-]<<<<<[-]+>>>>>]<<<<< move back
                >>>> [ if eod (offset 5)
                    [-]<<[-]>> reset flag
                ]
                << test flag (offset 3)
            ]

            < go to data slot (offset 2)
            [[-]>>>[-]+>[-]+<<<<] copy to 2 temp places
            >>>>[[-]<<<<[-]+>>>>]<<<< move back 2nd
            >>>[[-] cell is alive (offset 5)
                < <<<<<<< + move to previous slot and add a neighbour (offset 4)
                >>>>>>> >>>>>>> + mark next one
                <<<<<<< move back
                <<<< (offset 0)
                -[+<<<<<<<-] + move to previous end_of_line
                
                >>> -[+<<<<<<<-]+# find first flagged (offset 3)
                >>>>>>> move to first unflagged one

                > + add a neighbour
                <<<<<<< + move to previous slot and add a neighbour
                >>>>>>> >>>>>>> + mark next one
                <<<<<<< move back
                < move back to flag
                <<< -[+>>>>>>>-]+ >>>>>>> move to next start_of_line (offset 0)

                ADDED START

                flagging the row under
                -[+>>>>>>>-]+ >>>>>>> move to next start_of_line (offset 0)

                >>> [ move to first non flagged
                    >>>>> move to next eod (offset 1)
                    [[-]>>>>[-]+>[-]+<<<<<] copy to 2 temp
                    >>>>>[[-]<<<<<[-]+>>>>>]<<<<< move back
                    >>>> [ if eod (offset 5)
                        [-]<<[-]>> reset flag
                    ]
                    << test flag (offset 3)
                ] > (offset 4)
                + <<<<<<< + >>>>>>> >>>>>>> + <<<<<<< add neighbour to the three cells

                <<<< -[+<<<<<<<-]+ <<<<<<< move to previous start_of_line (offset 0)

                -[+<<<<<<<-]+ >>>>>>> move to previous start_of_line (offset 0)

                ADDED END

                >>> [ move to first non flagged
                    >>>>> move to next eod (offset 1)
                    [[-]>>>>[-]+>[-]+<<<<<] copy to 2 temp
                    >>>>>[[-]<<<<<[-]+>>>>>]<<<<< move back
                    >>>> [ if eod (offset 5)
                        [-]<<[-]>> reset flag
                    ]
                    << test flag (offset 3)
                ] >> (offset 5)

            ] < (offset 4)

            <<<<-[+>>>>>>>-]+ move until end of line (offset 0)

            >[<<<<<<<]< if end of data move back one cell

            >>>>>>> >- move to next cell and test
        ]+< (offset 0 at eod)

        <<<<<<< moving to previous slot
        >-[+<<<<<<< -] +< going back to the start of the grid
        >>>>>>> moving to first cell

        >>> move to flag (offset 3)

        [ move to first non flagged

            >>>>> move to next eod (offset 1)
            [[-]>>>>[-]+>[-]+<<<<<] copy to 2 temp
            >>>>>[[-]<<<<<[-]+>>>>>]<<<<< move back
            >>>> [ if eod (offset 5)
                [-]<<[-]>> reset flag
            ]
            << test flag (offset 3)
        ]
        <<<- test if newline (offset 0)
    ]+

    <<<<<<< moving to previous slot
    >-[+<<<<<<< -] +< going back to the start of the grid

    >>>>>>> moving to first cell
    >-[+ for each cell (offset 1)
        >> [-] << clear flag

        >>> move to neighbour count (offset 4)
        --[ has not 2 neighbours
            <<[-]+>> set is_alive to 1
            -[ has not 3 neighbours
                [-]
                <<[-]>> set is_alive to 0
            ]
        ]

        <<< move back to offset 1
        >>>>>>>
    -]+<

    <<<<<<< moving to previous slot
    >-[+<<<<<<< -] +< going back to the start of the grid

    expanding the grid by one on the right
    <<<<< [[-]>[-]+>[-]+<<] >>[[-]<<[-]+>>] < check if extend
    [[-] does extend grid
        >>>>

        extend before the line
        >>>>>>> move to first cell
        >-[+< for all lines
            
            >>>>>>> moving to first cell of the line
            >[-]+< mark it as end of data

            >>>>>>> >-[+>>>>>>>-]+< move to end of data
            [-]>[-]< clear end of data flag (and newline)
            >>>>>>> +>+>>>>>> <<<<<<< setup a new end_of_data
            <<<<<<< move to last data
            >-[+
                <[[-]>>>>>>>[-]+<<<<<<<] copy newline
                >>[[-]>>>>>>>[-]+<<<<<<<] copy is_alive
                < move back to end_of_data (offset 1)
                <<<<<<< move to previous cell
            -]+< copy back until end_of_data found

            >[-]< clear the end_of_data flag
            >>[[-]>>>>>>>[-]+<<<<<<<]<< copy is_alive (the current cell cannot be a newline)

            -[+ >>>>>>> -]+ move until next line
            >-
        ]+<

        <<<<<<< move to previous slot
        >-[+<<<<<<< -] +< going back to the start of the grid

        <<<<
    ]
    >>>>

    expanding the grid by one on the left
    <<<<<< [[-]>>[-]+>[-]+<<<] >>>[[-]<<<[-]+>>>] < check if extend
    [[-] does extend grid
        >>>>
        extend before the line
        >>>>>>> move to first cell
        -[+>>>>>>>-]+ >>>>>>> move to first of second line
        >-[+< for all lines
            
            >>>>>>> moving to first cell of the line
            >[-]+< mark it as end of data

            >>>>>>> >-[+>>>>>>>-]+< move to end of data
            [-]>[-]< clear end of data flag (and newline)
            >>>>>>> +>+>>>>>> <<<<<<< setup a new end_of_data
            <<<<<<< move to last data
            >-[+
                <[[-]>>>>>>>[-]+<<<<<<<] copy newline
                >>[[-]>>>>>>>[-]+<<<<<<<] copy is_alive
                < move back to end_of_data (offset 1)
                <<<<<<< move to previous cell
            -]+< copy back until end_of_data found

            >[-]< clear the end_of_data flag
            >>[[-]>>>>>>>[-]+<<<<<<<]<< copy is_alive (the current cell cannot be a newline)

            -[+ >>>>>>> -]+ move until next line
            >-
        ]+<
        <<<<<<< move to previous slot
        >-[+<<<<<<< -] +< going back to the start of the grid

        shift line starts
        >>>>>>> move to first cell
        >-[+< for all cells
            -[+>>>>>>>-]+ move to next end_of_line
            >[[-]>>>>[-]+>[-]+<<<<<] >>>>>[[-]<<<<<[-]+>>>>>]<<<<< copy to temp1
            >>>>-
            [[-]<<<<< if not eod
                [-]>>>>>>>[-]+ shift end_line
                >>>>>>> move to next
            >>>>>]<<<<<
        >-]+<

        [-]>[-]>>>>>> [-]+>[-]+< move end_of_data one cell

        <<<<<<< move to previous slot
        >-[+<<<<<<< -] +< going back to the start of the grid

        <<<<
    ]
    >>>>


    <-
]>
printing the grid
>>>>>>>
>-[+> go to data slot (offset 2)
    [[-]>>>[-]+>[-]+<<<<] >>>>[[-]<<<<[-]+>>>>] < copying data to temp 1
    > [-]++++++++++++++++++++++++++++++++ < putting a space to temp2
    [if cell alive
        [-]
        >++++++++++++++++++++++++++++++++++++++++++++++++++++++++< turn space into X
    ]
    >.[-] print
    <<<<<< go back to newline flag (offset 0)
    [[-]>>>>>[-]+>[-]+<<<<<<] copy it to the 2 temp slots
    >>>>>>[[-]<<<<<<+>>>>>>] move 2nd back into original
    < go to 1st temp slot (offset 5)
    [[-]++++++++++.[-]] print \n if nonzero
    >>> - go to next end of data flag and test (offset 1)
]+<


<<<<<<< moving to previous slot
>-[+<<<<<<< -]
    ++++++++++..[-] newline
+< going back to the start of the grid
