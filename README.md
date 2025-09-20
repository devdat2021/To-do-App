### Project: PlanIt - A Simple Task Manager

This project is a straightforward and basic to-do list application built with Flutter. It helps users manage their tasks, set priorities, and keep track of completed items by moving them to an archive. The app's design is clean and focuses on a simple, intuitive user experience. 
The project was made for learning purpose so it might lack many usefule features as of now.

-----

### Features

  * **Create, Edit, and Delete Tasks**: Easily add new tasks, update their details, or remove them entirely.
  * **Set Task Priority**: Assign a priority level (High, Medium, Low, or None) to each task, indicated by a color-coded circle.
  * **Add Due Dates**: Set a specific due date for your tasks to stay organized.
  * **Archive and Restore**: Move completed tasks to a separate archive page and restore them to the main list if needed.
  * **Persistent Data (To be implemented)**: The current version does not save data, so tasks will be lost when the app is closed.

-----

### Getting Started

#### Prerequisites

To run this project, you need to have the Flutter SDK installed on your machine. You can find the installation guide on the [official Flutter website](https://flutter.dev/docs/get-started/install).

#### Installation

1.  **Clone the repository**:
    ```bash
    git clone [your-repository-url]
    ```
2.  **Navigate to the project directory**:
    ```bash
    cd [your-project-directory]
    ```
3.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
4.  **Run the app**:
    ```bash
    flutter run
    ```

-----

### Usage

The app has two main views: Home and Archive, which you can switch between using the bottom navigation bar.

#### Home Page

  * Tap the **"+" icon** to add a new task.
  * **Long-press** on a task card to bring up a menu to edit or delete the task.
  * Check the **checkbox** on a task card to move it to the archive.

#### Archive Page

  * View all your completed tasks.
  * Uncheck the **checkbox** on a task to restore it to the Home page.

-----



### Future Enhancements

  * **Data Persistence**: Implement local storage or a database to save tasks so they are not lost when the app is closed.
  * **Detailed Task View**: Add a screen to view and edit more detailed information for each task.
  * **Notes and Links**: Add functionality to include notes and web links for each project.
  * **Sorting and Filtering**: Allow users to sort tasks by priority, due date, or other criteria.

-----
