use v6;
use Algorithm::Genetic::Selection;

unit role Algorithm::Genetic::Selection::Roulette does Algorithm::Genetic::Selection;

method selection-strategy(Int $selection = 2) {
  given self.population.elems -> $size {
    when $selection < 1 {
      succeed ()
    }
    when $size < 1 {
      succeed ()
    }
    default {
      succeed gather for self.population.kv.map( -> $i, $p { $i => $p.score * $size } ).sort( *.value )[$size - ($selection min $size).. *] -> $e {
        take self.population[$e.key];
      }
    }
  }
}
