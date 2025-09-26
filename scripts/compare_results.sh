#!/bin/bash

BEFORE_DIR="performance_results_BEFORE/$(ls performance_results_BEFORE | tail -1)"
AFTER_DIR="performance_results_AFTER/$(ls performance_results_AFTER | tail -1)"

echo "=== Performance Comparison Report ==="
echo "Before: $BEFORE_DIR"
echo "After:  $AFTER_DIR"
echo ""

# Compare build sizes
echo "Build Size Comparison:"
echo "Before:"
grep -E "(APK size|AAB size)" "$BEFORE_DIR/build_size.txt" || echo "  No data"
echo "After:"
grep -E "(APK size|AAB size)" "$AFTER_DIR/build_size.txt" || echo "  No data"
echo ""

# Compare performance metrics
echo "Performance Comparison:"
echo "Before:"
grep -A 5 "Frame Performance" "$BEFORE_DIR/performance_tests.txt" || echo "  No data"
echo "After:"
grep -A 5 "Frame Performance" "$AFTER_DIR/performance_tests.txt" || echo "  No data"
echo ""

# Compare memory usage
echo "Memory Usage Comparison:"
echo "Before:"
grep -A 5 "Memory Usage" "$BEFORE_DIR/memory_tests.txt" || echo "  No data"
echo "After:"
grep -A 5 "Memory Usage" "$AFTER_DIR/memory_tests.txt" || echo "  No data"
