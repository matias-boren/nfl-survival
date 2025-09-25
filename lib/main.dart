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
    final currentUser = ref.watch(currentUserProvider);
    
    // Initialize automated result processing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final processor = ref.read(automatedResultProcessorProvider);
      processor.startProcessing();
    });
    
    // Show loading while checking authentication
    if (currentUser == null) {
      // Check if we're already on signin page to avoid redirect loop
      final currentPath = GoRouterState.of(context).uri.path;
      if (currentPath != '/signin' && currentPath != '/sign-in') {
        return MaterialApp(
          home: const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );
      }
    }
    
    final goRouter = ref.watch(appRouterProvider);
    
    return MaterialApp.router(
      title: 'NFL Survival',
      theme: buildAppTheme(),
      routerConfig: goRouter,
    );
  }
}
