with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.unbounded; use Ada.Strings.unbounded;

package polyLink is
    type node;
    type list is access node;
    type node is record
            coefficient: integer;
            exponent: integer;
            nextpoly: integer;
            next: list;
    end record;
    procedure readPoly;
    procedure writePoly(head: list);
    procedure buildList(head: in out list; acoefficient: in integer; anexponent: in integer; anextpoly: in integer);
    procedure clear;
    procedure evalpoly(x: integer);
    procedure currentLists;
end polyLink;