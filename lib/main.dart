import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_client_app/config/routes/app_router.dart';
import 'package:two_client_app/config/theme/theme.dart';
import 'package:two_client_app/features/app/bloc/app_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AppBloc>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'TWO',
        theme: AppTheme.getTheme(),
        routerConfig: AppRouter().router,
        builder: (context, child) => child!,
      ),
    );
  }
}
