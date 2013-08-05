-------------------------------------------------------------------------
--
-- eio_time.as
--
-------------------------------------------------------------------------
--
-- Copyright (C) 2005  Research Institute for Symbolic Computation, 
-- J. Kepler University, Linz, Austria
--
-- Written by Christian Aistleitner
-- 
-- This program is free software; you can redistribute it and/or          
-- modify it under the terms of the GNU General Public License version 2, 
-- as published by the Free Software Foundation.                          
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
-- MA  02110-1301, USA.
--

#include "aldor"

+++\begin{addescription}{allows to time a process.}
+++These timings can be used to determine the time the system spends in the current process.
+++
+++The timings are represented by five values. These values are
+++\begin{itemize}
+++\item \adcode{real},
+++\item \adcode{utime},
+++\item \adcode{stime},
+++\item \adcode{cutime}, and
+++\item \adcode{cstime}.
+++\end{itemize}
+++
+++ Each of these values is measured in ticks. \adname{ticksPerSecond} denotes, how many ticks fit in one second.
+++
+++\adcode{real} denotes the real time since a fixed point of time in the past. This point of time does not vary between invokations of \adthistype in this process. \adcode{utime} holds the time the processor executes intructions of the calling process. \adcode|stime| refers to the time spent executing instructions by the system on behalf of the calling process. \adcode{cutime} and \adcode{cstime} denote the sum of \adcode{utime} and \adcode{stime} for all terminated child processes.
+++\end{addescription}
+++\begin{adseealso}
+++  \adtype{Timer} of \LibAldor, 
+++  \cite{POSIX}
+++\end{adseealso}
Times: with {
    export from 'real,utime,stime,cutime,cstime';
    
    AdditiveType;
    OutputType;
    CopyableType;

    +++\begin{addescription}{denotes how many ticks fit in one second.}
    +++\end{addescription}
    ticksPerSecond:MachineInteger;

    +++\begin{addescription}{obtains the current timings for the current process.}
    +++\end{addescription}
    times:() -> Partial %;

    +++\begin{addescription}{allows to set fields of a time structure.}
    +++\end{addescription}
    set!: ( %, 'real,utime,stime,cutime,cstime', MachineInteger ) -> MachineInteger;

    +++\begin{addescription}{allows to get fields of a time structure.}
    +++\end{addescription}
    apply: ( %, 'real,utime,stime,cutime,cstime' ) -> MachineInteger;
    
} == add {

    -----------------------------------------

    local TMS == Record( 
      utime : MachineInteger,
      stime : MachineInteger,
      cutime: MachineInteger,
      cstime: MachineInteger
    );

    -----------------------------------------

    local Rep == Record( 
      real      : MachineInteger,
      utime : MachineInteger,
      stime : MachineInteger,
      cutime: MachineInteger,
      cstime: MachineInteger
    );
    
    -----------------------------------------

    import from MachineInteger;
    import from TMS;
    import from Rep;
    import from Partial %;

    -----------------------------------------
 
    import {
	sysconf: MachineInteger -> MachineInteger;
	__SC__CLK__TCK: MachineInteger;
    } from Foreign C "unistd.h";
    import {
	times: TMS -> MachineInteger;
    } from Foreign C "sys/times.h";

    -----------------------------------------
    
    ticksPerSecond:MachineInteger == { sysconf __SC__CLK__TCK }

    -----------------------------------------

    times(): Partial % == {
	local t: TMS := record( 0, 0, 0, 0 );
	local real: MachineInteger := times( t );
	real = -1 => failed;
	[ per record( real, t.utime, t.stime, t.cutime, t.cstime ) ];
    }
    
    -----------------------------------------

    (=)( a: %, b: % ): Boolean == {
	local repA: Rep := rep a;
	local repB: Rep := rep b;
	(repA.real=repB.real) and (repA.utime=repB.utime) and (repA.stime=repB.stime) and (repA.cutime=repB.cutime) and (repA.cstime=repB.cstime);
    }
    
    -----------------------------------------

    (+)( a: %, b: % ): % == {
	local repA: Rep := rep a;
	local repB: Rep := rep b;
	per record( repA.real+repB.real, repA.utime+repB.utime, repA.stime+repB.stime, repA.cutime+repB.cutime, repA.cstime+repB.cstime );
    }
    
    -----------------------------------------

    (-)( a: % ): % == {
	local repA: Rep := rep a;
	per record( -repA.real, -repA.utime, -repA.stime, -repA.cutime, -repA.cstime );
    }
    
    -----------------------------------------

    0: % == per record( 0,0,0,0,0 );
    
    -----------------------------------------

    (<<)(out: TextWriter, a: %):TextWriter == {
	import from String;
	import from SingleFloat;
	local repA: Rep := rep a;	
	out << "(real: " << (repA.real) 
	    << ", user: " << (repA.utime) 
	    << ", system " << (repA.stime)
	    << ", user dead children: " << (repA.cutime)
	    << ", system dead children: " << (repA.cstime)
	    << ")";
    }
        
    -----------------------------------------

    apply( a: %, field: 'real,utime,stime,cutime,cstime' ): MachineInteger == {
	field = real => (rep a) . real;
	field = utime => (rep a) . utime;
	field = stime => (rep a) . stime;
	field = cutime => (rep a) . cutime;
	assert( field = cstime );
	(rep a) . cstime;
    }

    -----------------------------------------

    set!( a: %, field: 'real,utime,stime,cutime,cstime', value: MachineInteger ): MachineInteger == {
	field = real => (rep a) . real := value;
	field = utime => (rep a) . utime := value;
	field = stime => (rep a) . stime := value;
	field = cutime => (rep a) . cutime := value;
	assert( field = cstime );
	(rep a) . cstime := value;
    }

    -----------------------------------------

    copy( a: % ): % ==
    {
	local repA := rep a;
	per record( 
	  repA . real,
	  repA . utime,
	  repA . stime,
	  repA . cutime,
	  repA . cstime
	);
    }

    -----------------------------------------

}
