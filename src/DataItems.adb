-- ---------------------------------------------------------------------------
-- SPDXVersion: SPDX-2.2 
-- SPDX-FileType: SOURCE
-- SPDX-LicenseConcluded:  BSD-3-Clause
-- SPDX-LicenseInfoInFile: BSD-3-Clause
-- SPDX-FileCopyrightText: Copyright 2020 William J. Franck (william.franck@sterna.io)
-- SPDX-Creator: William J. Franck (william.franck@sterna.io)
-- ---------------------------------------------------------------------------

package body DataItems is

   function Max (Left, Right : Identifier) return Identifier is
   begin
      if Right > Left then
         return Right;
      else
         return Left;
      end if;
   end Max;

end DataItems;
