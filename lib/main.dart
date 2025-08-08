import 'package:flutter/material.dart';

void main(){
    runApp(const TodoApp());
}

class Task{
    String text;
    bool isDone;
    Task(this.text,{this.isDone=false});
}
class TodoApp extends StatelessWidget{
    const TodoApp({super.key});
    @override
    Widget build(BuildContext context) {
     return MaterialApp(
        title: 'Doiry',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const TodoHomePage(),
        debugShowCheckedModeBanner: false,
     );
  }

}

class TodoHomePage extends StatefulWidget{
    const TodoHomePage({super.key});
    @override
    State<TodoHomePage> createState()=> _TodoHomePageState();

}

class _TodoHomePageState extends State<TodoHomePage>{
    final List<Task> _tasks=[];
    final TextEditingController _controller=TextEditingController();

    void _addTask(){
        final text=_controller.text.trim();
        if(text.isEmpty) return;
        setState(() {
          _tasks.add(Task(text));
          _controller.clear();
        });
    }

    void _deleteTask(int i){
        setState(() {
          _tasks.removeAt(i);
        });
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(appBar: AppBar(
            title: const Text('Doiry'),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 255, 202, 44),
        ),
        body: Padding(padding: const EdgeInsets.all(16),
        child: Column(
            children: [Row(
            children: [
                Expanded(child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                    hintText: 'Add a new task',
                ),
                onSubmitted: (_)=>_addTask(),
            ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(onPressed: _addTask,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 245, 158, 36),
                
            ), 
            child: const Text("Add"),
            ),
        ],
        ),
        const SizedBox(height: 20),
        Expanded(child: ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (context, i){
                final task=_tasks[i];
                return Card(
                    color: const Color.fromARGB(255, 185, 255, 255),
                    child: ListTile(
                        leading: Checkbox(value: task.isDone, onChanged: (bool? checked){
                            setState(() {
                              task.isDone=checked??false;
                            });
                        },
                        ),
                    title: Text(
                        task.text,
                        style: TextStyle(
                            decoration: task.isDone?TextDecoration.lineThrough:null,

                        ),
                    ),
                    trailing: IconButton(onPressed: ()=>_deleteTask(i), icon: Icon(Icons.delete,color: Colors.red),
                    ),
                ),
                );
        
            }
        ),
        ),
         ], 
        ),
          
        ),
        );
    }
}
