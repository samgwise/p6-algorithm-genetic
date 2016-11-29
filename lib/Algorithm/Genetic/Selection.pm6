use v6;

unit role Algorithm::Genetic::Selection;

#= The selection strategy for this algorithm
method selection-strategy(Int $selection = 2) { ... }

#= A method for accessing a population.
#= We expect that all elements of the returned list will impliment the score method as per Genotype.
method population() { ... }
