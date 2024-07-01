import 'package:flutter/material.dart';
import 'package:todo_list_bloc/home/bloc/home_bloc.dart';

class EditTodoBottomSheet extends StatefulWidget {
  const EditTodoBottomSheet({
    required this.homeBloc,
    required this.title,
    required this.subtitle,
    required this.currentTitle,
    required this.currentSubtitle,
    required this.id,
    super.key,
  });

  final HomeBloc homeBloc;
  final TextEditingController title;
  final TextEditingController subtitle;
  final String currentTitle;
  final String currentSubtitle;
  final String id;

  @override
  State<EditTodoBottomSheet> createState() => _EditTodoBottomSheetState();
}

class _EditTodoBottomSheetState extends State<EditTodoBottomSheet> {
  @override
  void initState() {
    super.initState();
    widget.title.text = widget.currentTitle;
    widget.subtitle.text = widget.currentSubtitle;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Edit ToDo',
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
          const SizedBox(height: 50),
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
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color(0xFF4375FF),
                  ),
                ),
                onPressed: () {
                  widget.homeBloc.add(EditSubmitingEvent(
                      id: widget.id,
                      title: widget.title.text,
                      subtitle: widget.subtitle.text));
                },
                child: const Text(
                  'Edit ToDo',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
