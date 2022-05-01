-- ---------------------------------------------------------------------------
-- SPDXVersion: SPDX-2.2 
-- SPDX-FileType: SOURCE
-- SPDX-LicenseConcluded:  BSD-3-Clause
-- SPDX-LicenseInfoInFile: BSD-3-Clause
-- SPDX-FileCopyrightText: Copyright 2020 William J. Franck (william.franck@sterna.io)
-- SPDX-Creator: William J. Franck (william.franck@sterna.io)
-- ---------------------------------------------------------------------------

with AdaUI_Lab_IO; use AdaUI_Lab_IO;

package body ViewState is

   StatusChanged_Callback : callback_proc;
   Alive      : Boolean := False;


   -- -------------
   -- State_Of_View
   -- -------------
   protected body State_Of_View is

      procedure init (State : Data_of_State) is -- when True is
      begin
         Actual_State := State;
         trace_Line (INFO, "State of View: Data initialised ...");
      end init;

      entry register (View_to_update : callback_proc) when not Alive is
      begin
         trace_Line (INFO, "State of View: Registering ...");
         StatusChanged_Callback := View_to_update;
         Alive      := True;
      end register;

      entry update (State : Data_of_State) when Alive is
      begin
         Actual_State := State;
         trace_Line (INFO, "State of View: Data updated ...");
         -- MARK: Sending the "updated status" message to the registered View
         StatusChanged_Callback.all;
         -- -----------------------------------------------------------------

      end update;

      function read return Data_of_State is
      begin
         return Actual_State;
      end read;

   end State_Of_View;

end ViewState;
