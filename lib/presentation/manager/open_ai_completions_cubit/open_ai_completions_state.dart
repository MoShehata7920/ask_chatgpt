part of 'open_ai_completions_cubit.dart';

class OpenAiCompletionsState extends Equatable {
  final String currentCompletion;
  final String currentMessage;
  final List<OpenAICompletion> completions;

  const OpenAiCompletionsState({
    required this.currentCompletion,
    required this.currentMessage,
    required this.completions,
  });

  // props
  @override
  List<Object> get props => [
        currentCompletion,
        currentMessage,
        completions,
      ];

  // initial
  factory OpenAiCompletionsState.initial() => const OpenAiCompletionsState(
        currentCompletion: '',
        currentMessage: '',
        completions: [],
      );

  // toString()
  @override
  String toString() {
    return 'OpenAiCompletionsState{currentCompletion: $currentCompletion, completions: $completions,currentMessage:$currentMessage}';
  }

  // copyWith()
  OpenAiCompletionsState copyWith({
    String? currentCompletion,
    String? currentMessage,
    List<OpenAICompletion>? completions,
  }) {
    return OpenAiCompletionsState(
      currentCompletion: currentCompletion ?? this.currentCompletion,
      currentMessage: currentMessage ?? this.currentMessage,
      completions: completions ?? this.completions,
    );
  }
}
