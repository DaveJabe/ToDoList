# ToDoList

### Development Details
> * This to-do list application is built using MVVM architecture and both delegate (ToDoViewController) and box-method (FocusViewController) design patterns for communication.
> * Several UIKit extensions are implemented to promote reusable code: computed properties for UIView dimensions (left, right, etc.), function for presenting alerts, adding child view controllers, etc.
> * CoreData is used to persist user information (to do tasks).

### Background
> * ToDoList features a focus timer, based off of the Pomodoro study technique.
>   * https://en.wikipedia.org/wiki/Pomodoro_Technique


![todo-add delete](https://user-images.githubusercontent.com/54407429/197621963-1ed4f4d3-d497-4ccf-a1a6-37ff2eb1c5da.gif)
* Adding and deleting tasks from TaskViewController.



![todo-sorting](https://user-images.githubusercontent.com/54407429/197621947-fcd045ab-a45f-4dc8-8b60-f1dd7349291b.gif)
* Sorting tasks based on alphabetical (ascending & descending) order and completion status (complete vs. incomplete).



![todo-pomodoro](https://user-images.githubusercontent.com/54407429/197622213-84551f69-6edf-45c7-a4cf-8bd08e05d69e.gif)
* Focus timer based on the Pomodoro study technique ("Work" and "Break" times will be made customizable). The intention is to implement code that updates bottom row (1 2 3 4) with a checkmark every time a "Work" session is complete.
* This footage is sped up x5 for brevity.



![todo-pause cancel](https://user-images.githubusercontent.com/54407429/197622218-0b42d030-147e-4336-aa22-0df872682c2a.gif)
* The focus timer can be both paused and canceled.
