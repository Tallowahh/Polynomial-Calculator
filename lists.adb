with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.unbounded; use Ada.Strings.unbounded;
with Ada.Strings.unbounded.text_io; use Ada.Strings.unbounded.text_io;

procedure lists is
type node;
type list is access node;

type node is record
    coefficient: integer;
    next: list;
end record;

procedure buildList(head: in out list; coeff: in integer) is
    newNode: list;
begin
    newNode := new node'(coefficient=>coeff, next=>null);
    newNode.next := head;
    head := newNode;
end buildList;

procedure printList(head: in list) is
    scanPtr: list;
begin
    scanPtr := head;
    loop
        exit when scanPtr = null;
        put(scanPtr.coefficient);
        scanPtr := scanPtr.next;
        put(" ");
    end loop;
end printList;

begin
    loop
        put("> ");
        get_line(coeff);
        exit when coeff = 2;
        buildList(head, coeff);
    end loop;

    put_line("The List as Read: ");
    printList(head);
    new_line;

end lists;