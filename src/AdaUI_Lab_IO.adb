-- ---------------------------------------------------------------------------
-- SPDXVersion: SPDX-2.2
-- SPDX-FileType: SOURCE
-- SPDX-LicenseConcluded:  BSD-3-Clause
-- SPDX-LicenseInfoInFile: BSD-3-Clause
-- SPDX-FileCopyrightText: Copyright 2022 William J. Franck (william.franck@sterna.io)
-- SPDX-Creator: William J. Franck (william.franck@sterna.io)
-- ---------------------------------------------------------------------------

package body AdaUI_Lab_IO is

   procedure trace (Level : Trace_kind; Message : Character) is
   begin
      if Level = Trace_Level then
         Ada.Text_IO.put (Message);
      end if;
   end trace;

   procedure trace (Level : Trace_kind; Message : String) is
   begin
      if Level = Trace_Level then
         Ada.Text_IO.put (Message);
      end if;
   end trace;

   procedure trace_Line (Level : Trace_kind; Message : Character) is
   begin
      if Level = Trace_Level then
         trace (Level, Message);
         Ada.Text_IO.new_Line;
      end if;
   end trace_Line;

   procedure trace_Line (Level : Trace_kind; Message : String) is
   begin
      if Level = Trace_Level then
         trace (Level, Message);
         Ada.Text_IO.new_Line;
      end if;
   end trace_Line;

end AdaUI_Lab_IO;
