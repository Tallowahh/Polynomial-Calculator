with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.unbounded; use Ada.Strings.unbounded;
with Ada.Strings.unbounded.text_io; use Ada.Strings.unbounded.text_io;
with polymath; use polymath;

package body polyLink is
        polya: list;
        polyb: list;
        heada: list;
        headb: list;

    procedure buildList(head: in out list; acoefficient: in integer; anexponent: in integer; anextpoly: in integer) is
        newNode: list;
    begin
        newNode := new node'(coefficient=>acoefficient, exponent=>anexponent, nextpoly=>anextpoly, next=>null);
        newNode.next := head;
        head := newNode;
    end buildList;

    procedure clear is
    begin
        polya := null;
        polyb := null;
    end clear;

    procedure currentLists is
    begin
        if (polya = null) then
            put_line("Polynomial 1 is Empty");
        else
        writePoly(polya);
        new_line;
        end if;

        if (polyb = null) then
            put_line("Polynomial 2 is Empty");
        else 
        writePoly(polyb);
        end if;
    end currentLists;

    procedure exponent(e: in out integer; exponent: integer) is -- Exponent Function
    bound: integer;
    begin
    bound := e;
        if (exponent = 1) then
            e := e * 1;
        else
            for i in 1..bound loop
            if (i = 1) then
                e := e * 1;
            else
                e := e * e;
            end if;
            end loop;
        end if;
    end exponent;

    procedure evalpoly(x: integer) is -- Function to evaluate based on a value.
    evalList: list;
    result: integer;
    number: integer;
    bound: integer;
    begin
    result := 0;
    evalList := polya;
        if (evalList /= null) then
            loop
                number := x;
                    if (evalList.exponent > 0) then -- Calculation of an exponent
                        bound := evalList.exponent;
                    if (evalList.exponent = 1) then -- Special case of the exponent being 1
                        number := number * 1;
                    else
                        if (evalList.exponent = 1) then
                            number := number * 1;
                        else
                            for i in 1..bound loop
                            if (i = 1) then
                                number := x * 1;
                            else
                                number := number * x;
                            end if;
                            end loop;
                        end if;
                    end if;
                    number := number * evalList.coefficient;
                    result := result + number;
                else 
                    result := result + evalList.coefficient;
                end if;
                evalList := evalList.next;
                exit when evalList = null;
            end loop;
            writePoly(polya);
            put(" = ");
            put(result, width => 0);
            new_line;
            if (result = 0) then
                polya := null;
            end if;
        else
            put_line("Nothing to Evaluate");
        end if;
    end evalpoly;
    
    procedure readPoly is 
        astring: integer;
        acoefficient: integer;
        anextpoly: unbounded_string;
        highexponent: integer;
        monomials: integer;
        userinput: unbounded_string;
        exponent: integer;
        op: unbounded_string;
        i: integer;
        j: integer;
        verify: integer;
        skips: integer;
        begin
        heada := polya;
        i := 1;
        j := 1;
        verify := 1;
        skips := 1;
        new_line;
        loop
            exit when verify = 2;
            put("Enter the desired operation between the two Polynomials: ");
            get_line(op);
            if (op = "Multiply" or op = "Subtract" or op = "Addition") then
                verify := 2;
            else 
                put("Please select an option from the Menu provided above.");
                new_line;
            end if;
        end loop;
        verify := 1;
        if (polya = null) then
            put("Enter the number of monomials (First Polynomial): ");
            get(monomials);
            put("Enter the highest exponent: ");
            get(highexponent);
            skip_line;
            astring := 1;
            for i in 1..2 loop
                exponent := highexponent;
                for j in 1..monomials loop 
                skips := 1;
                    if (j < monomials + 1) then -- Logic for reducing the exponent with every prompt
                        put("--To Skip Exponent^");
                        put(exponent, width => 0);
                        put(", enter ""Skip"": ");
                        get_line(userinput);
                        if (userinput = "Skip") then
                                skips := skips - 1;
                            if (exponent - 1 >= 0) then
                                exponent := exponent - 1; 
                            end if;
                        end if;
                    end if;
                            put("Enter Coefficient^");
                            put(exponent, width => 0);
                            put(": ");
                            get(acoefficient);
                            skip_line;
                        if (astring = 1) then
                            buildList(polya, acoefficient, exponent, monomials);                    
                        else if (astring = 2) then
                            buildList(polyb, acoefficient, exponent, monomials);
                        end if;
                        end if;
                        if (exponent - 1 >= 0) then
                            exponent := exponent - 1;
                        end if;
                    end loop;
                    astring := 2;
                    if (i /= 2) then
                        new_line;
                        put("Enter the number of monomials (Second Polynomial): ");
                        get(monomials);
                        put("Enter the highest exponent: ");
                        get(highexponent);
                        skip_line;
                        new_line;
                    end if;
            end loop;
        
        else 
            put("Enter the highest exponent (Second Polynomial): "); --Special case of if the first polynomial is full
            polyb := null;
            get(highexponent);
            exponent := highexponent;
            for j in 0..highexponent loop   
                if (j < highexponent and exponent /= 0) then
                    put("To Skip Exponent^");
                    put(exponent, width => 0);
                    put(", Enter Skip: ");
                    skip_line;
                    get_line(userinput);
                    if (userinput = "Skip") then
                        if (exponent - 1 >= 0) then
                            exponent := exponent - 1;   
                        end if;
                    end if;
                end if;
                put("Enter Coefficient");
                if (exponent > 0) then
                    put("x");
                    if (exponent /= 1) then
                    put("^");
                    end if;
                end if;                
                put(exponent, width => 0);
                put(": ");
                get(acoefficient);
                    buildList(polyb, acoefficient, exponent, highexponent + 1);
                if (exponent - 1 >= 0) then
                    exponent := exponent - 1;
                end if;
            end loop;
        end if;

        new_line;
        if (op = "Multiply") then -- Arithmetic checking to indicate which function should be used
            put_line("Multiplication Selected.");
            multpoly(polya,polyb);
        else if (op = "Subtract") then
            put_line("Subtraction Selected.");
            subpoly(polya,polyb);
        else if (op = "Addition") then
            put_line("Addition Selected");
            addpoly(polya,polyb);
        end if;
        end if;
        end if;
        headb := polyb;
        put("Solution is: ");
        writePoly(polya);
    end readPoly;

    procedure writePoly(head: in list) is -- Output formatting based on the polynomial.
        scanPtr: list;
        count: integer;
        begin 
        count := 1;
            scanPtr := head;
            loop
                exit when scanPtr = null;
                if (scanPtr.coefficient /= 1) then
                    if (scanPtr.coefficient < 0) then
                        put (abs scanPtr.coefficient, width => 0);
                    else
                        if (scanPtr.coefficient /= 0) then
                            put(scanPtr.coefficient, width => 0);
                        end if;
                    end if;
                end if;
                if (scanPtr.exponent > 0) then
                    put("x");
                    if (scanPtr.exponent > 1) then
                        put("^");
                        put(scanPtr.exponent, width => 0);
                    end if;
                end if;
                    if (scanPtr.next /= null) then
                        if (scanPtr.next.coefficient /= 0) then
                            put(" - ");
                        else
                            put(" + ");
                        end if;
                        count := count + 1;
                    end if;          
                scanPtr := scanPtr.next;
            end loop;
    end writePoly;
end polyLink;