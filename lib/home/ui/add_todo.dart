import 'package:flutter/material.dart';
import 'package:todo_list_bloc/home/bloc/home_bloc.dart';

class AddTodoBottomSheet extends StatefulWidget {
const  AddTodoBottomSheet(
      {required this.homeBloc,
      required this.title,
      required this.subtitle,
      super.key});
  final HomeBloc homeBloc;
  final TextEditingController title;
  final TextEditingController subtitle;

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(  
      padding: const EdgeInsets.all(16.0),
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add ToDo',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.title,
            decoration: const InputDecoration(
              hintText: 'Enter ToDo title',
              border: OutlineInputBorder(),
            ),
          ), 
          const SizedBox(
            height: 50,
          ),
          TextFormField(
            controller: widget.subtitle,
            decoration: const InputDecoration(
              hintText: 'Enter ToDo subtitle',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: SizedBox(
              width: 300,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                  Color(0xFF4375FF),
                )),
                onPressed: () {
                  
                  widget.homeBloc.add(TodoSubmitClickedEvent(
                      title: widget.title.text,    
                      subtitle: widget.subtitle.text));
                 
                },
                child: const Text(
                  'Add ToDo',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
