# Task Management App

A Flutter-based task management application that allows users to add, delete, and mark tasks as completed. It includes features like task categorization, progress tracking, theme switching, and data persistence using shared preferences.

## Features

### Task List Screen
The main screen of the app displays tasks organized by categories. Tasks are listed with their titles, descriptions, and statuses. Users can:
- Expand or collapse categories to view the tasks inside them.
- See the progress indicator reflecting the completion status of tasks within each category.

### Add Task
Users can add a new task by tapping the "+" icon on the top right corner of the screen. After that, they can:
- Enter a title for the task.
- Provide a description for the task.
- Select a category for the task (tasks are categorized based on user preferences).
- Save the task, and it will be added to the list and persisted across app sessions using **SharedPreferences**.

### Delete Task
Tasks can be deleted by swiping left on the task item. The app supports the following:
- **Swipe left**: Triggers the delete action for a task.
- If a task is marked as completed, it cannot be deleted directly unless it's marked as incomplete first.
- A confirmation message or undo option can be shown when a task is deleted.

### Mark Task as Complete
Tasks can be marked as completed by swiping right on the task item. The features include:
- **Swipe right**: Marks the task as completed and updates the task status.
- If a task is already marked as completed, the app shows a message saying "Task is already marked as completed" to prevent re-marking.
- The completion status is visually reflected with a progress indicator and the status label.

### Progress Indicator
Each category displays a circular progress indicator that reflects the completion status of tasks within that category. Key details include:
- **Progress Circle**: Displays the percentage of tasks marked as completed for the category.
- **Color Coding**: The completed portion of the progress circle is highlighted in purple, while the remaining portion is grey.

### Theme Switching
The app supports dynamic theme switching to allow users to choose between light and dark modes. Key features include:
- **Light Theme**: Provides a bright and clean interface for daytime usage.
- **Dark Theme**: Provides a dark interface to reduce eye strain in low-light environments.
- **Toggle Button**: A sun/moon icon is available on the top right corner for users to switch themes instantly.

### Data Persistence
The app uses **SharedPreferences** to store tasks and maintain data across app sessions. Features include:
- **Persistent Storage**: All tasks (added, marked as complete, or deleted) are saved locally.
- **App Restarts**: Tasks persist after the app is closed and reopened.

### User Notifications
- **Snackbars**: The app uses snackbars to show notifications when actions are taken, such as when a task is marked as completed or when a task is already completed and the user tries to mark it again.
- **Undo Deletion**: A snackbar notification with an undo option is displayed when a task is deleted.

## Tech Stack

- **Flutter**: Used for building the cross-platform mobile application. It's a powerful framework for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **GetX**: A state management solution in Flutter that is fast, lightweight, and easy to use. It's used in this project for managing the state of the app.
- **SharedPreferences**: A local storage solution for storing key-value pairs persistently in the app. It is used to store tasks and other app data across sessions.
- **Circular Percent Indicator**: A package used to show circular progress indicators that represent the completion percentage of tasks in a visually appealing way.
