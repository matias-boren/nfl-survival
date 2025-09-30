import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:pick1/firebase_options.dart';
import 'package:pick1/app/router.dart';
import 'package:pick1/app/providers.dart';
import 'package:pick1/app/theme/theme.dart';
import 'package:pick1/core/services/ad_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Firebase Analytics
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // Initialize Firebase Performance
  FirebasePerformance performance = FirebasePerformance.instance;

  // Initialize Hive
  await Hive.initFlutter();

  // Initialize Supabase with production credentials
  await Supabase.initialize(
    url:
        dotenv.env['SUPABASE_URL'] ??
        const String.fromEnvironment(
          'SUPABASE_URL',
          defaultValue: 'https://yjynojqiyrlnszoiqdgp.supabase.co',
        ),
    anonKey:
        dotenv.env['SUPABASE_ANON_KEY'] ??
        const String.fromEnvironment(
          'SUPABASE_ANON_KEY',
          defaultValue:
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlqeW5vanFpeXJsbnN6b2lxZGdwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg3MDY1NzUsImV4cCI6MjA3NDI4MjU3NX0.E5jj9ldIXu-5vhy5n-0GxopBJd7L8RvEtuFKHedWNz8',
        ),
  );

  // Initialize AdMob
  await AdService().initialize();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(appRouterProvider);

    // Initialize automated services
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initialize automated data refresh service (processes results 6 hours before week end)
      final dataRefreshService = ref.read(automatedDataRefreshServiceProvider);
      dataRefreshService.startService();
      print('🔄 Automated data refresh service started');

      // Initialize automated news generation service
      final newsGenerator = ref.read(newsGeneratorProvider);
      if (NewsConfig.openAIApiKey.isNotEmpty) {
        newsGenerator.startService();
        print('📰 News generation service started');
      } else {
        print('OpenAI API key not found - news generation service disabled');
      }
    });

    return MaterialApp.router(
      title: 'Pick1',
      theme: buildAppTheme(),
      routerConfig: goRouter,
    );
  }
}
