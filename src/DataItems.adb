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
