import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:midjourney/feature/prompt/repo/prompt_repo.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptInitialEvent>(promtInitialEvent);
    on<PromptEnteredEvent>(promptEnteredEvent);
  }

  FutureOr<void> promptEnteredEvent(
      PromptEnteredEvent event, Emitter<PromptState> emit) async {
    emit(PromptGeneratingImageLoadState());
    File? file = await PromptRepo.generateImage(event.prompt);

    if (file != null) {
      emit(PromptGeneratingImageSuccessState(file: file));
    } else {
      emit(PromptGeneratingImageErrorState());
    }
  }

  FutureOr<void> promtInitialEvent(
      PromptInitialEvent event, Emitter<PromptState> emit) {
    emit(
      PromptGeneratingImageSuccessState(
        file: File('midjourney/assets/file.png'),
      ),
    );
  }
}
