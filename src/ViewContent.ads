with ViewState; use ViewState;

package ViewContent is

   State : State_Of_View;

   task type View is
      entry show;
      entry update;
      entry close;
   end View;

   myBody : View;

end ViewContent;
