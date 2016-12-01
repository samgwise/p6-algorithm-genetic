use v6;

unit role Algorithm::Genetic::Crossoverable;

method crossover(Algorithm::Genetic::Crossoverable $other, Rat $ratio) returns List {
  my $a = self.clone;
  my $b = $other.clone;

  for self.^attributes[0 .. floor(self.^attributes.end * $ratio)] -> $attr {
    given $attr.type {
      when Array {
        self!crossover-nested($attr.get_value(self), $attr.get_value($other), $ratio)
      }
      default {
        $attr.set_value( $a, $attr.get_value($other) );
        $attr.set_value( $b, $attr.get_value(self) );
      }
    }
  }

  $a, $b;
}

method !crossover-array(Array $a, Array $b, Rat $ratio) {
  for $a[0 .. floor($a.end * $ratio)].keys -> $i {
    $a[$i], $b[$i] = $b[$i], $a[$i]
  }
}
