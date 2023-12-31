import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbauth;
import 'package:flutter/material.dart';

import 'package:ask_chatgpt/data/repositories/auth_repos.dart';
import 'package:ask_chatgpt/presentation/constants/enums/auth_status.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  late StreamSubscription authSubscription;

  AuthBloc({required this.authRepository}) : super(AuthState.initial()) {
    authSubscription = authRepository.user.listen((fbauth.User? user) {
      add(AuthStateChangeEvent(user: user));
    });

    on<AuthStateChangeEvent>((event, emit) {
      if (event.user != null) {
        emit(state.copyWith(
          user: event.user,
          authStatus: AuthStatus.authenticated,
        ));
      } else {
        emit(state.copyWith(
          authStatus: AuthStatus.unauthenticated,
        ));
      }
    });

    on<SignOutEvent>((event, emit) {
      authRepository.signOut();
    });
  }
}
