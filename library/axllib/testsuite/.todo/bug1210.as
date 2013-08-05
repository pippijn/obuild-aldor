--* From tom@cs.st-andrews.ac.uk  Thu May 11 12:23:41 2000
--* Received: from delamain.cs.st-andrews.ac.uk (delamain.dcs.st-and.ac.uk [138.251.206.230])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id MAA17680
--* 	for <ax-bugs@nag.co.uk>; Thu, 11 May 2000 12:23:37 +0100 (BST)
--* From: tom@cs.st-andrews.ac.uk
--* Received: (from tom@localhost)
--* 	by delamain.cs.st-andrews.ac.uk (8.9.3/8.9.3) id NAA01068
--* 	for ax-bugs@nag.co.uk; Thu, 11 May 2000 13:03:25 +0100
--* Date: Thu, 11 May 2000 13:03:25 +0100
--* Message-Id: <200005111203.NAA01068@delamain.cs.st-andrews.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [8] compliler seg faults with a bad type

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: see detailed description
-- Version: 1.1.12p5 for LINUX(glibc) (debug version)
-- Original bug file name: sgf3.as

--+ 
--+ Split this file into two: sgf3.as and stream.as (see comments).
--+ Compile with -DBUGGED to get segfault.
--+ Problem is passing SI instead of GF to displayStream.
#include "basicmath"


#library StreamLib "stream.ao"

import from StreamLib;
inline from StreamLib;

import from Integer;

----------------------------------------------------------------------

SI ==> SingleInteger;
GF ==> PrimeField 3;
SGF ==> Stream(GF);

----------------------------------------------------------------------

displayStream(T:BasicType)(num:SI)(msg:String, g:Stream(T)):() ==
{
   import from T;
   import from List(T);
   import from Stream(T);

   local xtra:SI := 30 - #msg;

   print << msg << " ";
   for i in 1..xtra repeat
      print << ".";
   print << " = [";
     for i in g for x in 1..num repeat
        print << i << ", ";
   print << "...]" << newline;
}
   
-----------------------------------------------------------
   -- Useful helper functions
   id(n:GF):GF == n;


main():() ==
{
   import from SI;
   import from SGF;
   import from DoubleFloat;


   -- Create  simple display functions
#if BUGGED
   showS ==  displayStream(SI)(8);
#else
   showS ==  displayStream(GF)(8);
#endif

   -- Define and check constants in [-1,1]
   -- Many of these will change.

   zero : SGF == new(0,id);               -- [] doesn't exist
   showS("zero", zero);

}


main();


-- =======================================================================
-- CUT HERE (stream.as follows)
-- =======================================================================

#include "basicmath"

--------- This is funstream.as with basicmath included
--------- instead of axllib

------------------------------------------------------------------------

