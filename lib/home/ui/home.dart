import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/home/bloc/home_bloc.dart';
import 'package:todo_list_bloc/home/ui/add_todo.dart';
import 'package:todo_list_bloc/home/ui/edit_todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();

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
              return AddTodoBottomSheet(
                homeBloc: homeBloc,
                title: titleController,
                subtitle: subtitleController,
              );
            },
          );
        } else if (state is TodoAddedState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data successfully added')));
          titleController.clear();
          subtitleController.clear();
          Navigator.of(context).pop();
        } else if (state is TodoAddingErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Some error happened')));
        } else if (state is EditButtonClikedState) {
          titleController.text = state.currentTitle;
          subtitleController.text = state.currentSubtitle;
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return EditTodoBottomSheet(
                homeBloc: homeBloc,
                title: titleController,
                subtitle: subtitleController,
                currentTitle: state.currentTitle,
                currentSubtitle: state.currentSubtitle,
                id: state.id,
              );
            },
          );
        } 
        else if (state is EditSubmitingState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data successfully edited')));
          Navigator.of(context).pop();
        }
        else if (state is DeleteButtonClickedState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data successfully deleted')));  
        }
      },
      builder: (context, state) {  
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator(), Text('Loading....')],
                ),
              ),
            );

          case HomeLoadedState:
            final data = state as HomeLoadedState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF4375FF),
                toolbarHeight: 100,
                title: const Text(
                  'Todo',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
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
                    ),
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: data.todos.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(data.todos[index]['title']),
                      subtitle: Text(data.todos[index]['description']),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xFF4375FF),
                        child: IconButton(
                          onPressed: () {
                            homeBloc.add(EditButtonClikedEvent(
                              id: data.todos[index]['_id'],
                              currentTitle: data.todos[index]['title'],
                              currentSubtitle: data.todos[index]['description'],
                            ));
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          homeBloc.add(DeleteButtonClickedEvent(
                              id: data.todos[index]['_id']));
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () {
                        // Handle tap
                      },
                    ),
                  );
                },
              ),
            );
          default:
            return const Placeholder();
        }
      },
    );
  }
}
