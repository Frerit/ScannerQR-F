import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_flutter/src/features/scanner_view/presentation/bloc/scanner_bloc.dart';
import 'package:scanner_flutter/src/features/scanner_view/presentation/pages/scanner_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ScannerBloc(),
        child: const ScannerPage(),
      ),
    );
  }
}
