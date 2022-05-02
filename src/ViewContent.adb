-- ---------------------------------------------------------------------------
-- SPDXVersion: SPDX-2.2
-- SPDX-FileType: SOURCE
-- SPDX-LicenseConcluded:  BSD-3-Clause
-- SPDX-LicenseInfoInFile: BSD-3-Clause
-- SPDX-FileCopyrightText: Copyright 2022 William J. Franck (william.franck@sterna.io)
-- SPDX-Creator: William J. Franck (william.franck@sterna.io)
-- ---------------------------------------------------------------------------

with DataItems; use DataItems;

with AdaUI_Lab_IO; use AdaUI_Lab_IO;

with Ada.Characters.Latin_1; use Ada.Characters;
with Ada.Text_IO;            use Ada.Text_IO;

package body ViewContent is

   -------
   -- show
   -------
   procedure show (Data_in_View : Data_of_State) is

      Items : Objects;
      Item  : Object;

      -- Item_id : Identifier;

   begin

      Items := Data_in_View.Data.List;

      for Item_id in 1 .. Data_in_View.Data.Max_Index loop
         Item := Items (Item_id);

         put (CONSOLE, Item_id'Image);
         put (CONSOLE, "-");
         put (CONSOLE, Item.completed'Image);
         -- put_line (CONSOLE,Item.Description);
         put (CONSOLE, "   ");

      end loop;
      new_line (CONSOLE);
   end show;

   --------------
   -- update_View
   --------------
   procedure update_View is
   begin
      trace_Line (DEBUG, "Receiving callback ...");
      -- MARK: Do activate the state changes to be done on the View --
      myBody.update;
      -- -------------------------------------------------------------
      trace_Line (DEBUG, "End of callback ...");
   end update_View;

   -- =========
   -- task View
   -- =========
   task body View is
      Active                  : Boolean := False;
      Actual_Data             : Data_of_State;
      mycallback_for_updating : callback_proc;

   begin
      trace_Line (INFO, "Creating View ...");
      accept Init do

         -- ---------------------------
         Actual_Data := State.read;
         -- ---------------------------
         show (Data_in_View => Actual_Data);
         trace_Line (INFO, "View initialized !");

         mycallback_for_updating := update_View'Access;
         -- MARK: Register this View as to be called back upon a data update --
         State.register (View_to_update => mycallback_for_updating);
         -- -------------------------------------------------------------------
      end Init;

      Active := True;
      trace_Line (DEBUG, "Loop !");
      loop
         select 
            when Active and not Actual_Data.Data.User_Quit =>
            accept update do
               trace_Line (INFO, "**** Updating State of View ****");
            end update;
            -- MARK: Get the new/updated data (state change) -----------------
            Actual_Data := State.read;
            if not Actual_Data.Data.User_Quit then
                -- MARK: Apply the state change, i.e show the new/updated data) --
                show (Data_in_View => Actual_Data);
                -- ---------------------------------------------------------------
                trace_Line (DEBUG, "**** View Updated ****");
            else 
               trace_Line (INFO, "Closing View ...");
               Active := False;
                exit;
            end if;
         or
            when Actual_Data.Data.User_Quit =>
            accept update do
               trace_Line (INFO, "Closing View ...");
               Active := False;
            end update;
            exit;
        or
            accept close do
               trace_Line (INFO, "Closing View ...");
               -- Quit   := True;
               Active := False;
            end close;
            exit;
            -- or
            -- delay 1.0;
         end select;
      end loop;
      trace_Line (INFO, "View closed and deallocated !!");
   end View;

end ViewContent;
