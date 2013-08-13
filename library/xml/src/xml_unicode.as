#include "aldor"
--#include "aldorio"

L ==> List;
U ==> Union;
A ==> Array;
B ==> Boolean;
T ==> Tuple;
MI ==> MachineInteger;
BY ==> Byte;
CH ==> Character;
TW ==> TextWriter;
PA ==> PrimitiveArray;
STR ==> String;
INT ==> Integer;

import from String;

define UniCodeCharacter:Category == Join(PrimitiveType,OutputType) with {
  --space : %;
  --  ++ this is the space constant, it should have the value equivalent to a 
  --  ++ space character in the specific UniCode
  fromUCSB : (CH,CH) -> %;
    ++ encode a one byte UniCode character, where the character is specified in
    ++ two hexadecimal digits.
  fromUCS2 : (CH,CH,CH,CH) -> %;
    ++ encode a UCS-2 sequence as UniCode, the character is given as four
    ++ hexadecimal digits.
  fromUCS4 : (CH,CH,CH,CH,CH,CH,CH,CH) -> %;
    ++ encode a UCS-4 sequence as UniCode, the character is given as eight
    ++ hexadecimal digits.
  fromASCII : CH -> %;
    ++ encode a single character which is an ASCII code, ie. less than #xFF
  qFromASCII : CH -> %;
    ++ encode a single character which is an ASCII code, ie. less than #xFF
    ++ no checking is performed
  fromChar : CH -> %;
    ++ encode a single character
  qFromChar : CH -> %;
    ++ quick encoding of a single character (no checking is performed)
  fromCharLow : CH -> %;
    ++ encode a single character (the character must be in the range 0-x7F)
  qFromCharLow : CH -> %;
    ++ quick encoding of a single character (no checking is performed, 
    ++ the character must be in the range 0-x7F)
  toUCS : % -> T(BY);
    ++ go from the domain to the one byte, two byte, three byte, ... form
  qToUCS : % -> T(BY);
    ++ quick function to go from the domain to the one byte, two byte, 
    ++ three byte, ... form (no checking is performed)
  toHex : % -> T(STR);
    ++ return the character in hexadecimal form
  toCharLow : % -> CH;
    ++ return the character as a char (the character must be in the range 0-x7F);
  qToCharLow : % -> CH;
    ++ quick function to return the character as a character (it is assumed 
    ++ the character is in the correct range 0-x7F);
  default {
    import from Character;

    ((ch1:%) = (ch2:%)):Boolean == false; 
    fromUCSB(ch1:CH,ch2:CH):% == error "not implemented";
    fromUCS2(ch1:CH,ch2:CH,ch3:CH,ch4:CH):% == error "not implemented";
    fromUCS4(ch1:CH,ch2:CH,ch3:CH,ch4:CH,ch5:CH,ch6:CH,ch7:CH,ch8:CH):% == 
      error "not implemented";
    fromASCII(ch:CH):% == error "not implemented";
    fromChar(ch:CH):% == error "not implemented";
    fromCharLow(ch:CH):% == error "not implemented";
    qFromASCII(ch:CH):% == error "not implemented";
    qFromChar(ch:CH):% == error "not implemented";
    qFromCharLow(ch:CH):% == error "not implemented";
    toUCS(x:%):T(BY) == error "not implemented";
    qToUCS(x:%):T(BY) == error "not implemented";
    toCharLow(ch:%):CH == error "not implemented";
    qToCharLow(ch:%):CH == error "not implemented";
    toHex(u:%):T(STR) == error "not implemented";
  }
}

+++ This domain may be used for representing 7 bit unicode characters, it does
+++ little processing
ASCII:UniCodeCharacter == add {
  Rep ==> Byte;
  import from Rep;

  space:% == {
    import from String;
    per(char(" ")::Byte)
  };

  (x:%) = (y:%):B == {
    rep(x) = rep(y)
  }

  (w: TextWriter) << (b: %): TextWriter == {
    w<<rep(b)
  }

  fromUCSB(c1:CH,c2:CH):% == {
    error "not done"
  }

  fromUCS2(c1:CH,c2:CH,c3:CH,c4:CH):% == {
    error "not done"
  }

  fromUCS4(c1:CH,c2:CH,c3:CH,c4:CH,c5:CH,c6:CH,c7:CH,c8:CH):% == {
    error "not done"
  }

  fromChar(ch:CH):% == {
    per(ch::Byte)
  }

  toUCS(x:%):T(BY) == {
    error "not done"
  }

  toHex(x:%):T(STR) == {
    error "not done"
  }

  toCharLow(x:%):CH == {
    error "not done"
  }
}

