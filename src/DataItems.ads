-- ---------------------------------------------------------------------------
-- SPDXVersion: SPDX-2.2 
-- SPDX-FileType: SOURCE
-- SPDX-LicenseConcluded:  BSD-3-Clause
-- SPDX-LicenseInfoInFile: BSD-3-Clause
-- SPDX-FileCopyrightText: Copyright 2020 William J. Franck (william.franck@sterna.io)
-- SPDX-Creator: William J. Franck (william.franck@sterna.io)
-- ---------------------------------------------------------------------------
--  @summary Data definitions representing the state of 'View'.
--
--  @description These Data definitions will be used by the 3 entities representing the 'View' , the 'State', the 'Data source - or client'.
-- ---------------------------------------------------------------------------

with Ada.Strings.Wide_Wide_Bounded; use Ada.Strings.Wide_Wide_Bounded;

package DataItems is
   pragma Preelaborate;

   subtype Identifier is Integer range 1 .. 100; -- 2 * 24 - 1;

   package Strings_150 is new Generic_Bounded_Length (150);
   subtype UString_150 is Strings_150.Bounded_Wide_Wide_String;

   type Object is record
      Description : UString_150;
      completed   : Boolean;
   end record;

-- ==============================================================
   type Objects is array (Identifier'Range) of Object;
   type Object_List is record
      List      : Objects;
      Max_Index : Identifier;
   end record;

   function Max (Left, Right : Identifier) return Identifier;

end DataItems;
