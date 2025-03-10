import 'package:equatable/equatable.dart';

class QrState extends Equatable {
  final String barcodeResult;

  const QrState(this.barcodeResult);

  static QrState empty = const QrState("");

  QrState copyWith({
    String? barcodeResult,
  }) {
    return QrState(barcodeResult ?? this.barcodeResult);
  }

  @override
  List<Object?> get props => [barcodeResult];
}
