import 'package:flutter/material.dart';

class AddTodoBottomSheet extends StatelessWidget {
  const AddTodoBottomSheet({super.key});

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
            decoration: const InputDecoration(
              hintText: 'Enter ToDo title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          TextFormField(
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
                style:const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                  Color(0xFF4375FF),
                )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Add ToDo' , style: TextStyle(color: Colors.white,),
              ),
            ),
          ), 
          )
        ],
      
      ),
    );
  }
}
