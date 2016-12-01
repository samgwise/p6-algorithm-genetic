use v6;
use Algorithm::Genetic::Crossoverable;

unit role Algorithm::Genetic::Genotype does Algorithm::Genetic::Crossoverable;

my @mutators;
has Numeric $!score;

method score() returns Numeric {
  $!score = self!calc-score unless $!score.defined;
  $!score;
}

multi sub trait_mod:<is> (Attribute $attr, :$mutable!) is export {
  die "Mutable trait requires a Callable arguement, recieved: '{ $mutable.WHAT.perl }'." unless $mutable ~~ Callable;
  @mutators.push: sub mutate-attribute($self) { $attr.set_value: $self, $mutable( $attr.get_value($self) ) }
}

method mutate(Rat $probability) {
  for @mutators -> $m {
    next unless (1...1000).pick <= $probability * 1000;
    $m(self);
  }
}

#
# Required methods
#

method !calc-score() returns Numeric { ... }

#
# Default methods
#

method new-phenotype() returns Algorithm::Genetic::Genotype {
  self.new
}
