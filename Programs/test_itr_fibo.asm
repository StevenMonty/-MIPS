# Calculate 5th fibonacci number (Output: 8)

      # Loop counter
      li    $r1, 5

      # Last known fibonacci numbers
      li    $r2, 0
      li    $r3, 1

loop:

      # Calculate the next fibonacci number
      li    $r4, 0
      add   $r4, $r2
      add   $r4, $r3

      # Output the instructor
      put   $r4

      # Update 'last two' outputs
      li    $r2, 0
      add   $r2, $r3
      li    $r3, 0
      add   $r3, $r4

      # Loop!
      addi  $r1, -1
      bp    $r1, loop

exit:
      # Done.
      halt
