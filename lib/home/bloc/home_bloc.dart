import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeAddButtonClickedEvent>(homeAddButtonClickedEvent);
  }

  FutureOr<void> homeAddButtonClickedEvent(
      HomeAddButtonClickedEvent event, Emitter<HomeState> emit) {
        log('Add button clicked');
        emit(HomeAddButtonClickedState());
      }
}

