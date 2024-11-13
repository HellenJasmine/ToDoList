import 'package:flutter/material.dart';
import 'package:to_do_list/pages/task.dart';
import "../models/task_model.dart";



class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Task> tasksList = [];


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    return Scaffold(
      backgroundColor: theme.primaryColor ,
      appBar: AppBar(
        title:const Text("Lista de Tarefas"),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        ),
      // body: Column(
      //   children: [
      //     Container(
      //       color: Colors.white,
      //       padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      //       child:Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: Category.values.map((category) {
      //             return ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //               backgroundColor: theme.primaryColor, // Cor de fundo do botão
      //               foregroundColor: Colors.white,
                    
      //               elevation: 0,
      //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(8.0),
      //               ),
      //             ),
      //               onPressed: () {
      //                 print("Botão ${category.string} pressionado");
      //             },
      //             child: Text(category.string), // Usa o texto definido na extensão
      //           );
      //         }).toList(), // Converte para uma lista de widgets
      //       ),
      //     ),
          body: Container( 
            color: Colors.white,
            child: tasksList.isNotEmpty
              ? Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0
                      ) ,
                      child: ListView.builder(
                      itemCount: tasksList.length,
                      itemBuilder: (context, index){
                      
                        final task = tasksList[index];
                      
                        return TextButton(
                          onPressed: () async{
                            final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Task_Form(task: task)
                              ),
                            );
                            if(result == 'remover'){
                              setState(() {
                                tasksList.remove(task);
                              });
                            }else if (result != null && result is Task){
                              setState(() {
                                final index = tasksList.indexOf(task);
                                if(index != -1){
                                  tasksList[index] = result;
                                }
                              });
                            }
                          },
                          child: ListTile(
                            leading: Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                value: task.isCompleted, 
                                onChanged: (isCheked){
                                  setState(() {
                                    
                                    task.isCompleted = isCheked!;
                                    
                                  });
                                }
                                ),
                            ),
                            title: Text(
                              task.title, 
                              style:TextStyle(
                                color: task.isCompleted ? Colors.grey : Colors.black,
                                decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none 
                              ) ,),
                            subtitle: Text(task.description,
                            style:TextStyle(
                                color: task.isCompleted ? Colors.grey : Colors.black,
                                decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none 
                              ) ,),
                            trailing: IconButton(
                              onPressed: (){
                                setState(() {
                                  tasksList.remove(task);
                                
                                });
                              },
                              icon:const Icon(
                                Icons.delete, 
                                color: Colors.redAccent,
                                size: 30.0 ,
                              ),
                            ),
                          ),
                        );
                    
                      },
                    ),
                  ),
                
              ),
              
            ]
            )
            : const Center(
              child: Text("Nenhuma tarefa adicionada!",
              style: TextStyle(
                color: Colors.grey,
              ),
              ),
            ),
          ),
          
      

      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          final newTask =  await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Task_Form()),
          );
          
          if(newTask != null && newTask is Task){
            setState(() {
              tasksList.add(newTask);
            });
          }
          }),
      );
  }
}