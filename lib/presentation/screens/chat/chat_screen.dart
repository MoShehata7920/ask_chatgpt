import 'package:ask_chatgpt/presentation/constants/colors.dart';
import 'package:ask_chatgpt/presentation/constants/enums/process_status.dart';
import 'package:ask_chatgpt/presentation/constants/enums/status.dart';
import 'package:ask_chatgpt/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:ask_chatgpt/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:ask_chatgpt/presentation/resources/assets_manager.dart';
import 'package:ask_chatgpt/presentation/resources/routes_manager.dart';
import 'package:ask_chatgpt/presentation/resources/strings_manager.dart';
import 'package:ask_chatgpt/presentation/service/global_methods.dart';
import 'package:ask_chatgpt/presentation/widgets/container_bg.dart';
import 'package:ask_chatgpt/presentation/widgets/drop_down_widget.dart';
import 'package:ask_chatgpt/presentation/widgets/loading_widget.dart';
import 'package:ask_chatgpt/presentation/widgets/message_bubble.dart';
import 'package:ask_chatgpt/presentation/widgets/message_snackbar.dart';
import 'package:ask_chatgpt/presentation/widgets/text_box.dart';
import 'package:ask_chatgpt/presentation/widgets/text_loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbauth;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ask_chatgpt/data/models/user.dart';
import 'package:lottie/lottie.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController textController = TextEditingController();
  bool isLoading = false;
  bool doneResponding = false;
  User user = User.initial(); // setting user to initial (empty)
  final userId = fbauth.FirebaseAuth.instance.currentUser!.uid; // user id

  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(ImageAssets.logo),
        ),
        title: const Text(
          AppStrings.appName,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color(0xFF0C385D),
        actions: [
          BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state.status == ProcessStatus.loading) {
                const LoadingWidget(size: 10);
              }
            },
            child: GestureDetector(
                onTap: () {
                  showBottomSheet();
                },
                child: CircleAvatar(
                  backgroundColor: btnBg,
                  child: ClipOval(
                    child: Image.network(
                      user.profileImage == ""
                          ? ImageAssets.avatarUrl
                          : user.profileImage,
                      width: 40,
                      height: 40,
                      fit: BoxFit.fill,
                    ),
                  ),
                )),
          ),
          GestureDetector(
            onTap: () {
              logOutHandle();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LottieBuilder.asset(
                JsonAssets.logoOut,
                width: 35,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          MessageBubble(
            isUser: true,
            size: size,
            text: textController.text,
            imgUrl: user.profileImage == ""
                ? ImageAssets.avatarUrl
                : user.profileImage,
            editFunction: () {
              editText();
            },
            copyFunction: () {
              copyResponse();
            },
            likeFunction: () {
              likeResponse();
            },
            disLikeFunction: () {
              disLikeResponse();
            },
          ),
          MessageBubble(
            isUser: false,
            size: size,
            text: textController.text,
            imgUrl: ImageAssets.logo,
            editFunction: () {
              editText();
            },
            copyFunction: () {
              copyResponse();
            },
            likeFunction: () {
              likeResponse();
            },
            disLikeFunction: () {
              disLikeResponse();
            },
          ),
        ],
      ),
      bottomSheet: ContainerBg(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isLoading ? const TextLoading() : const SizedBox.shrink(),
            TextBoxWidget(
              textController: textController,
              size: size,
              generateResponse: generateResponse,
            )
          ],
        ),
      ),
    );
  }

  // fetch user data
  Future<void> fetchUserData() async {
    await context.read<ProfileCubit>().getProfile(userId: userId);
    setState(() {
      user = context.read<ProfileCubit>().state.user;
    });
  }

  // generate response from OpenAI
  void generateResponse() {
    FocusScope.of(context).unfocus();
    if (textController.text.isEmpty) {
      displaySnackBar(
        status: Status.error,
        context: context,
        message: 'Text can not be empty',
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
  }

  // logout handle
  Future<void> logOutHandle() {
    return GlobalMethods.warningDialog(
        title: AppStrings.wantLogOut,
        subtitle: user.email,
        function: () {
          context.read<AuthBloc>().add(SignOutEvent());
        },
        navigateTo: () {
          Navigator.pushNamed(context, Routes.homeRoute);
        },
        warningIcon: JsonAssets.logoOut,
        context: context);
  }

  // regenerate response
  void regenerateResponse() {}

  // copy response
  void copyResponse() {
    Clipboard.setData(const ClipboardData(text: 'abcdef')).then(
      (_) => displaySnackBar(
        status: Status.success,
        message: 'Copied successfully',
        context: context,
      ),
    );
  }

  // like response
  void likeResponse() {}

  // dislike response
  void disLikeResponse() {}

  // edit text
  void editText() {}

  // show bottom modal
  Future<void> showBottomSheet() async {
    await showModalBottomSheet(
      backgroundColor: msgBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) => const Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Selected Model:',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            ModelDropDownButton(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
