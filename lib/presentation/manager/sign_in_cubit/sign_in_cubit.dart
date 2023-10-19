import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:ask_chatgpt/data/models/custom_error.dart';
import 'package:ask_chatgpt/data/repositories/auth_repos.dart';
import 'package:ask_chatgpt/presentation/constants/enums/process_status.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepository;

  SignInCubit({required this.authRepository}) : super(SignInState.initial());

  void handleSignIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: ProcessStatus.loading));
    try {
      await authRepository.signIn(
          email: email, password: password, context: context);
      emit(state.copyWith(status: ProcessStatus.success));
    } on CustomError catch (e) {
      emit(state.copyWith(status: ProcessStatus.error, error: e));
    }
  }
}
