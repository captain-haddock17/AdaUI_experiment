with Ada.Text_IO; use Ada.Text_IO;

package body ViewState is

   mycallback : callback_proc;
   Alive      : Boolean := False;


   -- -------------
   -- State_Of_View
   -- -------------
   protected body State_Of_View is

      procedure init (State : Data_of_State) is -- when True is
      begin
         Actual_State := State;
         Put_Line ("Sate of View: Data initialised ...");
      end init;

      entry register (View_to_update : callback_proc) when not Alive is
      begin
         Put_Line ("Sate of View: Registering ...");
         mycallback := View_to_update;
         Alive      := True;
      end register;

      entry update (State : Data_of_State) when Alive is
      begin
         Actual_State := State;
         Put_Line ("Sate of View: Data updated ...");
         mycallback.all;

      end update;

      function read return Data_of_State is
      begin
         return Actual_State;
      end read;

   end State_Of_View;

end ViewState;
