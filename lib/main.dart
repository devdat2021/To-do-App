import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Todolist()));
}

class Task {
  String title;
  DateTime? dueDate;
  String priority;
  bool archived;

  Task({
    required this.title,
    this.dueDate,
    this.priority = 'Normal',
    this.archived = false,
  });
}

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

//Priority Color picker
Color getPriorityColor(String priority) {
  switch (priority) {
    case 'High':
      return Colors.red;
    case 'Medium':
      return Colors.yellow;
    case 'Low':
      return Colors.green;
    default:
      return Colors.grey;
  }
}

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController taskController = TextEditingController();
  String selectedPriority = 'None'; // Default value
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Task Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedPriority,
              items: ['High', 'Medium', 'Low', 'None']
                  .map(
                    (priority) => DropdownMenuItem(
                      value: priority,
                      child: Text(priority),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPriority = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Priority',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextButton.icon(
              icon: Icon(Icons.calendar_today),
              label: Text(
                selectedDate == null
                    ? 'Pick Due Date'
                    : 'Due: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
              ),
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //save if the task title is not empty.
                if (taskController.text.isNotEmpty) {
                  Navigator.pop(
                    context,
                    Task(
                      title: taskController.text,
                      priority: selectedPriority,
                      dueDate: selectedDate,
                    ),
                  );
                } else {
                  //show a message to the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a task title')),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TodolistState extends State<Todolist> {
  final TextEditingController task = TextEditingController();
  int currentIndex = 0; // 0 = Home, 1 = Archive
  //String title = '';
  List<Task> items = [];
  List<bool> isChecked = [];
  List<Task> archive = [];

  @override
  void dispose() {
    task.dispose();
    super.dispose();
  }

  Widget buildHomePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Text(
                      "No tasks added",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final task = items[index];

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top Row: Title + Checkbox
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  task.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Checkbox(
                                  value: task.archived,
                                  onChanged: (value) {
                                    setState(() {
                                      task.archived = value!;
                                    });

                                    if (value!) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '${task.title} is completed',
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );

                                      Future.delayed(Duration(seconds: 2), () {
                                        setState(() {
                                          archive.add(task);
                                          items.removeAt(index);
                                        });
                                      });
                                    }
                                  },
                                ),
                              ),

                              //Show Due Date under title
                              if (task.dueDate != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    bottom: 8.0,
                                  ),
                                  child: Text(
                                    'Due: ${task.dueDate!.day}/${task.dueDate!.month}/${task.dueDate!.year}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),

                              // Bottom Row: Priority aligned to bottom-right
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 12.0,
                                    bottom: 4.0,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Priority:',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      CircleAvatar(
                                        radius: 8,
                                        backgroundColor: getPriorityColor(
                                          task.priority,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildArchivePage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Archived Tasks',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: archive.isEmpty
                ? Center(
                    child: Text(
                      "Archive is empty!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: archive.length,
                    itemBuilder: (context, index) {
                      final arctask = archive[index];
                      return Card(
                        color: Color.fromARGB(199, 173, 248, 255),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(arctask.title),
                          trailing: Checkbox(
                            value: arctask.archived,
                            onChanged: (value) {
                              if (value == null) return;

                              if (!value) {
                                // user unchecked -> restore task immediately
                                setState(() {
                                  arctask.archived = false;
                                  items.add(arctask);
                                  archive.removeAt(index);
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${arctask.title} restored!'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else {
                                // (optional) user checked -> keep archived
                                setState(() {
                                  arctask.archived = true;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${arctask.title} archived!'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do App'),
        backgroundColor: Color.fromARGB(199, 103, 225, 244),
      ),
      //backgroundColor: const Color.fromARGB(255, 166, 197, 251),
      body: currentIndex == 0 ? buildHomePage() : buildArchivePage(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          );

          if (result != null && result is Task) {
            setState(() {
              items.add(result);
            });
          }
        },
        label: Text('Add'),
        icon: Icon(Icons.add),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(199, 103, 225, 244),
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Archive'),
        ],
      ),
    );
  }
}
