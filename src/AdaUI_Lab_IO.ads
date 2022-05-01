-- ---------------------------------------------------------------------------
-- SPDXVersion: SPDX-2.2 
-- SPDX-FileType: SOURCE
-- SPDX-LicenseConcluded:  BSD-3-Clause
-- SPDX-LicenseInfoInFile: BSD-3-Clause
-- SPDX-FileCopyrightText: Copyright 2020 William J. Franck (william.franck@sterna.io)
-- SPDX-Creator: William J. Franck (william.franck@sterna.io)
-- ---------------------------------------------------------------------------

with Ada.Text_IO;

package AdaUI_Lab_IO is

   CONSOLE : constant Ada.Text_IO.File_Type := Ada.Text_IO.Standard_Output;
   LOG : constant Ada.Text_IO.File_Type :=   Ada.Text_IO.Standard_Error;
   
   type Trace_kind is ( None, Info, Warning, Debug); 

   Trace_Level : Trace_kind := Info;

   procedure trace (Level : Trace_kind; Message : Character);
   procedure trace (Level : Trace_kind; Message : String);
--   procedure trace (Message : Wide_Wide_String);

   procedure trace_Line (Level : Trace_kind; Message : Character);
   procedure trace_Line (Level : Trace_kind; Message : String);
--   procedure trace_Line (Message : Wide_Wide_String);

private
end AdaUI_Lab_IO;
