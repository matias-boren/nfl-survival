import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222831), // Your dark background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              height: 150,
              width: 350,
              child: Image.asset(
                'assets/images/logo/pick1_logo_horizontal.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to icon + text if logo not found
                  return Column(
                    children: [
                      Icon(
                        Icons.sports_football,
                        size: 100,
                        color: const Color(0xFF76ABAE), // Your teal color
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Pick1',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFEEEEEE), // Your light text color
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 48),
            
            // Loading indicator
            const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF76ABAE)),
              ),
            ),
            const SizedBox(height: 24),
            
            // Loading text
            Text(
              'Loading your survival journey...',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF76ABAE),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
