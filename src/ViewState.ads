-- ---------------------------------------------------------------------------
-- SPDXVersion: SPDX-2.2
-- SPDX-FileType: SOURCE
-- SPDX-LicenseConcluded:  BSD-3-Clause
-- SPDX-LicenseInfoInFile: BSD-3-Clause
-- SPDX-FileCopyrightText: Copyright 2022 William J. Franck (william.franck@sterna.io)
-- SPDX-Creator: William J. Franck (william.franck@sterna.io)
-- ---------------------------------------------------------------------------
--  @summary Actual data representing the state of the 'View'.
--
--  @description This data is shared between the ’Client’ and the ’View’. Data can be initialized, read, or update by the ’Client’ or the ’View’.
-- ---------------------------------------------------------------------------

with DataItems; use DataItems;

package ViewState is

   type Data_of_State is record
      Data : Object_List;
   end record;

   type callback_proc is access procedure;

   protected type State_Of_View is

      procedure init (State : Data_of_State);

      entry register (View_to_update : callback_proc);

      entry update (State : Data_of_State);

      entry updated;

      function read return Data_of_State;

      entry updated;

      entry quit;

   private
      Actual_State : Data_of_State;
   end State_Of_View;

end ViewState;
