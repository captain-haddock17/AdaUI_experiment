with DataItems; use DataItems;

package ViewState is

   type Data_of_State is -- new Class and ObservableObject  with
   record
      Data : Object_List;
   end record;

   type callback_proc is access procedure;

   protected type State_Of_View is

      procedure init (State : Data_of_State);

      entry register (View_to_update : callback_proc);

      entry update (State : Data_of_State);

      function read return Data_of_State;

   private
      Actual_State : Data_of_State;
   end State_Of_View;

end ViewState;
