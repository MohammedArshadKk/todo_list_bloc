part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeAddButtonClickedState extends HomeActionState {}

class TodoAddedState extends HomeActionState {}

class TodoAddingErrorState extends HomeActionState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<dynamic> todos;

  HomeLoadedState({required this.todos});
}

class HomeErrorState extends HomeState {}

class DeleteButtonClickedState extends HomeActionState {}

class EditButtonClikedState extends HomeActionState {
  final String id;
  final String currentTitle;
  final String currentSubtitle;

  EditButtonClikedState(
      {required this.id,
      required this.currentTitle,
      required this.currentSubtitle});
}

class EditSubmitingState extends HomeActionState {}
