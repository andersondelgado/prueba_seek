import 'package:equatable/equatable.dart';

abstract class QREvent extends Equatable {}

class QrScan extends QREvent {
  @override
  List<Object?> get props => [];
}
