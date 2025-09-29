// Test script to debug member count issue
// Run this with: dart test_member_count_direct.dart

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // Initialize Supabase
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL', // Replace with your actual URL
    anonKey: 'YOUR_SUPABASE_ANON_KEY', // Replace with your actual key
  );

  final supabase = Supabase.instance.client;
  final leagueId = 'b2d97471-b3f9-4116-b00b-715eab2faabd';

  try {
    print('Testing member count for league: $leagueId');

    // Test the exact same query we're using in the app
    final response = await supabase
        .from('league_members')
        .select('user_id')
        .eq('league_id', leagueId);

    print('Raw response: $response');
    print('Response type: ${response.runtimeType}');
    print('Response length: ${response.length}');
    print('Member count: ${response.length}');

    // Also test a simple count query
    final countResponse = await supabase
        .from('league_members')
        .select('*')
        .eq('league_id', leagueId);

    print('Count response: ${countResponse.length}');
  } catch (e) {
    print('Error: $e');
  }
}
