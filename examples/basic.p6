#! /usr/bin/env perl6
use v6;
use Algorithm::Genetic;
use Algorithm::Genetic::Genotype;
use Algorithm::Genetic::Selection::Roulette;

class SayHello does Algorithm::Genetic does Algorithm::Genetic::Selection::Roulette {
  method is-finished() returns Bool {
    #say "Gen{ self.generation } - pop. size: { @!population.elems }";
    self.population.tail[0].result eq 42;
  }
}

class Phrase does Algorithm::Genetic::Genotype {
  our $target = 42;
  # our @options = (|('A'..'Z'), |('a'..'z'));
  our @options = (1, 9);

  has Int $!a is mutable( -> $v { (-1, 1).pick + $v } ) = @options.pick;
  has Int $!b is mutable( -> $v { (-1, 1).pick + $v } ) = @options.pick;


  method result() { $!a * $!b }

  method !calc-score() returns Numeric {
    $target - abs self.result() - $target
  }
}


my SayHello $ga .= new(
  :genotype(Phrase.new)
  :mutation-probability(4/5)
);

$ga.evolve(:generations(1000), :size(16));

say "stoped at generation { $ga.generation } with result: { .a } x { .b } { .result } and a score of { .score }" given $ga.population.tail[0];
