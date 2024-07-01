part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeAddButtonClickedEvent extends HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class TodoSubmitClickedEvent extends HomeEvent {
  final String title;
  final String subtitle;

  TodoSubmitClickedEvent({required this.title, required this.subtitle});
}

class DeleteButtonClickedEvent extends HomeEvent {
  final String id;

  DeleteButtonClickedEvent({required this.id});
}

class EditButtonClikedEvent extends HomeEvent {
  final String id;
  final String currentTitle;
  final String currentSubtitle;

  EditButtonClikedEvent(
      {required this.id,
      required this.currentTitle,
      required this.currentSubtitle});
}

class EditSubmitingEvent extends HomeEvent {
  final String id;
   final String title;
  final String subtitle;

  EditSubmitingEvent({required this.id, required this.title, required this.subtitle});
}
