import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:ask_chatgpt/data/models/custom_error.dart';
import 'package:ask_chatgpt/data/repositories/auth_repos.dart';
import 'package:ask_chatgpt/presentation/constants/enums/process_status.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpCubit({required this.authRepository}) : super(SignUpState.initial());

  void handleSignUp(
      {required BuildContext context,
      required String email,
      required String password,
      required String username}) async {
    emit(state.copyWith(status: ProcessStatus.loading));
    try {
      await authRepository.signUp(
          email: email,
          password: password,
          userName: username,
          context: context);
      emit(state.copyWith(status: ProcessStatus.success));
    } on CustomError catch (e) {
      emit(state.copyWith(status: ProcessStatus.error, error: e));
    }
  }
}
