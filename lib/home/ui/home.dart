import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/home/bloc/home_bloc.dart';
import 'package:todo_list_bloc/home/ui/add_todo.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeAddButtonClickedState) {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddTodoBottomSheet();
              });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF4375FF),
            toolbarHeight: 100,
            title: const Text(
              'todo',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    homeBloc.add(HomeAddButtonClickedEvent());
                  },
                  icon: const Icon(
                    Icons.add_box_outlined,
                    color: Colors.white,
                    size: 30,
                  ))
            ],
          ),
        );
      },
    );
  }
}
