import 'package:flutter/services.dart';

class NativeCommunicationService {
  static const MethodChannel _channel = MethodChannel(
    'com.example.scanner_flutter/native_scanner_bridge',
  );

  Future<String?> sendMessageToNative(String message) async {
    try {
      // Invocar un método en el lado nativo
      final result = await _channel.invokeMethod('receiveMessage', message);
      return result;
    } on PlatformException catch (e) {
      print('Error en la comunicación: ${e.message}');
      return null;
    }
  }

  void setupNativeMessageListener() {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'sendMessageToFlutter':
          print('Mensaje recibido desde iOS: ${call.arguments}');
          return 'Mensaje recibido correctamente';
        default:
          throw MissingPluginException();
      }
    });
  }
}
