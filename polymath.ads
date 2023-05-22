with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with polyLink; use polyLink;

package polymath is

procedure addpoly(polya: in out list; polyb: in out list);
procedure subpoly(polya: in out list; polyb: in out list);
procedure multpoly(polya: in out list; polyb: in out list);
end polymath;