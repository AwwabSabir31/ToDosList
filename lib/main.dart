import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Todo {
  String text;
  bool isCompleted;

  Todo(this.text, this.isCompleted);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 40,left: 40,right: 40),
        color: Colors.grey[200], // Set the background color for the entire body
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: todos[index].isCompleted ? Colors.lightGreen : Colors.white,
                    child: ListTile(
                      title: Text(
                        todos[index].text,
                        style: TextStyle(
                          decoration: todos[index].isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      leading: Checkbox(
                        value: todos[index].isCompleted,
                        onChanged: (value) {
                          setState(() {
                            todos[index].isCompleted = value!;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Add a new todo',
                ),
                onSubmitted: (newTodo) {
                  setState(() {
                    todos.add(Todo(newTodo, false));
                    _textEditingController.clear();
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
