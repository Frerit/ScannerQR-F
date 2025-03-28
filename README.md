# Proyecto Scanner Flutter

Este proyecto es una aplicación de escaneo de códigos QR construida con IOS y Flutter e integrada con un módulo utilizando FlutterChannels. A continuación, detallo los pasos para configurar y ejecutar el proyecto en un entorno de desarrollo iOS.

# Comunicación entre Flutter e iOS
El proyecto utiliza FlutterMethodChannel para la comunicación entre Flutter y el código nativo de iOS. El canal está configurado en el archivo ScannerView.swift y permite enviar y recibir mensajes entre ambos lados.

# Comunicación:
Desde Flutter a iOS: Flutter envía un mensaje al canal com.example.scanner_flutter/native_scanner_bridge.
Desde iOS a Flutter: iOS responde al mensaje o invoca un método en Flutter utilizando el mismo canal.

## Requisitos previos

- **Flutter**: Versión mínima recomendada: `3.29.0`.
- **Dart**: Version `3.7.0`.
- **Xcode**: Versión mínima recomendada: `14.0`.
- **Cocoapods**: Asegúrate de tener instalado `Cocoapods` para manejar las dependencias de iOS.
- **macOS**: Versión 12.0 o superior (Monterey o más reciente).

## Pasos para ejecutar el proyecto

1. **Clonar el repositorio**  
   Clona el repositorio del proyecto en tu máquina local:

   ```bash
   git clone <URL_DEL_REPOSITORIO>
   cd scanner_flutter
   ```

2. **Instalar dependencias de Flutter**  
   Ejecuta el siguiente comando para instalar las dependencias de Flutter:

   ```bash
   flutter pub get
   ```

3. **Configurar el proyecto de iOS**  
   Navega al directorio `ScannerFlutter` dentro del proyecto y ejecuta `pod install` para instalar las dependencias de iOS:

   ```bash
   cd ScannerFlutter
   pod install
   ```

4. **Abrir el proyecto en Xcode**  
   Abre el archivo `ScannerFlutter.xcworkspace` con Xcode:

   ```bash
   open ScannerFlutter.xcworkspace
   ```

5. **Configurar un dispositivo o simulador**  
   En Xcode, selecciona un dispositivo físico conectado o un simulador para ejecutar la aplicación.

6. **Ejecutar la aplicación**  
   Presiona el botón de "Run" en Xcode para compilar y ejecutar la aplicación en el dispositivo o simulador seleccionado.

## Notas importantes

- **FlutterChannels**: Este proyecto utiliza FlutterChannels para la comunicación entre el módulo de Flutter y el código nativo de iOS. Asegúrate de que las configuraciones de los canales estén correctamente implementadas en ambos lados.
- **Compatibilidad**: El proyecto está diseñado para ejecutarse en dispositivos con iOS 14.0 o superior.

## Publicación en TestFlight

Aunque el proyecto puede ser preparado para TestFlight siguiendo las recomendaciones de la prueba, actualmente no puedo subir debido a la falta de una cuenta de desarrollador de Apple. A continuación, se describen los pasos para preparar el proyecto para TestFlight en caso de requerirlo:

1. **Configuración de Fastlane**  
   Fastlane se utiliza para automatizar el proceso de construcción y publicación. Asegúrate de que `Fastlane` esté instalado:

   ```bash
   gem install fastlane
   ```

2. **Tres pasos principales de Fastlane**

   - **Certificados**: Configura los certificados necesarios para la firma del código.
   - **Construcción**: Genera un archivo `.ipa` utilizando Fastlane.
   - **Subida**: Sube el archivo `.ipa` a TestFlight.

   Ejemplo de configuración de Fastlane:

   ```bash 
   fastlane release
   ```

3. **Finalización de la prueba**  
   Una vez que termine compilacion la aplicación estara en TestFlight. 

Si tienes alguna pregunta o problema, no dudes en abrir un issue en el repositorio.
