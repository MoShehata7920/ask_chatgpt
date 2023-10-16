import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String errorMessage;
  final String code;
  final String plugin;

  const CustomError({
    required this.errorMessage,
    required this.code,
    required this.plugin,
  });

  factory CustomError.initial() =>
      const CustomError(errorMessage: '', code: '', plugin: '');

  @override
  String toString() {
    return 'CustomError{errorMessage: $errorMessage, code: $code, plugin: $plugin}';
  }

  @override
  List<Object?> get props => [errorMessage, code, plugin];
}
