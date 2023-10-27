import 'package:firebase_auth/firebase_auth.dart' as fbauth;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';

import 'package:ask_chatgpt/data/models/open_ai_completion_model.dart';
import 'package:ask_chatgpt/data/models/user.dart';
import 'package:ask_chatgpt/data/repositories/api_repo.dart';
import 'package:ask_chatgpt/presentation/constants/colors.dart';
import 'package:ask_chatgpt/presentation/constants/enums/status.dart';
import 'package:ask_chatgpt/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:ask_chatgpt/presentation/manager/open_ai_completions_cubit/open_ai_completions_cubit.dart';
import 'package:ask_chatgpt/presentation/manager/open_ai_model_cubit/open_ai_model_cubit.dart';
import 'package:ask_chatgpt/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:ask_chatgpt/presentation/resources/assets_manager.dart';
import 'package:ask_chatgpt/presentation/resources/routes_manager.dart';
import 'package:ask_chatgpt/presentation/resources/strings_manager.dart';
import 'package:ask_chatgpt/presentation/service/global_methods.dart';
import 'package:ask_chatgpt/presentation/widgets/container_bg.dart';
import 'package:ask_chatgpt/presentation/widgets/drop_down_widget.dart';
import 'package:ask_chatgpt/presentation/widgets/loading_widget.dart';
import 'package:ask_chatgpt/presentation/widgets/message_box.dart';
import 'package:ask_chatgpt/presentation/widgets/message_bubble.dart';
import 'package:ask_chatgpt/presentation/widgets/message_snackbar.dart';
import 'package:ask_chatgpt/presentation/widgets/text_loading_widget.dart';

class InnerScreenBody extends StatefulWidget {
  const InnerScreenBody({
    Key? key,
    required this.isChatScreen,
  }) : super(key: key);
  final bool isChatScreen;

  @override
  State<InnerScreenBody> createState() => _InnerScreenBodyState();
}

class _InnerScreenBodyState extends State<InnerScreenBody> {
  final TextEditingController textController = TextEditingController();
  bool isTyping = false;
  bool isProfileImgLoading = true;
  bool isCompletionDone = false;
  User user = User.initial(); // setting user to initial (empty)
  final userId = fbauth.FirebaseAuth.instance.currentUser!.uid; // user id

  // init State
  @override
  void initState() {
    super.initState();
    fetchUserData();
    final logger = Logger();
    if (kDebugMode) {
      logger.i('Mode: ${widget.isChatScreen}');
      logger
          .i('Model: ${context.read<OpenAiModelCubit>().state.selectedModel}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var openAICubit = context.read<OpenAiCompletionsCubit>().state;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset(ImageAssets.logo),
            ),
            const SizedBox(width: 10),
            const Text(
              AppStrings.appName,
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          isProfileImgLoading
              ? const LoadingWidget(size: 10)
              : GestureDetector(
                  onTap: () {
                    if (!widget.isChatScreen) {
                      showBottomSheet();
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: btnBg,
                    child: ClipOval(
                      child: Image.network(
                        user.profileImage.isEmpty
                            ? ImageAssets.avatarUrl
                            : user.profileImage,
                        width: 40,
                        height: 40,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: isCompletionDone
          ? FloatingActionButton(
              onPressed: () => regenerateCompletion(),
              backgroundColor: accentColor,
              child: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            )
          : const SizedBox.shrink(),
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 70.0),
        child: SizedBox(
          height: size.height / 1,
          child: ListView.builder(
              itemCount: widget.isChatScreen
                  ? openAICubit.chats.length
                  : openAICubit.completions.length,
              itemBuilder: (context, index) {
                var completion = widget.isChatScreen
                    ? openAICubit.chats[index]
                    : openAICubit.completions[index];
                return MessageBubble(
                  isUser: completion.isUser,
                  size: size,
                  text: completion.text,
                  imgUrl: completion.isUser
                      ? user.profileImage.isEmpty
                          ? ImageAssets.avatarUrl
                          : user.profileImage
                      : ImageAssets.logo,
                  toggleIsLiked: toggleIsLike,
                  copyFunction: copyResponse,
                  editFunction: editText,
                  completionId: completion.id,
                );
              }),
        ),
      ),
      bottomSheet: ContainerBg(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isTyping ? const TextLoading() : const SizedBox.shrink(),
            MessageBoxWidget(
              textController: textController,
              size: size,
              generateResponse: generateCompletion,
              isTyping: isTyping,
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
      isProfileImgLoading = false;
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
          Navigator.pushReplacementNamed(context, Routes.homeRoute);
        },
        warningIcon: JsonAssets.logoOut,
        context: context);
  }

  // generate response from OpenAI
  void generateCompletion() async {
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
      isTyping = true;
    });
    var cxt = context.read<OpenAiCompletionsCubit>(); // completion cubit

    List<OpenAICompletion> data = [];
    data.add(
      OpenAICompletion(
        id: DateTime.now().toString(),
        text: textController.text,
        isUser: true,
      ),
    );
    // set user data
    if (widget.isChatScreen) {
      // set chats
      cxt.setChats(chats: data);
    } else {
      // set completions
      cxt.setCompletion(completions: data);
    }

    // response from API
    List<OpenAICompletion> response = [];
    try {
      if (widget.isChatScreen) {
        response = await APIRepository.getChat(
          text: textController.text,
          model: context.read<OpenAiModelCubit>().state.selectedModel,
        );
      } else {
        response = await APIRepository.getCompletion(
          text: textController.text,
          model: context.read<OpenAiModelCubit>().state.selectedModel,
        );
      }

      // persist last sent text
      cxt.setCurrentMessage(textController.text);

      // set response from API
      if (widget.isChatScreen) {
        // set chats
        cxt.setChats(chats: response);
      } else {
        // set completions
        cxt.setCompletion(completions: response);
      }

      setState(() {
        isCompletionDone = true;
        textController.clear();
      });
    } catch (e) {
      final logger = Logger();
      if (kDebugMode) {
        logger.e(e);
      }
    } finally {
      setState(() {
        isTyping = false;
      });
    }
  }

  // regenerate completion or chat
  void regenerateCompletion() async {
    setState(() {
      isTyping = true;
    });
    var cxt = context.read<OpenAiCompletionsCubit>(); // completion cubit

    List<OpenAICompletion> response = [];
    try {
      if (widget.isChatScreen) {
        response = await APIRepository.getChat(
          text: cxt.state.currentMessage,
          model: context.read<OpenAiModelCubit>().state.selectedModel,
        );
      } else {
        response = await APIRepository.getCompletion(
          text: cxt.state.currentMessage,
          model: context.read<OpenAiModelCubit>().state.selectedModel,
        );
      }
      if (widget.isChatScreen) {
        // set chats
        cxt.setChats(chats: response);
      } else {
        // set completions
        cxt.setCompletion(completions: response);
      }
    } catch (e) {
      if (kDebugMode) {
        final logger = Logger();
        if (kDebugMode) {
          logger.e(e);
        }
      }
    } finally {
      setState(() {
        isTyping = false;
      });
    }
  }

  // copy response
  void copyResponse(String text) {
    Clipboard.setData(ClipboardData(text: text)).then(
      (_) => displaySnackBar(
        status: Status.success,
        message: 'Copied successfully',
        context: context,
      ),
    );
  }

  // toggleIsLike response
  void toggleIsLike({
    required String completionId,
    required bool value,
  }) {
    context.read<OpenAiCompletionsCubit>().toggleCompletionIsLike(
          completionId: completionId,
          value: value,
        );
  }

  // edit text
  void editText(String text) {
    setState(() {
      textController.text = text;
    });
  }

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
