with Ada.Text_IO; use Ada.Text_IO;

with DataItems; use DataItems;

with ViewState; use ViewState;

with ViewContent; use ViewContent;

procedure SwiftUI_VM_Lab is

   Item         : Object;
   Data_in_View : Data_of_State;

   -------
   -- init
   -------
   procedure init is
      Data_in_View : Data_of_State;
      Items        : Objects :=
        (others =>
           (Description => Strings_150.Null_Bounded_Wide_Wide_String,
            completed   => False));
      Item : Object;

   begin
      Data_in_View.Data.Max_Index := 1;
      for i in 1 .. 3 loop
         Put ('#');
         Item :=
           (Description =>
              Strings_150.To_Bounded_Wide_Wide_String
                (Source => ("Task " & i'Wide_Wide_Image)),
            completed => True);
         Items (i)                   := Item;
         Data_in_View.Data.Max_Index := Max (Data_in_View.Data.Max_Index, i);
      end loop;
      New_Line;
      Data_in_View.Data.List := Items;
      -- ---------------------------
      State.init (Data_in_View);
      -- ---------------------------

   end init;

   --------------
   -- Main_Thread
   --------------
   task Main_Thread is
   end Main_Thread;

   task body Main_Thread is
   begin
      Put_Line ("Starting main Thread ...");
      init;
      myBody.show;
--    delay 1.0;

      for i in 6 .. 8 loop
         delay 0.3;
         Put_Line ('+' & i'Image);
         Item :=
           (Description =>
              Strings_150.To_Bounded_Wide_Wide_String
                (Source => ("Task " & i'Wide_Wide_Image)),
            completed => True);
         -- -----------------------
         Data_in_View := State.read;
         -- -----------------------
         -- use Data_in_View.Data;
         Data_in_View.Data.Max_Index := Max (i, Data_in_View.Data.Max_Index);
         Data_in_View.Data.List (Data_in_View.Data.Max_Index) := Item;

         Put_Line ('=' & i'Image);
         -- ------------------------
         State.update (Data_in_View);
         -- ------------------------
         Put_Line ('!' & i'Image);

      end loop;

      New_Line;

   end Main_Thread;

begin
   Put_Line ("Starting main ...");

   delay 1.0;
   myBody.close;

end SwiftUI_VM_Lab;
