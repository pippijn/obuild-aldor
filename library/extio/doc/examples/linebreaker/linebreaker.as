#include "extio"

import from MachineInteger;
import from TextWriter;
import from Character;
import from String;
import from StreamFormatter;

lineBreaker( stdout, 12 ) 
  << "This command breaks lines after 12 columns." 
  << newline << newline 
  <<  "Of course, added newlines are respected.";
