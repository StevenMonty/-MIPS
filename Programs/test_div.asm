# Divide 120 by 5 then 4 then 3 then 2 then 1

      li    $r1, 120
      put   $r1

      li    $r3, 5
      div   $r1, $r3    # r1 /= 5
      put   $r1

      addi  $r3, -1
      div   $r1, $r3    # r1 /= 4
      put   $r1

      addi  $r3, -1
      div   $r1, $r3    # r1 /= 3
      put   $r1

      addi  $r3, -1
      div   $r1, $r3    # r1 /= 2
      put   $r1

      addi  $r3, -1
      div   $r1, $r3    # r1 /= 1
      put   $r1

      # Done.
      halt
