part of 'scanner_bloc.dart';

abstract class ScannerState extends Equatable {
  const ScannerState();

  @override
  List<Object> get props => [];
}

class ScannerInitial extends ScannerState {}

class ScannerLoading extends ScannerState {}

class ScannerSuccess extends ScannerState {
  final String scannedData;

  const ScannerSuccess({required this.scannedData});

  @override
  List<Object> get props => [scannedData];
}

class ScannerError extends ScannerState {
  final String error;

  const ScannerError({required this.error});

  @override
  List<Object> get props => [error];
}
