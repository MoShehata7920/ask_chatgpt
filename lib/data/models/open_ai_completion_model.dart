import 'package:equatable/equatable.dart';

class OpenAICompletion extends Equatable {
  final String id, text;
  bool isLiked, isUser;

  OpenAICompletion({
    required this.id,
    required this.text,
    this.isLiked = false,
    this.isUser = false,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        isLiked,
        isUser,
      ];

  factory OpenAICompletion.fromJson(Map<String, dynamic> data) =>
      OpenAICompletion(
        id: data['id'],
        text: data['text'],
      );

  factory OpenAICompletion.initial() => OpenAICompletion(id: '', text: '');

  static List<OpenAICompletion> toListCompletions(List completions) {
    return completions.map((data) => OpenAICompletion.fromJson(data)).toList();
  }

  void toggleIsLiked(bool value) {
    isLiked = value;
  }
}
