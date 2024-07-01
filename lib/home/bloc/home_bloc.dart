import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/home/data/data_provider.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiServices apiServices = ApiServices();
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeAddButtonClickedEvent>(homeAddButtonClickedEvent);
    on<TodoSubmitClickedEvent>(todoSubmitClickedEvent);
    on<DeleteButtonClickedEvent>(deleteButtonClickedEvent);
    on<EditButtonClikedEvent>(editButtonClikedEvent);
    on<EditSubmitingEvent>(editSubmitingEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final decoded = await apiServices.getData();
      log(decoded.toString());
      emit(HomeLoadedState(todos: decoded));
    } catch (e) {
      log('Error fetching data: $e');
      emit(HomeErrorState());
    }
  }

  FutureOr<void> homeAddButtonClickedEvent(
      HomeAddButtonClickedEvent event, Emitter<HomeState> emit) {
    log('Add button clicked');
    emit(HomeAddButtonClickedState());
  }

  FutureOr<void> todoSubmitClickedEvent(
      TodoSubmitClickedEvent event, Emitter<HomeState> emit) async {
    try {
      await apiServices.postData(event.title, event.subtitle);
      final updatedTodos = await apiServices.getData();
      emit(HomeLoadedState(todos: updatedTodos));
      emit(TodoAddedState());
    } catch (e) {
      emit(TodoAddingErrorState());
    }
  }

  FutureOr<void> deleteButtonClickedEvent(
      DeleteButtonClickedEvent event, Emitter<HomeState> emit) async {
    try {
      await apiServices.delete(event.id);
      final updatedTodos = await apiServices.getData();
      emit(HomeLoadedState(todos: updatedTodos));
      emit(DeleteButtonClickedState());
    } catch (e) {
      log('deletion failed.');
    }
  }

  FutureOr<void> editButtonClikedEvent(
      EditButtonClikedEvent event, Emitter<HomeState> emit) {
    emit(EditButtonClikedState(
        id: event.id,
        currentTitle: event.currentTitle,
        currentSubtitle: event.currentSubtitle));
  }

  FutureOr<void> editSubmitingEvent(
      EditSubmitingEvent event, Emitter<HomeState> emit)async {
      try {
        await apiServices.editData(event.title, event.subtitle, event.id);
        final updatedTodos = await apiServices.getData();
      emit(HomeLoadedState(todos: updatedTodos));
      emit(EditSubmitingState());
      } catch (e) {
        log('error editing');
      }
      }
}