+++ This domain may be used for representing 7 bit Unicode characters.
+++ Enough processing is done to take input in all the allowed forms.
+++ If the character value is out of range, an error is raised.
UChar:UniCodeCharacter == add {
  Rep ==> Byte;

  import from STR,Rep;

  local sevenF,zCd,eightCd,nineCd,Acd,Fcd:MI;
  sevenF := 127;zCd := 48;eightCd := 56;nineCd := 57;Acd := 65;Fcd := 70;

--  local sevenF:MI := 127;
  local zero:CH := char "0";
--  local zCd:MI := 48;
--  local eightCd:MI := 56;
--  local nineCd:MI := 57;
--  local Acd:MI := 65;
--  local AcdB:BY := 65;
--  local Fcd:MI := 70;

  ch2hex(ch:MI):MI == {
    ch>=Acd => ch-Acd+10;
    ch-zCd
  }

  space:% == error "not done yet (space)";

  fromUCSB(high:CH,low:CH):% == {
    local oH,oL:MachineInteger;
    (oH,oL) := (ord(high),ord(low));
    if oH<eightCd and oH>=zCd and 
       ((oL>=zCd and oL<=nineCd) or (oL>=Acd and oL<=Fcd)) then
      per(lowByte(ch2hex(oH)*16+ch2hex(oL)))
    else error "arguments are not in the correct range"
  }

  fromUCS2(bHigh:CH,bLow:CH,sHigh:CH,sLow:CH):% == {
    local oH,oL:MachineInteger;
    (oH,oL) := (ord(sHigh),ord(sLow));
    if (bHigh=zero and bLow=zero and oH>=zCd and oH<eightCd and oH>=zCd and
        ((oL>=zCd and oL<=nineCd) or (oL>=Acd and oL<=Fcd))) then
      per(lowByte(ch2hex(oH)*16+ch2hex(oL)))
    else error "arguments are not in the correct range"
  }

  fromUCS4(b2High:CH,b2Low:CH,s2High:CH,s2Low:CH,bHigh:CH,bLow:CH,sHigh:CH,sLow:CH):% == {
    if (b2High=zero and b2Low=zero and s2High=zero and s2Low=zero) then
      fromUCS2(bHigh,bLow,sHigh,sLow)
    else error "arguments are not in the correct range"
  }

  fromChar(ch:CH):% == {
    o := ord(ch);
    if o>sevenF then error "the character has too great a value"
    else per lowByte o
  }

  (w: TextWriter) << (b: %): TextWriter == {
    import from CH;
    --print<<char(rep(b)::MI)
    w<<char(rep(b)::MI)
  }

  toUCS(x:%):T(BY) == {
    error "not done yet (toUCS)"
  }

  toHex(x:%):T(STR) == {
    error "not done yet (toHex)"
  }

  toCharLow(x:%):CH == {
    error "not done yet (toChar)"
  }

  (x:%) = (y:%):B == {
    error "not done yet (=)"
  }
}

