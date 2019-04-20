# Encodes an add $r2, $r3 instruction (0x14C0)

.text
main:
      # The 'add' instruction's opcode is 1
      li    $r1, 1

      # The 'add' instruction's subop is 0
      li    $r2, 0

      # Use the 2nd register for rs
      li    $r3, 2

      # Use the 3rd register for rt
      li    $r4, 3

      # Shift over opcode 12 bits
      li    $r5, 12
      sllv  $r1, $r5

      # Shift over subop nothing
      li    $r5, 0
      sllv  $r2, $r5

      # Shift over rs field 9 bits
      li    $r5, 9
      sllv  $r3, $r5

      # Shift over rt field 6 bits
      li    $r5, 6
      sllv  $r4, $r5

      # We need to OR these together
      # OR is NOT(NOR(a,b))
      # NOT is NOR(a,a)
      # therefore, OR r1, r2 is NOR(NOR(r1,r2), NOR(r1,r2))
      nor   $r1, $r2
      nor   $r1, $r1

      nor   $r1, $r3
      nor   $r1, $r1

      nor   $r1, $r4
      nor   $r1, $r1

      put   $r1

exit:

      halt

# By the way, the add $r2, $r3 looks like:
      add   $r2, $r3
