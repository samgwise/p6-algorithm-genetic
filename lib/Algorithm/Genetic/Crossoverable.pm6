use v6;

unit role Algorithm::Genetic::Crossoverable;

method crossover(Algorithm::Genetic::Crossoverable $other, Rat $ratio) returns List {
  my $a = self.clone;
  my $b = $other.clone;

  for self.^attributes[0 .. floor(self.^attributes.end * $ratio)] -> $attr {
    $attr.set_value( $a, $attr.get_value($other) );
    $attr.set_value( $b, $attr.get_value(self) );
  }

  $a, $b;
}