+++ UTF8Char is a domain to implement UTF8 character encoding.
+++ The individual characters are stored as Tuples of Bytes.
UTF8Char:UniCodeCharacter == add {
  Rep ==> T(Byte);

  local sevenF:MI := 127;
  local zCd:MI := 48;
  local eightCd:MI := 56;
  local nineCd:MI := 57;
  local Acd:MI := 65;local Acdmten:MI := 55;
  local Fcd:MI := 70;

  import from Rep,Machine,String,MachineInteger;

  -- we are cheating a bit with these ordering functions, this is to 
  -- get around the problem that 255@Byte < 1@Byte
  lt(x:BY,y:BY):B == {
    (x pretend SInt < y pretend SInt)::B
  }

  gt(x:BY,y:BY):B == lt(y,x);

  -- the following constants are defined in order to provide a certain 
  -- (limited) speed up
  zChar:CH == char "0";
  D8 == 216::SInt;DC == 220::SInt;F == 15::SInt;
  (one,two,three,four,five,six,seven,eight) := 
    (1@SInt,2::SInt,3::SInt,4::SInt,5::SInt,6::SInt,7::SInt,8::SInt);
  (ten,sixteen) := (lowByte(10),lowByte(16));

  -- these ones are ASCII codes for characters (and code-1)
  local zCdm1,nineCdp1,Acdm1,Fcdp1:MI;
  (zCdm1,nineCdp1,Acdm1,Fcdp1) := (47,58,64,71);
  tensi == 10::SInt;four8 == 48::SInt;five5 == 55::SInt;

  local zCdm1b,zCdb,nineCdp1b,Acdm1b,Acdmtenb,Fcdp1b:Byte;
  zCdm1b == lowByte(47);zCdb == lowByte(48);nineCdp1b == lowByte(58);
  Acdm1b == lowByte(64);Acdmtenb == lowByte(55);Fcdp1b == lowByte(71);
  sixty3:SInt == 63::SInt;one27:SInt == 127::SInt;

  hex?(ch:CH):B == {
    v:MI := ord ch;
    (v>zCdm1 and v<nineCdp1) or (v>Acdm1 and v<Fcdp1)
  }

  hex?(v:BY):B == {
    (gt(v,zCdm1b) and lt(v,nineCdp1b)) or (gt(v,Acdm1b) and lt(v,Fcdp1b))
  }

  -- convert a nibble (half a byte) to a character which represents the 
  -- hexadecimal value
  nibbleToHex(n:Byte):CH == {
    lt(n,ten) => char(n::MI+48);
    char(n::MI+55)
  }
  nibbleToHex(n:SInt):CH == {
    (n<tensi)::Boolean => char(n+four8)::CH;
    char(n+five5)::CH
  }

  -- convert a byte value to a string which contains the characters 
  -- corresponding to the hexadecimal value
  byteToHex(by:Byte):STR == {
    import from A(CH);
    bysi:SInt := convert(by::XByte);
    [nibbleToHex(convert(shiftDown(bysi,four))@XByte::Byte),
            nibbleToHex(convert(bysi /\ F)@XByte::Byte)]
  }

  -- convert a single hex digit (ASCII) to a value between 0 and 15
  hex2byte(b:Byte):Byte == {
    bmi:MI := b::MI;
    if lt(b,nineCdp1b) then lowByte(bmi-zCd) else lowByte(bmi-Acdmten)
  }

  hex2byte(b:MI):MI == {
    if (b<58) then b-48 else b-55
  }

  hex2byte(h:BY,l:BY):BY == convert(convert(hex2byte(h)::XByte)@SInt*sixteensi
    +convert(hex2byte(l)::XByte)@SInt)@XByte::Byte;

  char2si(h:MI,l:MI):MI == hex2byte(h)*16@MI+hex2byte(l);

--  space:% == {
--    per(tup(convert(32::SInt)@XByte::Byte));
--  }

  sixteensi:SInt == 16::SInt;
  val2hex(v:MI):L(CH) == {
    vsi:SInt := v::SInt;
    ret:L(CH) := [];
    repeat {
      ret := cons(nibbleToHex(vsi rem sixteensi),ret);
       if ((vsi := vsi quo sixteensi)=0)::Boolean then break
    }
    ret
  }

  -- form a tuple
  tup(b:Byte):Tuple(Byte) == {
    --ret:PA(BY) := new 1;
    ret:PA(BY) := [b];
    tuple(1,ret pretend Pointer)
  }

  tup(b1:Byte,b2:Byte):Tuple(Byte) == {
    --ret:PA(BY) := new 2;
    --ret.1 := b1;ret.2 := b2;
    ret:PA(BY) := [b1,b2];
    tuple(2,ret pretend Pointer)
  }

  tup(b1:Byte,b2:Byte,b3:Byte):Tuple(Byte) == {
    --ret:PA(BY) := new 3;
    --ret.1 := b1;ret.2 := b2;ret.3 := b3;
    ret:PA(BY) := [b1,b2,b3];
    tuple(3,ret pretend Pointer)
  }

  tup(b1:Byte,b2:Byte,b3:Byte,b4:Byte):Tuple(Byte) == {
    --ret:PA(BY) := new 4;
    --ret.1 := b1;ret.2 := b2;ret.3 := b3;ret.4 := b4;
    ret:PA(BY) := [b1,b2,b3,b4];
    tuple(4,ret pretend Pointer)
  }

  tup(b1:Byte,b2:Byte,b3:Byte,b4:Byte,b5:Byte):Tuple(Byte) == {
    --ret:PA(BY) := new 5;
    --ret.1 := b1;ret.2 := b2;ret.3 := b3;ret.4 := b4;ret.5 := b5;
    ret:PA(BY) := [b1,b2,b3,b4,b5];
    tuple(5,ret pretend Pointer)
  }

  tup(b1:Byte,b2:Byte,b3:Byte,b4:Byte,b5:Byte,b6:Byte):Tuple(Byte) == {
    --ret:PA(BY) := new 6;
    --ret.1 := b1;ret.2 := b2;ret.3 := b3;ret.4 := b4;ret.5 := b5;ret.6 := b6;
    ret:PA(BY) := [b1,b2,b3,b4,b5,b6];
    tuple(6,ret pretend Pointer)
  }

  fromASCII(c:CH):% == {
    if(o:MI := ord c)>255 then error "the character is not ASCII";
    
    o2:SInt := o::SInt;
    fromUCSB(nibbleToHex(convert(shiftDown(o2,four))@XByte::Byte),
             nibbleToHex(convert(o2 /\ F)@XByte::Byte))
  }

  one93:Byte == convert(193::SInt)@XByte::Byte;
  fromUCSB(high:CH,low:CH):% == {
    not(hex?(high) and hex?(low)) => 
      error "the arguments must be hexadecimal characters (fromUCSB)";
    val:MI := char2si(ord high,ord low);
    -- check if this value is less than x7F
    if val<128 then return(per(tup(convert(val::SInt)@XByte::Byte)));
    -- the high bit is 1, so the UTF-8 has a first byte of 193
    ret:Rep := tup(one93,convert((val::SInt/\sixty3)\/one27)@XByte::Byte);
    return(per(ret))
  }

  one92:SInt == 192::SInt;two24:SInt == 224::SInt;one28:SInt == 128::SInt;
  fromUCS2(bHigh:CH,bLow:CH,sHigh:CH,sLow:CH):% == {

    not(hex?(bHigh) and hex?(bLow) and hex?(sHigh) and hex?(sLow)) => 
      error "the arguments must be hexadecimal characters (fromUCS2)";
    (bVal,sVal) := (char2si(ord bHigh,ord bLow),char2si(ord sHigh,ord sLow));
    -- if code is less than x7F
    if bVal=0 and sVal<128 then {ret:Rep := tup(convert(sVal::SInt)@XByte::Byte);return per ret}
    -- is it less than x7FF - we can do this with 2 Bytes
    sValsi:SInt := sVal::SInt; 
    if bVal<7 then {
      b1 := convert(shiftUp(bVal::SInt,two) \/ shiftDown(sValsi,six) \/ one92)@XByte::Byte;
      b2 := convert((sValsi /\ sixty3) \/ one28)@XByte::Byte;
      ret:Rep := tup(b1,b2);
      return(per(ret))
    }
    -- otherwise we must use 3 bytes
    bValsi:SInt := bVal::SInt;
    b1 := convert(shiftDown(bValsi,four) \/ two24)@XByte::Byte;
    b2 := convert(shiftDown(shiftUp(bValsi,four),two) \/ shiftDown(sValsi,six) 
           \/ one28)@XByte::Byte;
    b3 := convert((sValsi /\ sixty3) \/ one28)@XByte::Byte;
    ret:Rep := tup(b1,b2,b3);
    per(ret)
  }

  fromUCS2(bVal:MI,sVal:MI):% == {
    -- is it less than x7FF - we can do this with 2 Bytes
    sValsi:SInt := sVal::SInt; 
    if bVal<7 then {
      b1 := convert(shiftUp(bVal::SInt,two) \/ shiftDown(sValsi,six) \/ one92)@XByte::Byte;
      b2 := convert((sValsi /\ sixty3) \/ one28)@XByte::Byte;
      ret:Rep := tup(b1,b2);
      return(per(ret))
    }
    -- otherwise we must use 3 bytes
    bValsi:SInt := bVal::SInt;
    b1 := convert(shiftDown(bValsi,four) \/ two24)@XByte::Byte;
    b2 := convert(shiftDown(shiftUp(bValsi,four),two) \/ shiftDown(sValsi,six) 
           \/ one28)@XByte::Byte;
    b3 := convert((sValsi /\ sixty3) \/ one28)@XByte::Byte;
    ret:Rep := tup(b1,b2,b3);
    per(ret)
  }

  two40:SInt == 240::SInt;two47:SInt == 247::SInt;two53:SInt == 253::SInt;
  fromUCS4(b2High:CH,b2Low:CH,s2High:CH,s2Low:CH,bHigh:CH,bLow:CH,sHigh:CH,sLow:CH):% == {
    not(hex?(b2High) and hex?(b2Low) and hex?(s2High) and hex?(s2Low)
        and hex?(bHigh) and hex?(bLow) and hex?(sHigh) and hex?(sLow)) => 
      error "the arguments must be hexadecimal characters (fromUCS4)";
    (val1,val2,val3,val4) := (char2si(ord b2High,ord b2Low),
                              char2si(ord s2High,ord s2Low),
                              char2si(ord bHigh,ord bLow),
                              char2si(ord sHigh,ord sLow));
    -- check the 'ASCII' range (0-x7F)
    if val1=0 and val2=0 then {
      if val3=0 and val4<128 then {
      ret:Rep := tup(convert(val4::SInt)@XByte::Byte);return per ret}
      -- the value is still UCS-2 (xFF-xFFFF)
      return(fromUCS2(val3,val4))
    }
    -- check whether value is to high (x7FFF FFFF)
    if val1>127 then error "illegal value";
    -- We are in the range xFFFF-x7FFF FFFF
    (valsi1,valsi2,valsi3,valsi4) := 
      (val1::SInt,val2::SInt,val3::SInt,val4::SInt);
    if val2<32 and val1=0 then { -- the result will be in four bytes
      b4 := convert(shiftDown(valsi4,two) \/ one28)@XByte::Byte;
      b3 := convert(shiftDown(valsi4,six) \/ shiftDown(shiftUp(valsi3,four),two) 
              \/ one28)@XByte::Byte;
      b2 := convert(shiftDown(valsi3,four) \/ shiftDown(shiftUp(valsi2,six),two)
              \/ one28)@XByte::Byte;
      b1 := convert(shiftDown(valsi2,five) \/ two40)@XByte::Byte;
      ret:Rep := tup(b1,b2,b3,b4);
      return per ret
    }
    else if val1<4 then {  -- the result will be in five bytes
      b5 := convert(shiftDown(valsi4,two) \/ one28)@XByte::Byte;
      b4 := convert(shiftDown(valsi4,six) \/ shiftDown(shiftUp(valsi3,four),two) 
              \/ one28)@XByte::Byte;
      b3 := convert(shiftDown(valsi3,four) \/ shiftDown(shiftUp(valsi2,six),two)
              \/ one28)@XByte::Byte;
      b2 := convert(shiftDown(valsi2,two) \/ one28)@XByte::Byte;
      b1 := convert(valsi1 \/ two47)@XByte::Byte;
      ret:Rep := tup(b1,b2,b3,b4,b5);
      return per ret
    }
    -- the result will be in six bytes
    b6 := convert(shiftDown(valsi4,two) \/ one28)@XByte::Byte;
    b5 := convert(shiftDown(valsi4,six) \/ shiftDown(shiftUp(valsi3,four),two) 
            \/ one28)@XByte::Byte;
    b4 := convert(shiftDown(valsi3,four) \/ shiftDown(shiftUp(valsi2,six),two)
              \/ one28)@XByte::Byte;
    b3 := convert(shiftDown(valsi2,two) \/ one28)@XByte::Byte;
    b2 := convert(shiftDown(valsi1,two) \/ one28)@XByte::Byte;
    b1 := convert(shiftDown(valsi1,six) \/ two53)@XByte::Byte;
    ret:Rep := tup(b1,b2,b3,b4,b5,b6);
    per ret
  }

  (w: TextWriter) << (b: %): TextWriter == {
    import from CH,Byte;
    if length(rep b) = 1 then {
      el := element(rep b,1);
--stdout<<" in output el is "<<el;
      if lt(el,(convert(127::SInt)@XByte::Byte)) then {
        return(w<<char(el::MI))}}
    w << "value too big to print"
  }

  -- check that the initial len bytes of are 1 followed by a 0
  testbyte1(x:Byte,len:MI):() == {
    lensi:SInt := len::SInt;currBit:SInt := seven-lensi;
    -- first bit must be 0
    xsi := convert(x::XByte)@SInt;
    bit(xsi,currBit)::Boolean => error "first bit has incorrect form";
    while (currBit<eight)::Boolean repeat {
      currBit := currBit+1;
      not(bit(xsi,currBit)::Boolean) => error "first bit is not UTF-8";
    }
    ()
  }

  check(x:SInt):() == {
    (~(bit(x,seven)) \/ bit(x,six))::B => 
      error "first two bytes are not UTF-8";
    ()
  }

  thirty1 := 31::SInt;
  toUCS(x:%):T(BY) == {
    local b2,b1:Byte;
    repx := rep x;
    -- if the tuple has length one and the first bit is 0 then character is 
    -- in range 0-x7F
    len := length(repx);
    if len=1 then {
      e := element(repx,1$MI);
      if not(bit(convert(e::XByte)@SInt,one27)::B) then return repx;
      error "character value is in an invalid range"
    }

    -- check that the initial len bytes are 1 followed by a zero
    testbyte1(element(repx,1$MI),len);

    if len=2 then { -- UTF-8 has 2 bytes

      (e1,e2) := (convert(element(repx,1)::XByte)@SInt,
                  convert(element(repx,2)::XByte)@SInt);
      -- do checks that all non leading bytes start with 10
      check(e2);
      (b2,b1) := (
        convert((e2 /\sixty3) \/ shiftUp(e1,six))@XByte::Byte,
        convert(shiftDown((e1 /\ thirty1),two))@XByte::Byte);
      ret:T(BY) := (b1,b2);return ret

    } else if len=3 then { -- UTF-8 has 3 bytes

      (e1,e2,e3) := (convert(element(repx,1)::XByte)@SInt,
                     convert(element(repx,2)::XByte)@SInt,
                     convert(element(repx,3)::XByte)@SInt);
      -- do checks that all non leading bytes start with "10"
      check(e2);check(e3);
      (b2,b1) := (
        convert((e3 /\ sixty3) \/ shiftUp(e2,six))@XByte::Byte,
        convert(shiftDown((e2 /\ sixty3),two) \/ shiftUp((e1 /\ F),four))@XByte::Byte);
      ret:T(BY) := (b1,b2);return ret;

    } else if len=4 then { -- UTF-8 has 4 bytes

      (e1,e2,e3,e4) := 
        (convert(element(repx,1)::XByte)@SInt,convert(element(repx,2)::XByte)@SInt,convert(element(repx,3)::XByte)@SInt,
          convert(element(repx,4)::XByte)@SInt);
      -- do checks that all non leading bytes start with 10
      check(e2);check(e3);check(e4);
      (b3,b2,b1) := (
        convert((e4 /\ sixty3) \/ shiftUp(e3,six))@XByte::Byte,
        convert(shiftDown(e3 /\ sixty3,two) \/ shiftUp(e2,four))@XByte::Byte,
        convert(shiftDown(e2 /\ sixty3,four) \/ shiftUp(e1 /\ seven,six))@XByte::Byte);
      ret:T(BY) := (b1,b2,b3); return ret

    } else if len=5 then { -- UTF-8 has 5 bytes

      (e1,e2,e3,e4,e5) := (convert(element(repx,1)::XByte)@SInt,convert(element(repx,2)::XByte)@SInt,
        convert(element(repx,3)::XByte)@SInt,convert(element(repx,4)::XByte)@SInt,convert(element(repx,5)::XByte)@SInt);
      -- do checks that all non leading bytes start with 10
      check(e2);check(e3);check(e4);check(e5);
      (b4,b3,b2,b1) := (
        convert((e5 /\ sixty3) \/ shiftUp(e4,six))@XByte::Byte,
        convert(shiftDown(e4 /\ sixty3,two) \/ shiftUp(e3,four))@XByte::Byte,
        convert(shiftDown(e3 /\ sixty3,four) \/ shiftUp(e2,two))@XByte::Byte,
        convert(e1 /\ three)@XByte::Byte);
      ret:T(BY) := (b1,b2,b3,b4); return ret

    } else { -- UTF-8 has 6 bytes

      (e1,e2,e3,e4,e5,e6) := (convert(element(repx,1)::XByte)@SInt,convert(element(repx,2)::XByte)@SInt
         ,convert(element(repx,3)::XByte)@SInt,convert(element(repx,4)::XByte)@SInt,convert(element(repx,5)::XByte)@SInt
         ,convert(element(repx,6)::XByte)@SInt);
      -- do checks that all non leading bytes start with 10
      check(e2);check(e3);check(e4);check(e5);check(e6);
      (b4,b3,b2,b1) := (
        convert((e6 /\ sixty3) \/ shiftUp(e5,six))@XByte::Byte,
        convert(shiftDown(e5 /\ sixty3,two) \/ shiftUp(e4,four))@XByte::Byte,
        convert(shiftDown(e4 /\ sixty3,four) \/ shiftUp(e3,two))@XByte::Byte,
        convert((e2 /\ sixty3) \/ shiftUp(e1 /\ one,six))@XByte::Byte);
      ret:T(BY) := (b1,b2,b3,b4); return ret
    }

    error "The tuple has to many bytes"
  }

  qToUCS(x:%):T(BY) == {
    repx := rep x;
    -- if the tuple has length one and the first bit is 0 then character is 
    -- in range 0-x7F
    len := length(repx);
    if len=1 then {
      return repx;
    }

    if len=2 then { -- UTF-8 has 2 bytes

      (e1,e2) := (convert(element(repx,1)::XByte)@SInt,
                  convert(element(repx,2)::XByte)@SInt);
      (b2,b1) := (
        convert((e2 /\sixty3) \/ shiftUp(e1,six))@XByte::Byte,
        convert(shiftDown((e1 /\ thirty1),two))@XByte::Byte);
      ret:T(BY) := (b1,b2);return ret

    } else if len=3 then { -- UTF-8 has 3 bytes

      (e1,e2,e3) := (convert(element(repx,1)::XByte)@SInt,convert(element(repx,2)::XByte)@SInt
         ,convert(element(repx,3)::XByte)@SInt);
      (b2,b1) := (
        convert((e3 /\ sixty3) \/ shiftUp(e2,six))@XByte::Byte,
        convert(shiftDown((e2 /\ sixty3),two) \/ shiftUp((e1 /\ F),four))@XByte::Byte);
      ret:T(BY) := (b1,b2);return ret;

    } else if len=4 then { -- UTF-8 has 4 bytes

      (e1,e2,e3,e4) := 
        (convert(element(repx,1)::XByte)@SInt,convert(element(repx,2)::XByte)@SInt,convert(element(repx,3)::XByte)@SInt,
          convert(element(repx,4)::XByte)@SInt);
      (b3,b2,b1) := (
        convert((e4 /\ sixty3) \/ shiftUp(e3,six))@XByte::Byte,
        convert(shiftDown(e3 /\ sixty3,two) \/ shiftUp(e2,four))@XByte::Byte,
        convert(shiftDown(e2 /\ sixty3,four) \/ shiftUp(e1 /\ seven,six))@XByte::Byte);
      ret:T(BY) := (b1,b2,b3); return ret

    } else if len=5 then { -- UTF-8 has 5 bytes

      (e1,e2,e3,e4,e5) := (convert(element(repx,1)::XByte)@SInt,convert(element(repx,2)::XByte)@SInt,
        convert(element(repx,3)::XByte)@SInt,convert(element(repx,4)::XByte)@SInt,convert(element(repx,5)::XByte)@SInt);
      (b4,b3,b2,b1) := (
        convert((e5 /\ sixty3) \/ shiftUp(e4,six))@XByte::Byte,
        convert(shiftDown(e4 /\ sixty3,two) \/ shiftUp(e3,four))@XByte::Byte,
        convert(shiftDown(e3 /\ sixty3,four) \/ shiftUp(e2,two))@XByte::Byte,
        convert(e1 /\ three)@XByte::Byte);
      ret:T(BY) := (b1,b2,b3,b4); return ret

    } else { -- UTF-8 has 6 bytes

      (e1,e2,e3,e4,e5,e6) := (convert(element(repx,1)::XByte)@SInt,convert(element(repx,2)::XByte)@SInt
         ,convert(element(repx,3)::XByte)@SInt,convert(element(repx,4)::XByte)@SInt,convert(element(repx,5)::XByte)@SInt
         ,convert(element(repx,6)::XByte)@SInt);
      (b4,b3,b2,b1) := (
        convert((e6 /\ sixty3) \/ shiftUp(e5,six))@XByte::Byte,
        convert(shiftDown(e5 /\ sixty3,two) \/ shiftUp(e4,four))@XByte::Byte,
        convert(shiftDown(e4 /\ sixty3,four) \/ shiftUp(e3,two))@XByte::Byte,
        convert((e2 /\ sixty3) \/ shiftUp(e1 /\ one,six))@XByte::Byte);
      ret:T(BY) := (b1,b2,b3,b4); return ret
    }

    -- if this function is used on correct data, this should never be reached
    never
  }

  toHex(x:%):T(STR) == {
    tBytes:T(BY) := toUCS(x);
    len := length(tBytes);
    -- Note, we can't use an iterative construct here, as Tuples are not 
    -- updateable
    len=1 => (byteToHex(element(tBytes,1)));
    len=2 => (byteToHex(element(tBytes,1)),byteToHex(element(tBytes,2)));
    len=3 => (byteToHex(element(tBytes,1)),byteToHex(element(tBytes,2))
             ,byteToHex(element(tBytes,3)));
    (byteToHex(element(tBytes,1)),byteToHex(element(tBytes,2))
     ,byteToHex(element(tBytes,3)),byteToHex(element(tBytes,4)));
  }

  -- if the character has a value greater than 128, convert to indiv characters
  -- then call another function
  gt128(c:CH):% == {
    error "not done yet"
  }

  fromChar(c:CH):% == {
    o:MI := ord(c);
    if o<128 then per(tup(lowByte(o))) else gt128(c)
  }

  zerob:BY := convert(0::SInt)@XByte::BY;

  toCharLow(x:%):CH == {
    repx:Rep := rep x;
    len := length(repx);
    if len>1 then {
      for i in 2..len for j in 1.. repeat {
        if element(repx,j) ~= zerob then 
          error "the value is to great to be converted to a character"
      }}
    char(element(repx,len)::MI)
  }

  qToCharLow(x:%):CH == {
    char(element(rep x,length(rep x))::MI)
  } 

  (x:%) = (y:%):B == {
    (repx,repy) := (rep x,rep y);
    (lx,ly) := (length repx,length repy);
    lx~=ly => false;
    for i in 1..lx repeat 
      if element(repx,i)~=element(repy,i) then return false;
    true
  }
}

