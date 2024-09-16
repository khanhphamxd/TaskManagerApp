This is my Swift program designed to manage the task of a normal user. Its functionality revolves around creating and keeping tabs on different types of tasks like work, personal or social tasks, allowing the user to create and delete tasks as they needed, as well as let them mark and view their completed tasks. 

The model used for the system revolves around the TaskDetail protocol, which include all of the variables and their getters necessary for all instances of tasks. All 3 types of the task (WorkTask, PersonalTask, SocialTask) are all inherited from this main protocol, with some attribute set for id, type (work / personal / social), and isComplete = false 

My TaskViewModel consists of methods used to control the flow of tasks into task array and completed task array, with add/remove/get all tasks from the task array (as well as a validation method used to check for empty fields when adding a task), as well as mark a task as completed (consequently adding it into the completed task array) and get all tasks from the completed task array.

My program currently has 5 views (technically 4 views as the TaskListView is only used inside of ContentView), which can show the users the following

   - ContentView: The main view that the user will first experience. Consist of the title, TaskListView and 2 buttons that allows them to add a new task or to view the completed task list
  
       + TaskListView: A main display that shows all of the currently ongoing tasks. Clicking on any one of them can prompt you to a TaskDetailView of the task.
      
       + TaskDetailView. A view displaying the details related to the task the user has selected on
          
   - AddTaskView: Display the view in which you can insert the necessary details related to the task, such as name and description, and choose its category to add to the main task list. Includes a warning when either the name or description field is empty.
  
   - CompletedTaskView: Display all of the completed tasks that have been marked by the user. Clicking on any of the task will prompt a TaskDetailView for the task in the same way that TaskListView does. 