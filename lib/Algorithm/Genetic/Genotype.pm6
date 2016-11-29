use v6;

unit role Algorithm::Genetic::Genotype;

has Numeric $!score;

method score() returns Numeric {
  $!score = self!calc-score unless $!score.defined;
  $!score;
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
