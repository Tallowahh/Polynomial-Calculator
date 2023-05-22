with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.unbounded; use Ada.Strings.unbounded;
with polyLink; use polyLink;

package body polymath is
tempSum: list;
thead: list;
type vector is array (integer range <>) of integer;

procedure addpoly(polya: in out list; polyb: in out list) is
scanPtr: list;
scanPtrb: list;
coefficientsadd: vector(1..polya.nextpoly + polyb.nextpoly); --Components of Linear Algebraic Format
exponentsadd: vector(1..polya.nextpoly + polyb.nextpoly); --Components of Linear Algebraic Format
check: vector(1..polya.nextpoly + polyb.nextpoly); --Components of Linear Algebraic Format
check2: vector(1..polya.nextpoly + polyb.nextpoly); --Components of Linear Algebraic Format
sum: vector(1..polya.nextpoly + polyb.nextpoly); --Components of Linear Algebraic Format
i: integer;
j: integer;
polyacount: integer;
begin
scanPtr := polya;
scanPtrb := polyb;
i := 1;
j := 1;
polyacount := 0;
for i in 1..polya.nextpoly + polyb.nextpoly loop --Setting the checks for both Lists for parsing
    check(i) := 0;
    check2(i) := 0;
end loop;
loop -- Loop to load the first list
    exit when scanPtr = null;
    coefficientsadd(i) := scanPtr.coefficient;
    exponentsadd(i) := scanPtr.exponent;
    i := i + 1;
    scanPtr := scanPtr.next;
end loop;
loop -- Loop to load the second List
exit when scanPtrb = null;
        coefficientsadd(i) := scanPtrb.coefficient; 
        exponentsadd(i) := scanPtrb.exponent;
        i := i + 1; 
        scanPtrb := scanPtrb.next;    
end loop;   
    for i in 1..polya.nextpoly + polyb.nextpoly loop --Nested Loop for loading an array to format in a Linear Algebraic format
        sum(i) := coefficientsadd(i);
        for j in i..polya.nextpoly + polyb.nextpoly loop 
            if (i /= j) then   
                if (exponentsadd(i) = exponentsadd(j)) then -- Handles the general case of an exponent having a pairing
                    polyacount := polyacount + 1;
                    sum(i) := sum(i) + coefficientsadd(j);
                    buildList(tempSum, sum(i), exponentsadd(i), 1);
                    check(i) := 1;
                    check2(j) := 1;
                end if;
            end if;
        end loop;
        if (check(i) /= 1 and check2(i) /= 1) then --Handles the unique case of single exponents without a found pairing
            polyacount := polyacount + 1;
            buildList(tempSum, sum(i), exponentsadd(i), 1);
        end if;
    end loop;
    thead := tempSum;
    loop
        exit when tempSum = null;
        tempSum.nextpoly := polyacount;
        tempSum := tempSum.next;
    end loop;
    tempSum := thead;
    polya := tempSum;
    tempSum := null;
    polyb := null;
end addpoly;

procedure subpoly(polya: in out list; polyb: in out list) is -- Inverts all the values within the second polynomial
invertedb: list;
begin
invertedb := polyb;
    loop
        exit when invertedb = null; 
        invertedb.coefficient := invertedb.coefficient * (-1);
        invertedb := invertedb.next;
    end loop;
    addpoly(polya, polyb);
    polyb := null;
    invertedb := null;
end subpoly;

procedure multpoly(polya: in out list; polyb: in out list) is
scanPtr: list;
scanPtrb: list;
scanPtrt: list;
current: list;
tempSum: list;
product: integer;
total: integer;
exporesult: integer;
i: integer;
j: integer;
coefficients: vector(1..polya.nextpoly * polyb.nextpoly);
exponents: vector(1..polya.nextpoly * polyb.nextpoly);
check: vector(1..polya.nextpoly * polyb.nextpoly);
check2: vector(1..polya.nextpoly * polyb.nextpoly);
begin
scanPtr := polya;
scanPtrb := polyb;
i := 1;
j := 1;
    loop
        exit when scanPtr = null;
        loop
        exit when scanPtrb = null;
            if (scanPtr /= null) then
                if (scanPtrb /= null) then -- Multiplication arithmetic and array loading in a Linear Algebraic format
                    product := scanPtr.coefficient * scanPtrb.coefficient;
                    exporesult := scanPtr.exponent + scanPtrb.exponent;
                    coefficients(i) := product;
                    exponents(i) := exporesult;
                    buildList(tempSum, product, exporesult, 1);
                    i := i + 1;
                end if;
            end if;
            scanPtrb := scanPtrb.next;
            end loop;
            scanPtrb := polyb;
            scanPtr := scanPtr.next;
    end loop;
    
    scanPtrt := tempSum;
    current := scanPtrt.next;
    i := 1;
    tempSum := null;

    for i in 1..polya.nextpoly * polyb.nextpoly loop
        total := coefficients(i);
        for j in i..polya.nextpoly * polyb.nextpoly loop
            if (exponents(i) = exponents(j) and i /= j) then
                total := total + coefficients(j);
                check(i) := 1;
                check2(j) := 1;
            buildList(tempSum, total, exponents(i), 2);      
        end if;
    end loop;
        if (check(i) /= 1 and check2(i) /= 1) then
            buildList(tempSum, coefficients(i), exponents(i), 2);      
        end if;
    end loop;

    polya := null;

    loop
        exit when scanPtrt = null;
        loop
            product := scanPtrt.coefficient;
        exit when current = null;
        if (scanPtrt.next /= null) then
            if (current /= null) then
                if (scanPtrt.exponent = current.exponent) then
                    product := product + current.coefficient;
                    scanPtrt.coefficient := product;
                    scanPtrt.nextpoly := 3;
                    current.nextpoly := 3;
                end if;
            else 
                buildList(polya, product, scanPtrt.exponent, 2);      
            end if;      
        end if;
        current := current.next;
        end loop;
        scanPtrt := scanPtrt.next;
    end loop;

    polya := tempSum;
    new_line;
    scanPtrb := null;
    polyb := null;
end multpoly;
end polymath;