# Experimenting an AdaUI framework
Exploring how to implement in Ada the View-Model paradigm like the Apple’s SwiftUI Windowing system.

## Features
 * **Views** are first-class _task objects_
 * Views owns a data _protected object_ representing the *state* of that view 
 * The view changes it’s appearance or the data displayed through a change in data of the **state** object
 * Updating data in the **State** object will call the _callback procedure_ linked to the *update entry* in the **View** _task object_
 * **State Data definition** is declared in a specific unit
 * The **Business Model Unit** - or main program - only communicates with the View through the **state** object.

Implementation Note: In order to communicate with a _protected object_, The **Business Model Unit** - or main program - has to be a _task object_.

