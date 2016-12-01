use v6;
use Algorithm::Genetic::Selection;

unit role Algorithm::Genetic does Algorithm::Genetic::Selection;
use Algorithm::Genetic::Genotype;

has Algorithm::Genetic::Genotype          @!population;
has Int                                   $!generation            = 0;
has Int:D                                 $.population-size       = 100;
has Rat:D                                 $.crossover-probability = 7/10;
has Rat:D                                 $.mutation-probability  = 1/100;
has Algorithm::Genetic::Genotype          $.genotype              is required;

method generation() returns Int { $!generation }
method population() returns Seq { @!population.values }

method evolve(Int :$generations = 1, Int :$size = 1) {
  self!init unless @!population.elems > 0;

  for 1..$generations -> $gen {
    self!sort-population;
    my $parrents = self.selection-strategy($size * 2);

    my @pairings;
    for $parrents.rotor(2) -> $parrent {
      @pairings.push: start {
        if (1..1000).pick <= $!crossover-probability * 1000 {
          my $children = $parrent[0].crossover($parrent[1], 1/2);
          $children>>.mutate($!mutation-probability);

          # Update population
          for $children.values -> $c {
            @!population.shift;
            @!population.push: $c;
          }
        }
        CATCH { warn $_ }
      }
    }
    await Promise.allof: @pairings;

    ++$!generation;
    last if self.is-finished;
  }
}

#= Lazy initilisation of our population, creates and scores Phenotypes.
method !init() {
  for 1..$!population-size {
    @!population.push: $!genotype.new-phenotype;
  }
}

#= Sort our population by score
method !sort-population() {
  @!population .= sort: {$^a.score <=> $^b.score }
}

#
# Required methods
#

#= The termination condition for this algorithm
method is-finished() returns Bool { ... }
