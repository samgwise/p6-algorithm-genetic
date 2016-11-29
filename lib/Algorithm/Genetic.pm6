use v6;
use Algorithm::Genetic::Selection;

unit role Algorithm::Genetic does Algorithm::Genetic::Selection;
use Algorithm::Genetic::Genotype;

has Algorithm::Genetic::Genotype          @!population;
has Int                                   $!generation            = 0;
has Int:D                                 $.population-size       = 100;
has Rat:D                                 $.crossover-probability = 0.95;
has Rat:D                                 $.mutation-probability  = 0.05;
has Algorithm::Genetic::Genotype          $.genotype              is required;

method generation() returns Int { $!generation }
method population() returns Seq { @!population.values }

method evolve(Int $generations = 1) {
  self!init unless @!population.defined;

  for 1..$generations -> $gen {
    self!sort-population;
    self!selection-strategy;

    ++$!generation;
    last if self!is-finished;
  }
}

#= Lazy initilisation of our population, creates and scores Phenotypes.
method !init() {
  for 1..$!population-size {
    @!population.push: $!genotype.new-random;
  }
}

#= Sort our population by score
method !sort-population() {
  @!population .= sort: *.score;
}

#
# Required methods
#

#= The termination condition for this algorithm
method !is-finished() returns Bool { ... }
