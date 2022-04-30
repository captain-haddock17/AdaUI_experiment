with DataItems; use DataItems;

with Ada.Characters.Latin_1;
use  Ada.Characters;

with Ada.Text_IO; use Ada.Text_IO;

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

         put (Item_id'Image);
         put ("-");
         put (Item.completed'Image);
         -- put_line (Item.Description);
         put ("   ");

      end loop;
         New_Line;
   end show;

   --------------
   -- update_View
   --------------
   procedure update_View is
   begin
      Put_Line ("Receiving callback ...");
      myBody.update;
      Put_Line ("End of callback ...");
   end update_View;

   -- =========
   -- task View
   -- =========
   task body View is
      Active                  : Boolean := False;
      Actual_Data             : Data_of_State;
      mycallback_for_updating : callback_proc;

   begin
      put_line ("Creating View ...");
      accept show do

      -- ---------------------------
      Actual_Data := State.read;
      -- ---------------------------
      show (Data_in_View => Actual_Data);
      put_line ("View initialized !");

      mycallback_for_updating := update_View'Access;
      -- --------------------------------------------------
      State.register (View_to_update => mycallback_for_updating);
      -- --------------------------------------------------
      end show;

      Active := True;
      put_line ("Loop !");
      loop
         select when Active =>
            accept update do
               put_line ("**** Updating View ****");
            end update;
            -- ---------------------------
            Actual_Data := State.read;
            -- ---------------------------
            show (Data_in_View => Actual_Data);
            put_line ("**** View Updated ****");
         or
            accept close do
               put_line ("Closing View ...");
               -- Quit   := True;
               Active := False;
            end close;
            exit;
            -- or
              -- delay 1.0;
         end select;
      end loop;
      put_line ("View Stopped !!");
   end View;

end ViewContent;
