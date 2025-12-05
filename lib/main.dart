import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sadamov/core/di/app_module.dart';
import 'package:sadamov/theme.dart';
import 'package:sadamov/utils/services/sync_service.dart';

/// Ponto de entrada da aplicação
/// Inicializa o Flutter, configura o Modular e inicia o serviço de sincronização
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SyncService.initialize();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const MyApp(),
    ),
  );
}

/// Widget raiz da aplicação
/// Configura temas claro/escuro e roteamento via Flutter Modular
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ocorrência Transporte',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      themeMode: ThemeMode.system,
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
