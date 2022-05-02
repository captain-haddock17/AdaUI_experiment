-- ---------------------------------------------------------------------------
-- SPDXVersion: SPDX-2.2
-- SPDX-FileType: SOURCE
-- SPDX-LicenseConcluded:  BSD-3-Clause
-- SPDX-LicenseInfoInFile: BSD-3-Clause
-- SPDX-FileCopyrightText: Copyright 2022 William J. Franck (william.franck@sterna.io)
-- SPDX-Creator: William J. Franck (william.franck@sterna.io)
-- ---------------------------------------------------------------------------
--
--  @summary Main 'Client' program to illustrate the View-Model pattern of AdaUI.
--
--  @description The 'Client' sends the data to be viewed by the 'View' through the 'State' protected object.
--
-- ---------------------------------------------------------------------------

with DataItems;   use DataItems;
with ViewState;   use ViewState;
with ViewContent; use ViewContent;

with Ada.Text_IO;  use Ada.Text_IO;
with AdaUI_Lab_IO; use AdaUI_Lab_IO;

procedure AdaUI_Lab is

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
      trace (DEBUG, "");
      Data_in_View.Data.List := Items;
      -- MARK: Send data to the View by initializing its state --
      State.init (Data_in_View);
      -- --------------------------------------------------------

   end init;

   -- -----------------
   -- DataSource_Thread
   -- -----------------
   task DataSource_Thread is
   end DataSource_Thread;

   task body DataSource_Thread is

      Item          : Object;
      State_in_View : Data_of_State;

   begin
      trace_Line (INFO, "Starting DataSource Thread ...");
      init;
      myBody.init;
      -- delay 1.0;

      for i in 6 .. 8 loop
         delay 1.3;
         trace (DEBUG, '+' & i'Image);
         Item :=
           (Description =>
              Strings_150.To_Bounded_Wide_Wide_String
                (Source => ("Task " & i'Wide_Wide_Image)),
            completed => True);
         -- MARK: Get the data of the View before modifying it --
         State_in_View := State.read;
         -- -----------------------------------------------------
         -- use Data_in_View.Data;
         State_in_View.Data.Max_Index := Max (i, State_in_View.Data.Max_Index);
         State_in_View.Data.List (State_in_View.Data.Max_Index) := Item;

         trace (DEBUG, '=' & i'Image);
         -- MARK: Send data to the View by changing its state --
         State.update (State_in_View);
         -- ----------------------------------------------------
         trace (DEBUG, '!' & i'Image);

      end loop;

      trace_Line (DEBUG, "");

   end DataSource_Thread;

   -- -----------------
   -- UserInput_Thread
   -- -----------------
   task UserInput_Thread is
   end UserInput_Thread;

   task body UserInput_Thread is
      State_in_View : Data_of_State;
      Item          : Object;

   begin
      trace_Line (INFO, "Starting UserInput Thread ...");

      loop
         select
            State.quit;
            exit;
          then abort  
            State.updated;
            -- MARK: Get the data of the View before modifying it --
            State_in_View := State.read;
            -- -----------------------------------------------------
            if State_in_View.Data.Max_Index > 0 and
              not State_in_View.Data.User_Acknowledged
            then
               trace_Line (INFO, ">>> User reads the data displayed ...");
               delay 0.7; -- User reading ...
               State_in_View.Data.User_Acknowledged := True;
               -- MARK: Send data to the View by changing its state --
               State.update (State_in_View);
               -- ----------------------------------------------------
            end if;
         end select;
       end loop;
   end UserInput_Thread;

-- ==================================================
-- MAIN
-- ==================================================
   Item         : Object;
   Data_in_View : Data_of_State;

begin
   trace_Line (INFO, "Starting main ...");

   delay 5.0;
   trace_Line (INFO, "User asked for quit ...");
   -- MARK: Get the data of the View before modifying it --
   Data_in_View := State.read;
   -- -----------------------------------------------------
   -- MARK: Modify the state of the View
   Data_in_View.Data.User_Quit := True;
   -- -----------------------------------------------------------
   -- MARK: Send data to the View by changing its state --
   State.update (Data_in_View);
   -- ---------------------------------
   -- MARK: Send Close to View --
   -- myBody.close;
   -- ----------------------------------------------------

   loop
      select
         -- MARK: wait for user quit View --
         State.quit;
         -- ---------------------------------
         trace_Line (INFO, "User asked for quit ...");
         else
            delay 0.3;
      end select;
      -- MARK: Send Close to View --
      myBody.close;
    end loop;

end AdaUI_Lab;
