sealed class Result<T> {
  const Result();
  R map<R>({required R Function(T) ok, required R Function(AppError) err});
}

class Ok<T> extends Result<T> {
  final T value;
  const Ok(this.value);
  @override
  R map<R>({
    required R Function(T p1) ok,
    required R Function(AppError p1) err,
  }) => ok(value);
}

class Err<T> extends Result<T> {
  final AppError error;
  const Err(this.error);
  @override
  R map<R>({
    required R Function(T p1) ok,
    required R Function(AppError p1) err,
  }) => err(error);
}

class AppError implements Exception {
  final String code;
  final String message;
  const AppError(this.code, this.message);
  @override
  String toString() => 'AppError($code): $message';
}

class PremiumGuard {
  static bool canJoinAnotherLeague({
    required bool isPremium,
    required int joinedCount,
  }) {
    return isPremium || joinedCount < 1;
  }
}
