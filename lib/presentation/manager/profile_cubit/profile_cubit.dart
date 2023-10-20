import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ask_chatgpt/data/models/custom_error.dart';
import 'package:ask_chatgpt/data/models/user.dart';
import 'package:ask_chatgpt/data/repositories/profile_repo.dart';
import 'package:ask_chatgpt/presentation/constants/enums/process_status.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  ProfileCubit({required this.profileRepository})
      : super(ProfileState.initial());

  Future<void> getProfile({required String userId}) async {
    emit(state.copyWith(status: ProcessStatus.loading));
    try {
      final user = await profileRepository.fetchProfile(userId: userId);
      emit(state.copyWith(user: user, status: ProcessStatus.success));
    } on CustomError catch (e) {
      emit(state.copyWith(status: ProcessStatus.error, error: e));
    }
  }
}
