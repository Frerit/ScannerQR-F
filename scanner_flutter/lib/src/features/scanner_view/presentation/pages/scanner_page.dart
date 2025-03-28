import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanner_flutter/src/features/scanner_view/presentation/bloc/scanner_bloc.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ScannerBloc, ScannerState>(
        listener: (context, state) {
          if (state is ScannerError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              MobileScanner(
                onDetect: (barcodes) {
                  context.read<ScannerBloc>().add(
                    ScannerSuccessEvent(
                      scannedData:
                          barcodes.barcodes.first.rawValue ??
                          'No QR code detected',
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
              ...state is ScannerSuccess
                  ? [
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Text(
                        state.scannedData,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]
                  : [],
            ],
          );
        },
      ),
    );
  }
}
