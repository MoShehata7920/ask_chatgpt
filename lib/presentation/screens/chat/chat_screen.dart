import 'package:firebase_auth/firebase_auth.dart' as fbauth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ask_chatgpt/data/models/user.dart';
import 'package:ask_chatgpt/presentation/constants/colors.dart';
import 'package:ask_chatgpt/presentation/constants/enums/process_status.dart';
import 'package:ask_chatgpt/presentation/constants/enums/status.dart';
import 'package:ask_chatgpt/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:ask_chatgpt/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:ask_chatgpt/presentation/resources/assets_manager.dart';
import 'package:ask_chatgpt/presentation/resources/routes_manager.dart';
import 'package:ask_chatgpt/presentation/widgets/container_bg.dart';
import 'package:ask_chatgpt/presentation/widgets/loading_widget.dart';
import 'package:ask_chatgpt/presentation/widgets/message_snackbar.dart';
import 'package:ask_chatgpt/presentation/widgets/text_box.dart';
import 'package:ask_chatgpt/presentation/widgets/text_loading_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController textController = TextEditingController();
  bool isLoading = false;
  User user = User.initial(); // setting user to initial (empty)
  final userId = fbauth.FirebaseAuth.instance.currentUser!.uid; // user id

  // fetch user data
  Future<void> fetchUserData() async {
    await context.read<ProfileCubit>().getProfile(userId: userId);
    setState(() {
      user = context.read<ProfileCubit>().state.user;
    });
  }

  // init State
  @override
  void initState() {
    fetchUserData();
    super.initState();
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
    print(textController.text);
  }

  // sign out action
  void signOut() {
    context.read<AuthBloc>().add(SignOutEvent());
    Navigator.pushNamed(context, Routes.homeRoute);
  }

  // logout handle
  Future<void> logOutHandle() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: primaryColor,
        title: Row(children: const [
          Icon(
            Icons.logout,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Text(
            'Do you want to log out?',
            style: TextStyle(color: Colors.white),
          ),
        ]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                user.profileImage ?? ImageAssets.avatarUrl,
              ),
              radius: 30,
            ),
            const SizedBox(height: 10),
            Text(
              user.userName,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(height: 2),
            Text(
              user.email,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: btnBg,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => signOut(),
            child: const Text('Yes'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: btnBg,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Dismiss'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
    );
  }
}
