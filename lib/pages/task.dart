import 'package:flutter/material.dart';
import '../models/task_model.dart';

// ignore: camel_case_types
class Task_Form extends StatefulWidget {
  final Task? task;

  const Task_Form({super.key, this.task});

  @override
  State<Task_Form> createState() => _TaskState();
}

class _TaskState extends State<Task_Form> {
  DateTime? _selectedDate;
  Category? _selectedCategory;

  final TextEditingController taskTitleTextEditingController = TextEditingController();
  final TextEditingController taskDescriptionTextEditingControler = TextEditingController();

  

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
        if (widget.task != null) {
      taskTitleTextEditingController.text = widget.task!.title;
      taskDescriptionTextEditingControler.text = widget.task!.description;
      _selectedDate = widget.task!.dueDate;
      _selectedCategory = widget.task!.category;
    } 
  }
  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarefa"),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: taskTitleTextEditingController ,
              decoration: InputDecoration(
                labelText: 'Título',
                labelStyle: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 18.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: taskDescriptionTextEditingControler,
              decoration: InputDecoration(
                labelText: 'Descrição',
                labelStyle: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 18.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Data de Vencimento',
                  
                  labelStyle: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 18.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate != null
                          ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                          : "Selecione uma data",
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 16.0,
                      ),
                    ),
                    Icon(Icons.calendar_today, color: theme.primaryColor),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: DropdownButtonFormField<Category>(
              isDense: true,
              decoration: InputDecoration(
                labelText: 'Categoria',
                labelStyle: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 18.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              ),
              value: _selectedCategory,
              items: Category.values.map((category){
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.name[0].toUpperCase() + category.name.substring(1)),
                );
              }).toList(),
              onChanged: (Category? newValeu){
                setState(() {
                  _selectedCategory = newValeu!;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  if (widget.task == null) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop("remover");
                  }
                },
                child: Text(
                  widget.task == null ?'Cancelar': 'Remover',
                  style: TextStyle(
                    color: theme.primaryColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if(widget.task == null && taskDescriptionTextEditingControler.text.isNotEmpty && taskTitleTextEditingController.text.isNotEmpty && _selectedDate != null && _selectedCategory != null){

                      final Task newTask = Task(
                        id: UniqueKey().toString(),
                        title: taskTitleTextEditingController.text, 
                        description: taskDescriptionTextEditingControler.text, 
                        dueDate: _selectedDate!, 
                        category: _selectedCategory!
                      );
              
                  Navigator.pop(context, newTask);
      
                  } else {
                    final updatedTask = Task(
                        id: widget.task!.id,
                        title: taskTitleTextEditingController.text,
                        description: taskDescriptionTextEditingControler.text,
                        dueDate: _selectedDate!,
                        category: _selectedCategory!,
                        isCompleted: widget.task!.isCompleted,
                      );
                      Navigator.pop(context, updatedTask);
                  }
                },
                child: Text(
                  widget.task == null ? 'Adicionar' : 'Salvar Alterações',
                  style: TextStyle(
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(15.0)
            )
        ],
      ),
    );
  }
}
