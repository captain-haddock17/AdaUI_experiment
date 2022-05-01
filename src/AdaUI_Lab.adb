-- ---------------------------------------------------------------------------
-- SPDXVersion: SPDX-2.2 
-- SPDX-FileType: SOURCE
-- SPDX-LicenseConcluded:  BSD-3-Clause
-- SPDX-LicenseInfoInFile: BSD-3-Clause
-- SPDX-FileCopyrightText: Copyright 2020 William J. Franck (william.franck@sterna.io)
-- SPDX-Creator: William J. Franck (william.franck@sterna.io)
-- ---------------------------------------------------------------------------
--
--  @summary Main 'Client' program to illustrate the View-Model pattern of AdaUI.
--
--  @description The 'Client' sends the data to be viewed by the 'View' through the 'State' protected object.
--
-- ---------------------------------------------------------------------------

with DataItems; use DataItems;
with ViewState; use ViewState;
with ViewContent; use ViewContent;

with Ada.Text_IO; use Ada.Text_IO;
with AdaUI_Lab_IO; use AdaUI_Lab_IO;

procedure AdaUI_Lab is

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
         trace (DEBUG, '#');
         Item :=
           (Description =>
              Strings_150.To_Bounded_Wide_Wide_String
                (Source => ("Task " & i'Wide_Wide_Image)),
            completed => True);
         Items (i)                   := Item;
         Data_in_View.Data.Max_Index := Max (Data_in_View.Data.Max_Index, i);
      end loop;
      trace(DEBUG, "");
      Data_in_View.Data.List := Items;
      -- MARK: Send data to the View by initializing its state --
      State.init (Data_in_View);
      -- --------------------------------------------------------

   end init;

   --------------
   -- Main_Thread
   --------------
   task Main_Thread is
   end Main_Thread;

   task body Main_Thread is
   begin
      trace_Line (INFO, "Starting main Thread ...");
      init;
      myBody.init;
--    delay 1.0;

      for i in 6 .. 8 loop
         delay 0.3;
         trace (DEBUG, '+' & i'Image);
         Item :=
           (Description =>
              Strings_150.To_Bounded_Wide_Wide_String
                (Source => ("Task " & i'Wide_Wide_Image)),
            completed => True);
         -- MARK: Get the data of the View before modifying it --
         Data_in_View := State.read;
         -- -----------------------------------------------------
         -- use Data_in_View.Data;
         Data_in_View.Data.Max_Index := Max (i, Data_in_View.Data.Max_Index);
         Data_in_View.Data.List (Data_in_View.Data.Max_Index) := Item;

         trace (DEBUG, '=' & i'Image);
         -- MARK: Send data to the View by changing its state --
         State.update (Data_in_View);
         -- ----------------------------------------------------
         trace (DEBUG, '!' & i'Image);

      end loop;

      trace_Line(DEBUG, "");

   end Main_Thread;

begin
   trace_Line (INFO, "Starting main ...");

   delay 1.0;
   -- MARK: Send a call to the View as to terminate his thread --
   myBody.close;
   -- -----------------------------------------------------------

end AdaUI_Lab;