UTF16Char:UniCodeCharacter == add {

  Rep ==> Union(twoBytes:Record(high:Byte,low:Byte),
    fourBytes:Record(highW2:Byte,lowW2:Byte,high:Byte,low:Byte));

  import from Rep,Machine,String;

  coerce(mi:MI):BY == convert(mi::SInt)@XByte::Byte;

  zerob:BY == convert(0::SInt)@XByte::Byte;

  -- we are cheating a bit with these ordering functions, this is to 
  -- get around the problem that 255@Byte < 1@Byte
  lt(x:BY,y:BY):B == {
    (x pretend SInt < y pretend SInt)::B
  }

  gt(x:BY,y:BY):B == lt(y,x);

  (x:%) = (y:%):B == {
    -- unions and records are stored as simply pointers, therefore we must 
    -- deconstruct these objects to the constituant parts in order to test 
    -- equality
    (repx,repy) := (rep x,rep y);
    repx case twoBytes and repy case twoBytes => {
      (repx2,repy2) := (repx.twoBytes,repy.twoBytes);
      repx2.low=repy2.low and repx2.high=repy2.high => true;
      false
    }
    repx case fourBytes and repy case fourBytes => {
      (repx4,repy4) := (repx.fourBytes,repy.fourBytes);
      repx4.low = repy4.low and repx4.high = repy4.high
      and repx4.lowW2 = repy4.lowW2 and repx4.highW2 = repy4.highW2 => true;
      false
    }
    error "not clever enough to do this yet!"
  }

  -- the following constants are defined in order to provide a certain 
  -- (limited) speed up
  zChar:CH == char "0";
  (D8,DC,F) := (216::SInt,220::SInt,15::SInt);
  (two,three,four,six) := (2::SInt,3::SInt,4::SInt,6::SInt);
  local ten,sixteen:BY;
  (ten,sixteen) := (10::BY,16::BY);

  -- these ones are ASCII codes for characters (and code-1)
  local zCdm1,nineCdp1,Acdm1,Fcdp1:MI;
  --(zCdm1,nineCdp1,Acdm1,Fcdp1) := (47,58,64,71);
  zCdm1 := 47;nineCdp1 := 58;Acdm1 := 64;Fcdp1 := 71;

  hex?(ch:CH):B == {
    v:MI := ord ch;
    (v>zCdm1 and v<nineCdp1) or (v>Acdm1 and v<Fcdp1)
  }

  local zCdm1b,zCdb,nineCdp1b,Acdm1b,Acdmtenb,Fcdp1b:BY;
  (zCdm1b,zCdb,nineCdp1b,Acdm1b,Acdmtenb,Fcdp1b) := 
    (47::BY,48::BY,58::BY,64::BY,55::BY,71::BY);

  hex?(v:BY):B == {
    (gt(v,zCdm1b) and gt(nineCdp1b,v)) or (gt(v,Acdm1b) and gt(Fcdp1b,v))
  }

  -- convert a nibble (half a byte) to a character which represents the 
  -- hexadecimal value
  nibbleToHex(n:Byte):CH == {
    lt(n,ten) => char(n::MI+48);
    char(n::MI+55)
  }

  -- convert a byte value to a string which contains the characters 
  -- corresponding to the hexadecimal value
  byteToHex(by:Byte):STR == {
    import from A(CH);
    bysi:SInt := convert(by::XByte)@SInt;
    [nibbleToHex(convert(shiftDown(bysi,four))@XByte::Byte),
            nibbleToHex(convert(bysi /\ F)@XByte::Byte)]
  }

  -- convert a single hex digit (ASCII) to a value between 0 and 15
  hex2byte(b:Byte):Byte == {
    bmi:MI := convert(b::XByte)@SInt::MI;
    if lt(b,nineCdp1b) then convert((bmi-convert(zCdb::XByte)@SInt::MI)::SInt)@XByte::Byte else convert((bmi-convert(Acdmtenb::XByte)@SInt::MI)::SInt)@XByte::Byte
  }

  sixteensi:SInt == 16::SInt;
  hex2byte(h:BY,l:BY):BY == convert(convert(hex2byte(h)::XByte)@SInt*sixteensi
    +convert(hex2byte(l)::XByte)@SInt)@XByte::Byte;

  fromUCSB(high:CH,low:CH):% == {

    local lowb,highb:BY;

    (lowb,highb) := (ord(low)::BY,ord(high)::BY);

    not(hex?(high) and hex?(low)) => 
      error "the arguments must be hexadecimal characters";
    per [[zerob,hex2byte(highb,lowb)]]
  }

  space:% == per [[zerob,ord(char(" "))::Byte]];

  fromUCS2(bHigh:CH,bLow:CH,sHigh:CH,sLow:CH):% == {
    local bLowb,bHighb,sLowb,sHighb:BY;

    (bLowb,bHighb,sLowb,sHighb) := 
      (ord(bLow)::BY,ord(bHigh)::BY,ord(sLow)::BY,ord(sHigh)::BY);
    not(hex?(bHighb) and hex?(bLowb) and hex?(sHighb) and hex?(sLowb)) => 
      error "the arguments must be hexadecimal characters";
    per [[hex2byte(bHighb,bLowb),hex2byte(sHighb,sLowb)]]
  }

  btomi(b:BY):MI == convert(b::XByte)@SInt::MI;
  mitob(mi:MI):BY == convert(mi::SInt)@XByte::Byte;
  sitob(si:SInt):BY == convert(si)@XByte::Byte;
  btosi(b:BY):SInt == convert(b::XByte)@SInt;

  fromUCS4(b2High:CH,b2Low:CH,s2High:CH,s2Low:CH,bHigh:CH,bLow:CH,sHigh:CH,sLow:CH):% == {
    not(hex?(b2High) and hex?(b2Low) and hex?(s2High) and hex?(s2Low)
        and hex?(bHigh) and hex?(bLow) and hex?(sHigh) and hex?(sLow)) => 
      error "the arguments must be hexadecimal characters";

    if b2High=zChar and b2Low=zChar and s2High=zChar and s2Low=zChar then
    -- the entire number represents something less than 0x10000
      return fromUCS2(bHigh,bLow,sHigh,sLow);

    -- put the hexadecimal 2 character strings into bytes

    local highTop,lowTop,highBtm,lowBtm:BY;
    (highTop,lowTop,highBtm,lowBtm) := 
      (hex2byte(ord(b2High)::BY,ord(b2Low)::BY),
       hex2byte(ord(s2High)::BY,ord(s2Low)::BY),
       hex2byte(ord(bHigh)::BY,ord(bLow)::BY),
       hex2byte(ord(sHigh)::BY,ord(sLow)::BY));

    if not(convert(highTop::XByte)@SInt::MI=0) or not(convert(lowTop::XByte)@SInt::MI=1) then 
      error "illegal character encountered";
    -- Uprime := U - 0x10000
    ltm:BY := mitob(btomi(lowTop)-1);
    Uprime:T(BY) := (zerob,ltm,highBtm,lowBtm); -- lowTop must be non-zero and
                                                 -- highTop must be zero
    ltm1:SInt := convert(ltm::XByte)@SInt;
    highBtmSi:SInt := convert(highBtm::XByte)@SInt;
    local w1h,w1l,w2h,w2l:BY;
    w2l := lowBtm;
    w2h := sitob((highBtmSi /\ three) \/ DC);
    w1l := sitob(shiftDown(highBtmSi,two) \/ shiftUp(ltm1 /\ three,six));
    w1h := sitob(shiftDown(ltm1,two) \/ D8);
    per [[w1h,w1l,w2h,w2l]]
  }

  fromGeneric(lCh:L(CH)):% == {
    local highTop,lowTop,highBtm,lowBtm:BY;

    for ch in lCh repeat
      if not hex? ch then 
        error "The argument contains nonhexadecimal characters";
    if #lCh>4 then error "It is illegal to form characters of this size in UTF-16";
    if #lCh=1 then return fromChar(lCh.1)
    else if #lCh=2 then (highTop,lowTop,highBtm,lowBtm) := 
      (zerob,zerob,ord(lCh.3)::Byte,ord(lCh.4)::Byte);
    else if #lCh=3 then (highTop,lowTop,highBtm,lowBtm) :=
      (zerob,ord(lCh.2)::Byte,ord(lCh.3)::Byte,ord(lCh.4)::Byte);
    else (highTop,lowTop,highBtm,lowBtm) := 
      (ord(lCh.1)::Byte,ord(lCh.2)::Byte,ord(lCh.3)::Byte,ord(lCh.4)::Byte);

    if not(convert(highTop::XByte)@SInt::MI=0) or not(convert(lowTop::XByte)@SInt::MI=1) then 
      error "illegal character encountered";
    -- Uprime := U - 0x10000
    Uprime:T(BY) := (zerob,mitob(btomi(lowTop)-1),highBtm,lowBtm); -- lowTop must be non-zero and
                                                 -- highTop must be zero
    ltm1:SInt := btosi(lowTop)-1;
    highBtmSi:SInt := btosi(highBtm);
    local w1h,w1l,w2h,w2l:BY;
    w2l := lowBtm;
    w2h := sitob((highBtmSi /\ three) \/ DC);
    w1l := sitob(shiftDown(highBtmSi,two) \/ shiftUp(ltm1 /\ three,six));
    w1h := sitob(shiftDown(ltm1,two) \/ D8);
    per [[w1h,w1l,w2h,w2l]]
  }

  fromChar(ch:CH):% == {
    v := ord(ch);
    if v > 127 then error "illegal value given";
    per [[zerob,v::Byte]]
  }

  (w: TextWriter) << (b: %): TextWriter == {
    brep := rep b;
    brep case twoBytes => {
      if not(convert(brep.twoBytes.high::XByte)@SInt::MI=0) then w<<"?"
        else w<<char(brep.twoBytes.low::MI)
    }
    brep2 := brep.fourBytes;
    if not(convert(brep2.highW2::XByte)@SInt::MI=0 and convert(brep2.high::XByte)@SInt::MI=0 and convert(brep2.lowW2::XByte)@SInt::MI=0) then w<<"?"
    else w<<char(brep2.low::MI)
  }

  local eight0,D8b,DB,DCb,DF,FF:Byte;
  (eight0,D8b,DB,DCb,DF,FF) := 
    (128::BY,216::BY,219::BY,220::BY,222::BY,255::BY);

  toUCS(x:%):T(BY) == {
    local w2h,w2l,w1h,w1l:BY;
    xrep:Rep := rep(x);
    xrep case twoBytes => {xby := xrep.twoBytes;(xby.high,xby.low)}
    xrep2 := xrep.fourBytes;
    (w2h,w2l,w1h,w1l) := (xrep2.highW2,xrep2.lowW2,xrep2.high,xrep2.low);
    -- see if w1 is between D800 and DBFF
    if (gt(w1l,zerob) and gt(w1h,D8b) or gt(w1h,D8b)) and (lt(w1l,FF) and w1h=DB or lt(w1h,DB)) then
      error "illegal character";
    -- see if w2 is between DC00 and DFFF
    if (gt(w2l,zerob) and gt(w1h,DCb) or gt(w2h,DCb)) and (lt(w2l,FF) and w2h=DF or lt(w1h,DF)) then
      error "illegal character";
    local ret1,ret2,ret3:BY; -- ret1 is the least significant
    local w1hsi,w2lsi,w2hsi:SInt;
    (w1hsi,w2lsi,w2hsi) := (btosi(w1h),btosi(w2l),btosi(w2h));
    ret1 := w1l;ret2 := sitob((w1hsi /\ three) \/ shiftUp(w2lsi,two));
    ret3 := sitob(shiftDown(w2lsi,six) \/ (shiftUp(w2hsi /\ DC,two)));
    (ret1,ret2,ret3)
  }

  toHex(x:%):T(STR) == {
    xrep:Rep := rep(x);
    tupBytes:T(BY) := toUCS(x);
    if xrep case twoBytes then 
      (byteToHex(element(tupBytes,1)),byteToHex(element(tupBytes,2)));
    (byteToHex(element(tupBytes,1)),byteToHex(element(tupBytes,2)),
     byteToHex(element(tupBytes,3)))
  }

  toCharLow(x:%):CH == {
    xrep:Rep := rep(x);
    xrep case twoBytes => {
      xby := xrep.twoBytes;
      if convert(xby.high::XByte)@SInt::MI = 0 then {
        xbyl := xby.low;
        if lt(xbyl,eight0) then char(xbyl::MI)
        else error "illegal character (1)"
      }
      else 
        error "this character may not be represented in this character set (1)"
    }
    xby2 := xrep.fourBytes;
    if xby2.highW2=zerob and xby2.lowW2=zerob and xby2.high=zerob then {
      xbyl := xby.low;
      if lt(xbyl,eight0) then return char(xbyl::MI)
      else error "illegal character (2)"
    }
    error "this character may not be represented in this character set (2)"
  }

--  sample:% == space;
}

UTF32Char:UniCodeCharacter == add {

  space:% == error "not done yet";

  fromUCSB(high:CH,low:CH):% == {
    error "not done yet"
  }

  fromUCS2(bHigh:CH,bLow:CH,shigh:CH,sLow:CH):% == {
    error "not done yet"
  }

  fromUCS4(b2High:CH,b2Low:CH,s2High:CH,s2Low:CH,bHigh:CH,bLow:CH,sHigh:CH,sLow:CH):% == {
    error "not done yet"
  }

  fromChar(ch:CH):% == {
    error "not done yet"
  }

  (w: TextWriter) << (b: %): TextWriter == {
    w<<"not done yet"
  }

  toUCS(x:%):T(BY) == {
    error "not done yet"
  }

  toHex(x:%):T(STR) == {
    error "not done yet"
  }

  toCharLow(x:%):CH == {
    error "not done yet"
  }

--  sample:% == error "not done yet";

  (x:%) = (y:%):B == {
    error "not done yet"
  }
}
