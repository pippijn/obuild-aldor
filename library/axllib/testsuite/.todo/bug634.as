--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Thu May 12 06:12:50 1994
--* Received: from yktvmv.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA15073; Thu, 12 May 1994 06:12:50 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 4193; Thu, 12 May 94 06:12:51 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.BRONSTEI.NOTE.YKTVMV.0657.May.12.06:12:50.-0400>
--*           for asbugs@watson; Thu, 12 May 94 06:12:51 -0400
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Thu, 12 May 94 06:12:49 EDT
--* Received: from vinci.inf.ethz.ch (vinci.inf.ethz.ch [129.132.12.46]) by inf.ethz.ch (8.6.8/8.6.6) with ESMTP id MAA02476 for <asbugs@watson.ibm.com>; Thu, 12 May 1994 12:12:45 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by vinci.inf.ethz.ch (8.6.8/8.6.6) id MAA16766 for asbugs@watson.ibm.com; Thu, 12 May 1994 12:12:44 +0200
--* Date: Thu, 12 May 1994 12:12:44 +0200
--* Message-Id: <199405121012.MAA16766@vinci.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: [6] category default not seen in type [btree.as][0.35.0 [=]]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

----------------------------- btree.as ----------------------------------
-- THE CATEGORY DEFAULT test:%->Boolean IS NOT BEING SEEN IN THE TYPE:
--
-- vinci.inf.ethz.ch{bronstei} 102: asharp -M2 btree.as
-- "btree.as", line 34: BinaryTree(S:Order): BinaryTreeCategory S == add {
--                      .............................................^
-- [L34 C46] (Error) No suitable interpretation for the expression `add ...'
--         The following exports were not provided:
--         Missing test: % -> Boolean

#include "axllib"

BinaryTreeCategory(S:Order):Category ==
	Join(BasicType, Aggregate S, Conditional) with {
		leaf?: % -> Boolean;
		++ leaf? tree returns true if tree is a leaf, false otherwise.
		left: % -> %;
		++ left tree returns the left subtree of tree.
		right: % -> %;
		++ right tree returns the right subtree of tree.
		empty: () -> %;
		++ empty() creates an empty tree.
		insert!: (S, %) -> %;
		++ insert(a, t) inserts a into t if not already there,
		++ error if t is empty.
		member?: (S, %) -> Boolean;
		++ member?(s, t) returns true if s is in t, false otherwise.
		preOrder: % -> List S;
		++ preOrder tree returns the preorder traversal of tree.
		inOrder: % -> List S;
		++ inOrder tree returns the inorder traversal of tree.
		postOrder: % -> List S;
		++ postOrder tree returns the postorder traversal of tree.
		root: % -> S;
		++ root t returns the root node of t, error if t is empty.
		tree: S -> %;
		++ tree s returns a tree containing only s.

		-- THIS DEFAULT IS NOT SEEN
		default test(tree:%):Boolean == not empty? tree;
}

BinaryTree(S:Order): BinaryTreeCategory S == add {
	macro Rep == P;
	macro R   == Record(key:S, lft: Rep, rgt: Rep);

	-- untagged union of Record and Nil
	P: with {
		nil?:    % -> Boolean;
		nilptr:  %;
		recptr:  R -> %;
		value:   % -> R;
	} == add {
		macro  Rep == Pointer;
		import from Rep;
		nil?(p: %):Boolean	== nil? rep p;
		nilptr:%		== per(nil$Pointer);
		recptr(r:R):%		== r pretend %;
		value(p:%):R		== p pretend R;
	}

	import from R;

	-- THIS TYPE WON'T COMPILE WITHOUT THIS LINE
	-- test(tree:%):Boolean == not empty? tree;

	rec(x:%):R			== value rep x;
	empty():%    			== per nilptr;
	empty?(t:%):Boolean		== nil? rep t;
	sample:%			== empty();
	tree(a:S):%			== per(recptr [a, nilptr, nilptr]);
	root(t:%):S	== { empty? t => error "root: empty tree"; rec(t).key };
	left(t:%):% == { empty? t => error "left: empty tree"; per(rec(t).lft)};
	right(t:%):%== { empty? t => error "right: empty tree";per(rec(t).rgt)};
	#(t:%):SingleInteger	== { empty? t => 0; #(left t) + #(right t) + 1};

	leaf?(t:%):Boolean ==
		not(empty? t) and empty? left t and empty? right t;

	generator(tree:%):Generator S == {
		import from List S;
		generator preOrder tree;
	}

	[t:Tuple S]:% == {
		import from SingleInteger;
		zero?(l := length t) => empty();
		tr:% := tree(element(t, 1));
		for i in 2..l repeat insert!(element(t, i), tr);
		tr;
	}

	[g:Generator S]:% == {
		empty? g => empty();
		first?:Boolean := true;
		local tr:%;
		for a in g repeat
			if first? then { tr := tree a; first? := false }
			else insert!(a, tr);
		tr;
	}

	apply(p:OutPort, t:%):OutPort == {
		empty? t => p("()");
		p("(")(root t)(" ")(left t)(" ")(right t)(")");
	}

	preOrder(t:%):List S == {
		empty? t => empty();
		cons(root t, concat!(preOrder left t, preOrder right t));
	}

	inOrder(t:%):List S == {
		empty? t => empty();
		concat!(inOrder left t, cons(root t, inOrder right t));
	}

	postOrder(t:%):List S == {
		empty? t => empty();
		concat!(concat!(postOrder left t, postOrder right t), [root t]);
	}

	-- insert! returns the modified tree after the insertion
	insert!(a:S, t:%):% == {
		if a ~= (r := root t) then insert0!(a, r, t);
		t;
	}

	-- insert0! returns a pointer to the leaf containing a
	insert0!(a:S, r:S, t:%):% == {
		a < r => {
			empty?(t0 := left t) => per(rec(t).lft := rep tree a);
			insert!(a, t0);
		}
		empty?(t0 := right t) => per(rec(t).rgt := rep tree a);
		insert!(a, t0);
	}

	member?(a:S, t:%):Boolean == {
		empty? t => false;
		a = (r := root t) => true;
		a < r => member?(a, left t);
		member?(a, right t);
	}

	(t1:%) = (t2:%):Boolean == {
		b := empty? t2;
		empty? t1 => b;
		not(b) and left t1 = left t2 and right t1 = right t2;
	}

}
