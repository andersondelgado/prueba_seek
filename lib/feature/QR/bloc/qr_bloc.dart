import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seek_prueba/feature/QR/bloc/qr_event.dart';
import 'package:seek_prueba/feature/QR/bloc/qr_state.dart';

class QrBloc extends Bloc<QREvent, QrState> {
  QrBloc() : super(QrState.empty) {
    on<QrScan>(_qrScan);
  }

  FutureOr<void> _qrScan(QrScan event, Emitter<QrState> emit) async {
    emit(
      state.copyWith(barcodeResult: ""),
    );
    try {
      var barcodeResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      emit(
        state.copyWith(barcodeResult: barcodeResult),
      );
    } on PlatformException {
      emit(
        state.copyWith(barcodeResult: 'Failed to get platform version.'),
      );
    }
  }
}
