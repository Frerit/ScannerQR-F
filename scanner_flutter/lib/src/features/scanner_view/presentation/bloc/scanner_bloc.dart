import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scanner_flutter/src/comunication/scanner_service.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  final NativeCommunicationService _communicationService =
      NativeCommunicationService();

  ScannerBloc() : super(ScannerInitial()) {
    on<ScannerEvent>((event, emit) {});
    on<ScannerStartEvent>(_onScannerStart);
    on<ScannerStopEvent>(_onScannerStop);
    on<ScannerErrorEvent>(_onScannerError);
    on<ScannerSuccessEvent>(_onScannerSuccess);
  }

  void _onScannerStart(ScannerStartEvent event, Emitter<ScannerState> emit) {
    final result = _communicationService.sendMessageToNative("start");
    emit(ScannerLoading());
  }

  void _onScannerStop(ScannerStopEvent event, Emitter<ScannerState> emit) {
    emit(ScannerInitial());
  }

  void _onScannerError(ScannerErrorEvent event, Emitter<ScannerState> emit) {
    emit(ScannerError(error: event.error));
  }

  void _onScannerSuccess(
    ScannerSuccessEvent event,
    Emitter<ScannerState> emit,
  ) {
    final result = _communicationService.sendMessageToNative(event.scannedData);
    emit(ScannerSuccess(scannedData: event.scannedData));
  }
}
