#!/usr/bin/perl

=pod

  **************************************************************************
  Analyze a minified Enyo app
  Output a sorted list of modules by size in the format "module: length"
  **************************************************************************

  Copyright 2013 OnCron Engineering, Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

=cut

use strict;

undef $/;
my $_ = <>;
my $n = 0;
my @modules;

# Split looking for "// " which starts each file section
for my $match (split(/(?=\/\/ )/)) {
  # Uncomment to split the input into individual files
  #open(O, '>split' . ++$n);
  #print O $match;
  #close(O);

  # Look for the line break to separate the code
  my ($moduleName, $code) = split /\n+/, $match, 2;

  # Strip comment
  $moduleName =~ s/\/\/ //;
  push(@modules, {moduleName => $moduleName, moduleLength => length($code)});
}

# Sort and output the modules
for my $module ( sort { $b->{moduleLength} <=> $a->{moduleLength} } @modules ) {
  print "$module->{moduleName}: $module->{moduleLength}\n";
}

