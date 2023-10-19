import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ask_chatgpt/data/models/custom_error.dart';
import 'package:ask_chatgpt/data/repositories/auth_repos.dart';
import 'package:ask_chatgpt/presentation/constants/enums/process_status.dart';

part 'google_auth_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  final AuthRepository authRepository;

  GoogleAuthCubit({required this.authRepository})
      : super(GoogleAuthState.initial());

  void handleGoogleAuth() async {
    emit(state.copyWith(status: ProcessStatus.loading));
    try {
      await authRepository.googleAuth();
      emit(state.copyWith(status: ProcessStatus.success));
    } on CustomError catch (e) {
      emit(state.copyWith(status: ProcessStatus.error, error: e));
    }
  }
}
