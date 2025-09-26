#!/bin/bash

echo "=== NFL Survival Pool Performance Measurement ==="
echo "Date: $(date)"
echo ""

# Create results directory
mkdir -p performance_results
RESULTS_DIR="performance_results/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$RESULTS_DIR"

echo "Results will be saved to: $RESULTS_DIR"
echo ""

# 1. Run static analysis
echo "1. Running static analysis..."
flutter analyze > "$RESULTS_DIR/static_analysis.txt" 2>&1
echo "   Static analysis complete"

# 2. Run tests with coverage
echo "2. Running tests with coverage..."
flutter test --coverage > "$RESULTS_DIR/test_results.txt" 2>&1
echo "   Test coverage complete"

# 3. Run performance tests
echo "3. Running performance tests..."
flutter test test/performance/ > "$RESULTS_DIR/performance_tests.txt" 2>&1
echo "   Performance tests complete"

# 4. Measure build size
echo "4. Measuring build size..."
./scripts/measure_build_size.sh > "$RESULTS_DIR/build_size.txt" 2>&1
echo "   Build size measurement complete"

# 5. Run memory tests
echo "5. Running memory tests..."
flutter test test/performance/memory_baseline.dart > "$RESULTS_DIR/memory_tests.txt" 2>&1
echo "   Memory tests complete"

# 6. Generate summary report
echo "6. Generating summary report..."
cat > "$RESULTS_DIR/summary.md" << 'SUMMARY'
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
SUMMARY

echo ""
echo "=== Measurement Complete ==="
echo "Results saved to: $RESULTS_DIR"
echo "Summary report: $RESULTS_DIR/summary.md"
echo ""
echo "To compare before/after:"
echo "  diff performance_results/BEFORE/summary.md performance_results/AFTER/summary.md"
