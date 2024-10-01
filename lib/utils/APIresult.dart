class APIresult<T> {
  final T? data;
  final String? error;

  APIresult._({this.data, this.error});

  factory APIresult.success(T data) {
    return APIresult._(data: data);
  }

  factory APIresult.error(String error) {
    return APIresult._(error: error);
  }

  bool get isSuccess => data != null;

  void when({
    required void Function(T data) success,
    required void Function(String error) error,
  }) {
    if (isSuccess) {
      success(data!);
    } else {
      error(this.error!);
    }
  }

  @override
  String toString() {
    if (isSuccess) {
      return 'Success: $data';
    } else {
      return 'Error: $error';
    }
  }
}
