# Multiply 1*2*3*4*5

      li    $r1, 1
      put   $r1

      li    $r3, 2
      mul   $r1, $r3    # r1 *= 2
      put   $r1

      addi  $r3, 1
      mul   $r1, $r3    # r1 *= 3
      put   $r1

      addi  $r3, 1
      mul   $r1, $r3    # r1 *= 4
      put   $r1

      addi  $r3, 1
      mul   $r1, $r3    # r1 *= 5
      put   $r1

      # Done.
      halt
