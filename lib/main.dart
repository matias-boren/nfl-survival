import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nfl_survival/app/router.dart';
import 'package:nfl_survival/app/theme/theme.dart';
import 'package:nfl_survival/app/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load(fileName: ".env");
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? 'https://your-project.supabase.co',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? 'your-anon-key',
  );
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(appRouterProvider);
    
    // Initialize automated result processing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final processor = ref.read(automatedResultProcessorProvider);
      processor.startProcessing();
    });
    
    return MaterialApp.router(
      title: 'NFL Survival',
      theme: buildAppTheme(),
      routerConfig: goRouter,
    );
  }
}
