# Performance Measurement Summary

## Test Results
- **Date**: $(date)
- **Flutter Version**: $(flutter --version | head -1)
- **Dart Version**: $(dart --version)

## Static Analysis
$(head -20 "$RESULTS_DIR/static_analysis.txt")

## Test Coverage
$(grep -A 5 "All tests passed" "$RESULTS_DIR/test_results.txt" || echo "Tests completed")

## Performance Metrics
$(grep -A 10 "Frame Performance" "$RESULTS_DIR/performance_tests.txt" || echo "Performance data not available")

## Build Size
$(grep -E "(APK size|AAB size)" "$RESULTS_DIR/build_size.txt" || echo "Build size data not available")

## Memory Usage
$(grep -A 5 "Memory Usage" "$RESULTS_DIR/memory_tests.txt" || echo "Memory data not available")
