import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:seek_prueba/feature/biometric/bloc/biometric_event.dart';
import 'package:seek_prueba/feature/biometric/bloc/biometric_state.dart';

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  final LocalAuthentication auth = LocalAuthentication();

  BiometricBloc() : super(BiometricState.empty) {
    on<AuthenticateWithBiometrics>(_authenticateWithBiometrics);
    on<Authenticate>(_authenticate);
    on<ClearAuthentication>(_clearAuthentication);
  }

  FutureOr<void> _authenticateWithBiometrics(
      AuthenticateWithBiometrics event, Emitter<BiometricState> emit) async {
    emit(
      state.copyWith(
          authenticated: false, authorized: '', isAuthenticating: false),
    );
    try {
      emit(
        state.copyWith(
            authenticated: false,
            authorized: 'autenticating',
            isAuthenticating: true),
      );
      var biometric = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      emit(state.copyWith(
          authenticated: biometric,
          authorized: biometric ? 'Authorized' : 'Not Authorized',
          isAuthenticating: !biometric));
    } on PlatformException catch (e) {
      emit(state.copyWith(
          authenticated: false,
          authorized: 'Error: ${e.message}',
          isAuthenticating: false));
    }
  }

  FutureOr<void> _authenticate(
      Authenticate event, Emitter<BiometricState> emit) async {
    emit(
      state.copyWith(
          authenticated: false, authorized: '', isAuthenticating: false),
    );
    try {
      emit(
        state.copyWith(
            authenticated: false,
            authorized: 'autenticating',
            isAuthenticating: true),
      );
      var biometric = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(stickyAuth: true),
      );

      emit(state.copyWith(
          authenticated: biometric,
          authorized: biometric ? 'Authorized' : 'Not Authorized',
          isAuthenticating: !biometric));
    } on PlatformException catch (e) {
      emit(state.copyWith(
          authenticated: false,
          authorized: 'Error: ${e.message}',
          isAuthenticating: false));
    }
  }

  FutureOr<void> _clearAuthentication(
      ClearAuthentication event, Emitter<BiometricState> emit) {
    emit(state.copyWith(
        authenticated: false, authorized: "", isAuthenticating: false));
  }
}
