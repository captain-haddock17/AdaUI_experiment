# Experimenting an AdaUI framework
Exploring how to implement in Ada the View-Model paradigm like the Apple’s SwiftUI Windowing system.

## Features
 * **Views** supports a declarative approach of its content, and are not driven by outside clients or programs
 * Each View owns his data structure representing the **state** of that view 
 * The view changes it’s appearance or the data displayed through a change in data of the **state** object
 * Updating data in the **State** object will trigger the update of the **View**
 * The **Business Model Unit** - or main program - only communicates with the View through the **state** object.

## Implementation Notes
 * **Views** are first-class _task objects_ 
 * **State** data is accessible through a _protected object_ 
 * **State Data definition** is declared in a specific unit
 * Updating data in the **State** object will call the registered _callback procedure_ linked to the *update entry* in the **View** _task object_
 * In order to communicate with a _protected object_, The **Business Model Unit** - or main program - has to be a _task object_.

 
