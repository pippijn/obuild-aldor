-------------------------------------------------------------------------
--
-- eio_chtc.as
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

#include "extio.as"

+++\begin{addescription}{implements a hash table.}
+++For colliding hashes, the chaining strategy is used. \adcode{K} is the domain for the keys in \adthistype and \adcode{V} the domain for the values. The parameter \adcode{hashK} denotes a hashing function on the keys.
+++\end{addescription}
+++\begin{adremarks}
+++By the domain \adtype{HashTable}, \LibAldor already provides a hash table. However, \adtype{HashTable} is conceptionally broken. For example, using a non-trivial \adname[HashTable]{remember} function for \adtype{HashTable}{}s allows to generate \adtype{HashTable}{}s with infinitely many elements. But \adtype{HashTable} has \adtype{BoundedFiniteLinearStructure}, which causes a semantic contradiction. Furthermore, \adtype{HashTable}'s \adname[HashTable]{#} function refers to the number of slots in the hash table, not to the number of entries, which raises another semantic contradiction.
+++
+++As there are even more such semantic contradictions, \adtype{HashTable} should not be used. \adthistype should be used as semantically correct alternative.
+++\end{adremarks}
+++\begin{adseealso}
+++\adtype{ChainingHashTable}
+++\end{adseealso}
ChainingHashTableWithCustomHashFunction( 
  K: PrimitiveType,
  V: Type,
  hashK: K -> MachineInteger
): with {

    TableType( K, V );
    
    if V has PrimitiveType then {
	PrimitiveType;
    }
    
    if V has PrimitiveType then
    {
        +++\begin{addescription}{checks inclusion of hash tables}
+++\adcode{contained?( a, b )} yields \adname[Boolean]{true} if and only if all key-value pairs of \adcode{a} are contained in \adcode{b}. Otherwise, \adthisname yields \adname[Boolean]{false}.
+++\end{addescription}
        contained?:( %, % ) -> Boolean;
    }    

} == add {

    import from MachineInteger;
    macro DEFAULTSIZE == 9;

    import from K;
    
    macro KV == KeyEntry( K, V );    
    import from KV;
    
    macro SLOT == List KV;
    import from SLOT;
    
    macro Rep == Record( nEntries: MachineInteger, hashToSlot: MachineInteger -> MachineInteger, slots: Array SLOT );
    import from Array SLOT;
    import from Rep;

    macro repA   == rep a;
    macro nEntriesA == repA . nEntries;
    macro hashToSlotA == repA . hashToSlot;
    macro slotsA == repA . slots;
      
    ----------------------

    copy( a: % ): % == {
	local ret: %;
	
	ret := table( nEntriesA );
	
	for kv in generator a repeat
	{
	    ( k, v ) := kv;
	    ret . k := v; 
	}
	ret;
    }
    
    ----------------------

    empty?( a: % ): Boolean == {
	zero? nEntriesA;
    }
    
    ----------------------

    free!( a: % ): () == {
	free! slotsA;
    }
    
    ----------------------

    generator( a: % ): Generator Cross( K, V ) == {
	generate {
	    for slot in slotsA repeat
	    {
		for slotElement in slot repeat 
		{
		    yield explode slotElement;
		}
	    }
	}
    }
    
    ----------------------

    numberOfEntries( a: % ): MachineInteger == {
	# a;
    }
    
    ----------------------

    #( a: % ): MachineInteger == {
	nEntriesA;
    }
    
    ----------------------

    find( k: K, a: % ): Partial V == {
	( found?, position, kv: KV ) := linearSearch( [ k, (nil$Pointer) pretend V ], slotsA . (hashToSlotA hashK k) );
	found? => [ entry kv ];
	failed;
    }
    
    ----------------------

    local nextSlotCount( oldSlotCount: MachineInteger ): MachineInteger == {
	import from Integer;
	assert( oldSlotCount :: Integer < (max$MachineInteger) :: Integer - 1 quo 2 );
	oldSlotCount * 2 + 1;
    }
    
    ----------------------

    local enlarge!( a: % ): () == {

	local newSlotCount: MachineInteger := nextSlotCount # slotsA;
	local newSlots: Array SLOT := new newSlotCount;
	local newHashToSlotFunc: MachineInteger  -> MachineInteger := createHashToSlotMapping newSlotCount;

	for slot in slotsA repeat
	{
	    for slotElement in slot repeat 
	    {
		slotIdx := newHashToSlotFunc( hashK key slotElement );
		newSlots . slotIdx := insert!( slotElement, newSlots . slotIdx );
	    }
	}
	slotsA := newSlots;
	hashToSlotA := newHashToSlotFunc;
    }
    
    ----------------------

    local createHashToSlotMapping( slotCount: MachineInteger ): MachineInteger -> MachineInteger == {
	( a: MachineInteger ): MachineInteger +-> { 
	    a mod slotCount 
	}
    }

    ----------------------

    set!( a: %, k: K, v: V ): V == {
	local slotIdx: MachineInteger := (hashToSlotA hashK k);
	assert( slotIdx >= 0 and slotIdx < # slotsA );
	( found?, position, kv: KV ) := linearSearch( [ k, (nil$Pointer) pretend V ], slotsA . slotIdx );
	found? => {
	    setEntry!( kv, v );
	}
	if ( ( nEntriesA * 10 ) quo  ( # slotsA ) >= 7 ) then
	{ 
	    enlarge!( a );
	    slotIdx := (hashToSlotA hashK k);
	    assert( slotIdx >= 0 and slotIdx < # slotsA );
	}
	slotsA . slotIdx := insert!( [ k, v ], slotsA . slotIdx );
	nEntriesA := next nEntriesA;
	v;
    }
    
    ----------------------

    table( ): % == {
	table( DEFAULTSIZE );
    }
    
    ----------------------

    table( slotCount: MachineInteger ): % == {
	if ( slotCount < DEFAULTSIZE ) then 
	{
	    slotCount := DEFAULTSIZE;
	}
	assert( slotCount > 0 );
	per record( 0, createHashToSlotMapping slotCount, new nextSlotCount slotCount );
    }
    
    ----------------------

    if V has PrimitiveType then
    {
        contained?( a: %, b: % ): Boolean == {

            import from K;
            import from V;
            import from Partial V;

            for keyValueCross in a repeat 
            {
                import from Partial V;
                local key: K;
                local valueA: V;
                ( key, valueA ) := keyValueCross;

                local pValueB := find( key, b );
                if failed? pValueB then
                {
                    return false;
                }

                if valueA ~= retract pValueB then
                {
                    return false;
                }
            }

            true;
        }           

        =( a: %, b: % ): Boolean == {
            import from MachineInteger;
            # a = # b and contained?( a, b ) and contained?( b, a );
        }           

    } 
    
    ----------------------

}