-- ---------------------------------------------------------------------------
-- SPDXVersion: SPDX-2.2 
-- SPDX-FileType: SOURCE
-- SPDX-LicenseConcluded:  BSD-3-Clause
-- SPDX-LicenseInfoInFile: BSD-3-Clause
-- SPDX-FileCopyrightText: Copyright 2020 William J. Franck (william.franck@sterna.io)
-- SPDX-Creator: William J. Franck (william.franck@sterna.io)
-- ---------------------------------------------------------------------------
--  @summary Public instance of the view’s State, and possible actions on the 'View'. 
--
--  @description State object will be used by the 'Client' to initialize or update the data or behavior of the View.
-- ---------------------------------------------------------------------------

with ViewState; use ViewState;

package ViewContent is

   State : State_Of_View;

   task type View is
      entry init;
      entry update;
      entry close;
   end View;

   myBody : View;

end ViewContent;
