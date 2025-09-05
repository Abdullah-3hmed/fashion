enum RequestStatus { initial, loading, success, error }

extension RequestStatusExtension on RequestStatus {
  bool get isInitial => this == RequestStatus.initial;
  bool get isLoading => this == RequestStatus.loading;
  bool get isSuccess => this == RequestStatus.success;
  bool get isError => this == RequestStatus.error;
}
