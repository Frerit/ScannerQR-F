part of 'scanner_bloc.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();

  @override
  List<Object> get props => [];
}

class ScannerStartEvent extends ScannerEvent {}

class ScannerStopEvent extends ScannerEvent {}

class ScannerErrorEvent extends ScannerEvent {
  final String error;

  const ScannerErrorEvent({required this.error});

  @override
  List<Object> get props => [error];
}

class ScannerSuccessEvent extends ScannerEvent {
  final String scannedData;

  const ScannerSuccessEvent({required this.scannedData});

  @override
  List<Object> get props => [scannedData];
}