+++ StreamCategory(T) is the category of domains which can be used
+++ as internal values of Stream(T).
define StreamCategory(T:Type):Category == with
{
   copy:  % -> %;
      ++ copy(s) returns a new stream which has the same value and
      ++ properties as `s', but is independent from it. Operations
      ++ on `s' will not affect copy(s) and vice versa. However,
      ++ operations on mutable values stored in `s' may change the
      ++ corresponding mutable values stored in copy(s).

   value: % -> T;
      ++ Obtain the value of the current stream without changing it.

   value!: % -> T;
      ++ Return the current value of the current stream, possibly
      ++ updating it to its next state.

   debugPrint: % -> ();
      ++ Low-level debugging function. Prints out the rep.
}

------------------------------------------------------------------------
-- Other useful macros

SI ==> SingleInteger;

------------------------------------------------------------------------

+++ Stream(T) provides a domain of infinite lists of values. All the
+++ exports of this domain (with the exception of take! and head!)
+++ use copies of their stream arguments. This prevents the values
+++ obtained from one stream from being affected by operations any
+++ other stream.
Stream(T:Type) : Aggregate(T) with
{
   new: (T, T -> T) -> %;
      ++ new(t, gen) returns the stream [t, gen t, gen gen t, ...]

   stream: (S:StreamCategory(T), S) -> %;
      ++ Generic constructor: stream(S, s) returns the stream object
      ++ constructed from the value s:S.

   take: (SI, %) -> List(T);
      ++ take(n, stream) returns the first `n' elements of `stream'.

   take!: (SI, %) -> List(T);
      ++ take!(n, s) removes and returns the first `n' elements of `s'.

   cons: (T, %) -> %;
      ++ cons(x, stream) returns stream whose first element is `x' and
      ++ whose remaining elements are `stream' (order unchanged).

   merge: (%, %) -> %;
      ++ merge([a0, a1, ...], [b0, b1, ...]) returns the stream
      ++ [a0, b0, a1, b1, ...]

   merge: ((T, T) -> T) -> (%, %) -> %;
      ++ merge(op)([a0, a1, ...], [b0, b1, ...]) returns the stream
      ++ [op(a0, b0), op(a1, b1), ...]

   merge: ((T, T) -> Boolean) -> (%, %) -> %;
      ++ merge(op)(s1, s2) returns the stream created by taking values
      ++ from `s1' when `op(head(s1), head(s2))' is true and values
      ++ from `s2' when it is false.

   filter: (T -> Boolean) -> % -> %;
      ++ filter(op)(s) returns the stream created by emitting only
      ++ the elements of `s' which satisfy `op'.

   head: % -> T;
      ++ head(stream) returns the first element of the `stream'.

   head!: % -> T;
      ++ head(stream) removes and returns the first element of `stream'.

   tail: % -> %;
      ++ tail(stream) returns `stream' with its first element removed

   copy: % -> %;
      ++ Duplicate a stream: operations on either stream will not have
      ++ any effect on the other (unless the values of each stream are
      ++ related in some way).

   show: (TextWriter, %, SI) -> TextWriter;
      ++ show(t, s, n) writes the first `n' elements of `s' onto `t'.
      ++ If `n' is omitted then a small default value is used.
  
   generator: % -> Generator T;

   map : (T -> T, %) -> %;


   debugPrint: % -> ();
}
== add
{
   -- Streams come in different flavours.
   Rep == Object(StreamCategory(T));
   import from Rep;

   ---------------------------------------------------------------------
   -- Operations specific to this domain
   ---------------------------------------------------------------------

   -- Create a stream of objects starting with `n'.
   new(n:T, gen: T -> T):% ==
   {
      import from FromStream(T);

      per object(FromStream(T), new(n, gen));
   }


   -- Create a stream based on the stream-like domain S
   stream(S:StreamCategory(T), s:S):% ==
      per object(S, copy(s));


   -- Return the stream with an element added to the front
   cons(x:T, g:%):% ==
   {
      import from ConsStream(T);

      per object(ConsStream(T), new(x, g));
   }


   -- Merge of two streams
   merge(as:%, bs:%):% ==
   {
      import from AlternateStream(T);

      per object(AlternateStream(T), new(as, bs));
   }


   -- Piecewise merge of two streams via a binary operator
   merge(op: (T, T) -> T)(as:%, bs:%):% ==
   {
      import from MergedStream(T);

      per object(MergedStream(T), new(as, bs, op));
   }


   -- Merge of two streams with ordering
   merge(op: (T, T) -> Boolean)(as:%, bs:%):% ==
   {
      import from OrderedMergedStream(T);

      per object(OrderedMergedStream(T), new(as, bs, op));
   }


   -- Filter a stream
   filter(op: T -> Boolean)(s:%):% ==
   {
      import from FilteredStream(T);

      per object(FilteredStream(T), new(s, op));
   }


   -- Extract a finite portion of a stream
   take(n:SI, g:%):List(T) ==
   {
      -- local tmp:% := copy(g);
      --
      -- [head!(tmp) for i in 1..n];
      [x for x in g for i in 1..n];
   }


   -- Remove a finite portion from the front of a stream
   take!(n:SI, g:%):List(T) == [head!(g) for i in 1..n];


   -- Return the first element in a stream
   head(g:%):T ==
   {
      local doit(S:StreamCategory(T), s:S):T == value(s);

      doit avail rep g;
   }


   -- Remove and return the first element of a stream
   head!(g:%):T ==
   {
      local doit(S:StreamCategory(T), s:S):T == value!(s);

      doit avail rep g;
   }


   -- Return the stream with its first element removed
   tail(g:%):% ==
   {
      head!(g);
      g;
   }


   -- Return a copy of a stream
   copy(g:%):% ==
   {
      local dup(S:StreamCategory(T), s:S):Object(StreamCategory(T)) ==
         object(S, copy(s));

      per dup avail rep g;
   }


   -- Display the head of a stream
   show(t:TextWriter, x:%, n:SI == 8):TextWriter ==
   {
      if (T has BasicType) then
      {
         import from T;
         local tmp:List(T) := take(n, x);

         t << "[";
         for e in tmp repeat
            t << e << ", ";
         t << "...]";
      }
      else
         t << "stream()";
   }


   -- Low-level debugging print function
   debugPrint(x:%):() ==
   {
      local dbg(S:StreamCategory(T), s:S):() ==
         debugPrint(s);

      dbg avail rep x;
   }

   ---------------------------------------------------------------------
   -- Operations for Aggregate(T)
   ---------------------------------------------------------------------

   -- Infinite streams are never empty!
   empty?(x:%):Boolean == false;


   -- Convert a stream into a generator.
   generator(x:%):Generator(T) == generate
   {
      local tmp:% := copy(x);
      repeat yield head! tmp;
   }


   -- Map a function over a stream
   map(mapper:T -> T, x:%):% ==
   {
      import from MappedStream(T);

      per object(MappedStream(T), new(x, mapper));
   }


   ---------------------------------------------------------------------
   -- Operations for BasicType
   ---------------------------------------------------------------------

   -- Equality test using pointer equality.
   (x:%) = (y:%):Boolean ==
   {
      -- We don't have the machinery to perform equality tests
      -- on infinite streams in finite time.
      import from SI;
      (x pretend SI) = (y pretend SI);
   }


   -- Display the head of the stream
   (t:TextWriter) << (x:%):TextWriter ==
   {
      import from SI;
      show(t, x);
   }

#if 0
   -- Sample stream: do not use unless T has BasicType.
   sample:% == 
   {
      if (T has BasicType) then
      {
         import from T;
         new(sample$T, (x:T):T +-> x);
      }
      else
      {
         -- Do something nasty ...
         import from SI;
         new(0 pretend T, (x:T):T +-> x);
      }
   }
#endif
}


---------------------------------------------------------------------

+++ FromStream(T) is the domain used to represent an infinite stream
+++ of values of type T starting from an initial value `t' using the
+++ generator `gen': [t, gen t, gen gen t, ...].
+++
+++ This domain has been designed for use by Stream(T).
FromStream(T:Type): with
{
   -- We share the interface of StreamCategory(T)
   StreamCategory(T);


   -- We have our own special constructor.
   new: (T, T -> T) -> %;
      ++ new(t, op) creates a new stream with initial value `t'
      ++ and generator `op'.
}
== add
{
   -- All states have to be mutable
   Rep == Record(op: T -> T, data:T);
   import from Rep;
   import from Stream(T);


   -- Local accessors
   generator(x:%):(T -> T) == (rep x).op;


   -- Exports specific to this kind of stream
   new(t:T, o:T -> T):% == per [o, t];


   -- Export for StreamCategory(T)
   copy(x:%):%   == new(value(x), generator(x));
   value(x:%):T  == (rep x).data;

   value!(x:%):T ==
   {
      local result:T := value(x);

      (rep x).data := generator(x)(result);
      result;
   }

   debugPrint(x:%):() ==
   {
      import from SI;
      print << "[";
      print << (generator(x) pretend SI) << ", ";
      if (T has BasicType) then
      {
         import from T;
         print << value(x);
      }
      else
         print << "?";
      print << "]:";
      print << "FromStream";
   }
}


+++ MappedStream(T) is the domain used to represent an infinite stream
+++ of values of type T constructed by applying a map to another stream.
+++ Given the stream S:Stream(T) and a function `map', the values of
+++ this domain are represented by [map head S, map head tail S, ...]
+++
+++ This domain has been designed for use by Stream(T).
MappedStream(T:Type): with
{
   -- We share the interface of StreamCategory(T)
   StreamCategory(T);


   -- We have our own special constructor.
   new: (Stream(T), T -> T) -> %;
      ++ new(s, op) creates a new stream in which every element
      ++ of `s' is mapped by `op' to a new value.
}
== add
{
   -- All states have to be mutable
   Rep == Record(op:(T) -> T, data:Stream(T));
   import from Rep;
   import from Stream(T);


   -- Local accessors
   mapper(x:%):(T -> T)    == (rep x).op;
   streamer(x:%):Stream(T) == (rep x).data;


   -- Exports specific to this kind of stream
   new(s:Stream(T), o:T -> T):% == per [o, copy(s)];


   -- Export for StreamCategory(T)
   copy(x:%):%   == new(streamer(x), mapper(x));
   value(x:%):T  == mapper(x)(head(streamer(x)));
   value!(x:%):T == mapper(x)(head!(streamer(x)));

   debugPrint(x:%):() ==
   {
      import from SI;
      print << "[";
      print << (mapper(x) pretend SI) << ", ";
      debugPrint streamer(x); print << "@" << (streamer(x) pretend SI);
      print << "]:";
      print << "MappedStream";
   }
}


+++ ConsStream(T) is the domain used to represent an infinite stream
+++ of values of type T constructed by prepending a single value to another
+++ stream. Given the stream S:Stream(T) and a value `t', the values of
+++ this domain are represented by [t, head S, head tail S, ...]
+++
+++ This domain has been designed for use by Stream(T).
ConsStream(T:Type): with
{
   -- We share the interface of StreamCategory(T)
   StreamCategory(T);


   -- We have our own special constructor.
   new: (T, Stream(T)) -> %;
}
== add
{
   -- We are either at the head of the stream or we aren't.
   Rep == Record(first:Boolean, hd:T, tl:Stream(T));
   import from Rep;
   import from Stream(T);


   -- Local access functions
   head?(x:%):Boolean   == (rep x).first;
   read!(x:%):()        == ((rep x).first) := false;
   first(x:%):T         == (rep x).hd;
   rest(x:%):Stream(T)  == (rep x).tl;


   -- Expoort specific to this kind of stream
   new(t:T, g:Stream(T)):% == per [true, t, copy(g)];


   -- Exports for StreamCategory(T)
   copy(x:%):% ==
   {
      -- Create a duplicate of an unread stream.
      local result:% := new(first(x), rest(x));


      -- If original stream has been read then mark the same.
      if (not(head?(x))) then
         read!(result);


      -- Return the new stream.
      result;
   }

   value(x:%):T ==
   {
      -- If at head of stream, return consed element
      -- otherwise return the head of the base stream
      head?(x) => first(x);
      head(rest(x));
   }

   value!(x:%):T ==
   {
      local result:T;

      if (head?(x)) then
      {
         -- Read the value and mark stream as read
         result := first(x);
         read!(x);
      }
      else
      {
         -- Read and update the base stream
         result := head!(rest(x));
      }

      result;
   }

   debugPrint(x:%):() ==
   {
      import from SI;
      print << "[";
      print << head?(x) << ", ";
      if (T has BasicType) then
      {
         import from T;
         print << first(x);
      }
      else
         print << "?";
      print << "]:";
      debugPrint rest(x); print << "@" << (rest(x) pretend SI);
      print << "]:";
      print << "ConsStream";
   }
}


+++ AlternateStream(T) is the domain used to represent an infinite stream
+++ of values of type T constructed by extracting values alternately from
+++ two streams. Given the streams [a0, a1, ...] and [b0, b1, ...],
+++ the values of this domain are represented by [a0, b0, a1, b1, ...].
+++
+++ This domain has been designed for use by Stream(T).
AlternateStream(T:Type): with
{
   -- We share the interface of StreamCategory(T)
   StreamCategory(T);


   -- We have our own special constructor.
   new: (Stream(T), Stream(T)) -> %;
}
== add
{
   -- We have a pair of streams and alternately read from each.
   Rep == Record(first:Boolean, s1:Stream(T), s2:Stream(T));
   import from Rep;
   import from Stream(T);


   -- Local access functions
   first?(x:%):Boolean   == (rep x).first;
   read!(x:%):()         == (rep x).first := not(first?(x));
   first(x:%):Stream(T)  == (rep x).s1;
   second(x:%):Stream(T) == (rep x).s2;


   -- Export specific to this kind of stream
   new(st1:Stream(T), st2:Stream(T)):% ==
      per [true, copy(st1), copy(st2)];


   -- Exports for StreamCategory(T)
   copy(x:%):% ==
   {
      -- Create a duplicate of an unread stream.
      local result:% := new(first(x), second(x));


      -- If original stream has been read then mark the same.
      if (not(first?(x))) then
         read!(result);


      -- Return the new stream.
      result;
   }

   value(x:%):T ==
   {
      -- Return the head of one stream or the other
      first?(x) => head(first(x));
      head(second(x));
   }

   value!(x:%):T ==
   {
      local result:T;

      -- Remove and store the head of one stream
      if (first?(x)) then
         result := head!(first(x));
      else
         result := head!(second(x));


      -- Make the other stream the current one
      read!(x);


      -- Return the result
      result;
   }

   debugPrint(x:%):() ==
   {
      import from SI;
      print << "[";
      print << first?(x) << ", ";
      debugPrint first(x); print << "@" << (first(x) pretend SI) << ", ";
      debugPrint second(x); print << "@" << (second(x) pretend SI);
      print << "]:";
      print << "AlternateStream";
   }
}


+++ MergedStream(T) is the domain used to represent an infinite stream
+++ of values of type T constructed by combining values from two streams
+++ using a binary operator. Given the function `op' and the streams
+++ [a0, a1, ...] and [b0, b1, ...], the values of this domain are
+++ represented by [op(a0, b0), op(a1, b1), ...].
+++
+++ This domain has been designed for use by Stream(T).
MergedStream(T:Type): with
{
   -- We share the interface of StreamCategory(T)
   StreamCategory(T);


   -- We have our own special constructor.
   new: (Stream(T), Stream(T), (T, T) -> T) -> %;
}
== add
{
   -- We have a pair of streams and read from both simultaneously.
   Rep == Record(op: (T, T) -> T, s1:Stream(T), s2:Stream(T));
   import from Rep;
   import from Stream(T);


   -- Local access functions
   left(x:%):Stream(T)       == (rep x).s1;
   right(x:%):Stream(T)      == (rep x).s2;
   merger(x:%):((T, T) -> T) == (rep x).op;


   -- Expoort specific to this kind of stream
   new(st1:Stream(T), st2:Stream(T), o:(T, T) -> T):% ==
      per [o, copy(st1), copy(st2)];


   -- Exports for StreamCategory(T)
   copy(x:%):%   == new(left(x), right(x), merger(x));
   value(x:%):T  == merger(x)(head(left(x)), head(right(x)));
   value!(x:%):T == merger(x)(head!(left(x)), head!(right(x)));

   debugPrint(x:%):() ==
   {
      import from SI;
      print << "[";
      print << (merger(x) pretend SI) << ", ";
      debugPrint left(x); print << "@" << (left(x) pretend SI) << ", ";
      debugPrint right(x); print << "@" << (right(x) pretend SI);
      print << "]:";
      print << "MergedStream";
   }
}


+++ FilteredStream(T) is the domain used to represent an infinite stream
+++ of values of type T constructed by extracting elements from a stream
+++ which satisfy the filter.
FilteredStream(T:Type): with
{
   -- We share the interface of StreamCategory(T)
   StreamCategory(T);


   -- We have our own special constructor.
   new: (Stream(T), T -> Boolean) -> %;
}
== add
{
   Rep == Record(op: T -> Boolean, str:Stream(T));
   import from Rep;
   import from Stream(T);


   -- Local access functions
   stream(x:%):Stream(T)   == (rep x).str;
   cmp(x:%):(T -> Boolean) == (rep x).op;


   -- Export specific to this kind of stream
   new(st:Stream(T), o: T -> Boolean):% ==
      per [o, copy(st)];


   -- Exports for StreamCategory(T)
   copy(x:%):% == new(stream(x), cmp(x));

   value(x:%):T  == 
   {
      local op: T -> Boolean := cmp(x);
      local str:Stream(T) := stream(x);

      while (not(op(head(str)))) repeat
         head! str;

      return head str;
   }

   value!(x:%):T ==
   {
      local result:T := value(x);
      local str:Stream(T) := stream(x);

      head! str;
      result;
   }

   debugPrint(x:%):() ==
   {
      import from SI;
      print << "[";
      print << (cmp(x) pretend SI) << ", ";
      debugPrint stream(x); print << "@" << (stream(x) pretend SI);
      print << "]:";
      print << "FilteredStream";
   }
}


+++ OrderedMergedStream(T) is the domain used to represent an infinite
+++ stream of values of type T constructed by extracting values from
+++ two streams. Values are extracted from the first stream while the
+++ comparison operation applied to the head of both streams holds and
+++ values are extracted from the second stream when it does not hold.
+++ For example, if S1 and S2 are two streams whose values are ordered
+++ such that (head S < head tail S) for all substreams of S1 and S2,
+++ then this domain can be used to merge S1 and S2 so that the new
+++ stream preserves the original ordering constraint.
+++
+++ This domain has been designed for use by Stream(T).
OrderedMergedStream(T:Type): with
{
   -- We share the interface of StreamCategory(T)
   StreamCategory(T);


   -- We have our own special constructor.
   new: (Stream(T), Stream(T), (T, T) -> Boolean) -> %;
}
== add
{
   -- We have a pair of streams and read from both simultaneously.
   Rep == Record(op: (T, T) -> Boolean, s1:Stream(T), s2:Stream(T));
   import from Rep;
   import from Stream(T);


   -- Local access functions
   left(x:%):Stream(T)          == (rep x).s1;
   right(x:%):Stream(T)         == (rep x).s2;
   cmp(x:%):((T, T) -> Boolean) == (rep x).op;


   -- Expoort specific to this kind of stream
   new(st1:Stream(T), st2:Stream(T), o:(T, T) -> Boolean):% ==
      per [o, copy(st1), copy(st2)];


   -- Exports for StreamCategory(T)
   copy(x:%):% == new(left(x), right(x), cmp(x));

   value(x:%):T ==
   {
      local lefthead:T  := head(left(x));
      local righthead:T := head(right(x));

      (cmp(x)(lefthead, righthead)) => lefthead;
      righthead;
   }

   value!(x:%):T ==
   {
      local lefthead:T  := head(left(x));
      local righthead:T := head(right(x));

      if (cmp(x)(lefthead, righthead)) then
      {
         head!(left(x));
         lefthead;
      }
      else
      {
         head!(right(x));
         righthead;
      }
   }

   debugPrint(x:%):() ==
   {
      import from SI;
      print << "[";
      print << (cmp(x) pretend SI) << ", ";
      debugPrint left(x); print << "@" << (left(x) pretend SI) << ", ";
      debugPrint right(x); print << "@" << (right(x) pretend SI);
      print << "]:";
      print << "OrderedMergedStream";
   }
}

----------------------------------------------------------------------
