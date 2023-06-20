sealed class CharityState<T> {}

class Loading<T> extends CharityState<T> {}

class Success<T> extends CharityState<T> {
  final T data;

  Success(this.data);
}

class Error<T> extends CharityState<T> {
  final String message;
  final Object error;

  Error({
    required this.message,
    required this.error,
  });
}
