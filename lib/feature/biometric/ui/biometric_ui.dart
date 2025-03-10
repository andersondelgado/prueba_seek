import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seek_prueba/feature/QR/ui/qr_ui.dart';
import 'package:seek_prueba/feature/biometric/bloc/biometric_bloc.dart';
import 'package:seek_prueba/feature/biometric/bloc/biometric_event.dart';
import 'package:seek_prueba/feature/biometric/bloc/biometric_state.dart';
import 'package:go_router/go_router.dart';

class BiometricUi extends StatefulWidget {
  static const routeName = '/auth';
  const BiometricUi({super.key});

  @override
  State<BiometricUi> createState() => _BiometricUiState();
}

class _BiometricUiState extends State<BiometricUi> {
  late BiometricBloc _biometricBloc;
  String? message;
  @override
  void initState() {
    _biometricBloc = context.read<BiometricBloc>();
    if (!_biometricBloc.state.authenticated) {
      setState(() {
        message = "";
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Autentication'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocConsumer<BiometricBloc, BiometricState>(
                  listener: (context, state) {
                    if (state.authenticated) {
                      BlocProvider.of<BiometricBloc>(context)
                          .add(ClearAuthentication());
                      context.pushReplacementNamed(QrUi.routeName);
                    }
                  },
                  builder: (context, state) {
                    message = state.authorized;
                    return ElevatedButton(
                      onPressed: () {
                        // BlocProvider.of<AuthBloc>(context).add(DoLogin(username, password));
                        BlocProvider.of<BiometricBloc>(context)
                            .add(AuthenticateWithBiometrics());
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            width: 150,
                            child:
                                Text('$message Authenticate: biometrics only'),
                          ),
                          const Icon(Icons.fingerprint),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocConsumer<BiometricBloc, BiometricState>(
                  listener: (context, state) {
                    if (state.authenticated) {
                      BlocProvider.of<BiometricBloc>(context)
                          .add(ClearAuthentication());
                      context.pushReplacementNamed(QrUi.routeName);
                    }
                  },
                  builder: (context, state) {
                    message = state.authorized;
                    return ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<BiometricBloc>(context)
                            .add(Authenticate());
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            width: 150,
                            child: Text('$message Authenticate'),
                          ),
                          const Icon(Icons.perm_device_information),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
