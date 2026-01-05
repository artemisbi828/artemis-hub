normalize objects and aliases. 
  remove comment lines and blocks
  ALL CAPS
  map, remove aliases

identify objects and aliases
  identify objects from and joins 
  identify and remove junk (not used)
  identify functions 
  from objects --> aliases, "as" separator
  add spaces around "()" -- consistent for REGEX
identify stages in sequence: repeat above
  ignore #tmp inserts

validation
normalize queries for nulls. {0, unknown}
persist RowId
identify keys
identify samples per stage; tmp-tables
  row count 
  sum of certain columns
  thresholds