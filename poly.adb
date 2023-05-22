with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.unbounded; use Ada.Strings.unbounded;
with Ada.Strings.unbounded.text_io; use Ada.Strings.unbounded.text_io;
with polyLink; use polyLink;
with polymath; use polymath;
procedure poly is

procedure printSelection is -- Main User Interface prompt
begin
   put_line("POLYNOMIAL Arithmetic");
   put_line("1. Compute Arithmetic");
   put_line("2. Show Current Lists");
   put_line("3. Clear History");
   put_line("4. Evaluate");
   put_line("5. Exit");
   put("Enter your Choice: ");
end printSelection;

userchoice: unbounded_string;
anextpoly: unbounded_string;
coefficients: unbounded_string;
i: integer;
j: integer;
evalchoice: integer;
begin
i := 1;
j := 1;
   loop 
      exit when userchoice = "5";
      printSelection;
      get_line(userchoice);
      new_line;
      if (userchoice = "1") then -- User Interface to interact with
         put_line("-----------------Menu-----------------");
         put_line("Addition Keyword:           ""Addition""");
         put_line("Subtraction Keyword:        ""Subtract""");
         put_line("Multiplication Keyword:     ""Multiply""");
         put_line("Selections are Case-Sensitive.");
         readPoly;
         new_line;
      else if (userchoice = "2") then
         currentLists;
         new_line;
      else if (userchoice = "3") then
         clear;
         put_line("History Cleared.");
      else if (userchoice = "4") then
         put("Enter the value you would like to evaluate for: ");
         get(evalchoice);
         skip_line;
         evalpoly(evalchoice);
      else if (userchoice = "5") then
         put_line("Program Exited.");
      else
         put_line("Selection out of Bounds");
      end if;
      end if;
      end if;
      end if;
      end if;
      put("----------------------------------------"); 
      new_line;     
   end loop;
end poly;