import 'package:equatable/equatable.dart';

class BiometricState extends Equatable {
  final bool authenticated;
  final String authorized;
  final bool isAuthenticating;

  const BiometricState(
      this.authenticated, this.authorized, this.isAuthenticating);

  static BiometricState empty = const BiometricState(false, "", false);

  BiometricState copyWith({
    bool? authenticated,
    String? authorized,
    bool? isAuthenticating,
  }) {
    return BiometricState(authenticated ?? this.authenticated,
        authorized ?? this.authorized, isAuthenticating ?? isAuthenticating!);
  }

  @override
  List<Object?> get props => [authenticated, authorized, isAuthenticating];
}
