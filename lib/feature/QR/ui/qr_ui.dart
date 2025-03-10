import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seek_prueba/feature/QR/bloc/qr_bloc.dart';
import 'package:seek_prueba/feature/QR/bloc/qr_event.dart';
import 'package:seek_prueba/feature/QR/bloc/qr_state.dart';
import 'package:seek_prueba/feature/biometric/ui/biometric_ui.dart';

class QrUi extends StatefulWidget {
  static const routeName = '/qr';
  const QrUi({super.key});

  @override
  State<QrUi> createState() => _QrUiState();
}

class _QrUiState extends State<QrUi> {
  late QrBloc _qrBloc;
  late String _scanBarcode = "Unknow";
  @override
  void initState() {
    _scanBarcode = "";
    _qrBloc = context.read<QrBloc>();
    setState(() {
      _scanBarcode = _qrBloc.state.barcodeResult;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              context.pushReplacementNamed(BiometricUi.routeName);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<QrBloc, QrState>(listener: (context, state) {
                _scanBarcode = state.barcodeResult;
              }, builder: (context, state) {
                return Text(_scanBarcode, style: const TextStyle(fontSize: 20));
              }),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<QrBloc>(context).add(QrScan());
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Scan QR'),
                    Icon(Icons.qr_code),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
