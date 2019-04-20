# Calculate 5th fibonacci number

# r6: stack pointer  (sp)
# r7: return address (ra)

.data
      stack: 0

.text
main:
      # Initialize Stack Pointer
      la    $r6, stack

      # Function argument
      li    $r1, 5

      # Call function
      jal   $r7, fibo

      # Print output
      put   $r1

exit:
      # Done.
      halt

# Arguments:
#   x: $r1 - index of fibonacci number (starts at 1)
# Output number in $r1, uses memory as stack
fibo:
      # if argument is 0, 1, or 2: output 1
      li    $r2, 2
      sub   $r2, $r1
      bn    $r2, fibo_recurse

      li    $r1, 1
      j     fibo_exit

fibo_recurse:
      # Push r1
      sw    $r1, $r6
      addi  $r6, 1

      # Push r7
      sw    $r7, $r6
      addi  $r6, 1

      # Recurse to find fibo(x - 1)
      addi  $r1, -1
      # Print temp output
      put   $r1
      jal   $r7, fibo

      # Push the current return value
      sw    $r1, $r6
      addi  $r6, 1

      # Pop original r1
      addi  $r6, -3
      lw    $r1, $r6
      addi  $r6, 3

      # Recurse to find fibo(x - 2)
      addi  $r1, -2
      jal   $r7, fibo

      # Pop last return value (fibo(x))
      addi  $r6, -1
      lw    $r2, $r6

      # Add together
      add   $r1, $r2

      # Pop r7
      addi  $r6, -1
      lw    $r7, $r6

      # Pop old r1
      addi  $r6, -1

fibo_exit:

      jr    $r7
