use v6;

unit role Algorithm::Genetic::Genotype;

has Rat $!score;

method score() returns Rat {
  $!score = self!calc-score unless $!score.defined;
  $!score;
}

#
# Required methods
#

method !calc-score() returns Rat { ... }

#
# Default methods
#

method new-phenotype() returns Algorithm::Genetic::Genotype {
  self.new
}
