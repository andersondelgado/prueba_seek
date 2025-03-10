import 'package:equatable/equatable.dart';

abstract class BiometricEvent extends Equatable {}

class AuthenticateWithBiometrics extends BiometricEvent {
  @override
  List<Object?> get props => [];
}

class Authenticate extends BiometricEvent {
  @override
  List<Object?> get props => [];
}

class CancelAuthentication extends BiometricEvent {
  @override
  List<Object?> get props => [];
}

class ClearAuthentication extends BiometricEvent {
  @override
  List<Object?> get props => [];
}
