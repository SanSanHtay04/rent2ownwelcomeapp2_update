class ApiResponse {
  MsgState msgState;
  ErrorState errorState;
  dynamic data;
  PageState? pageState;

  ApiResponse(
      {required this.msgState,
      required this.errorState,
      this.data,
      this.pageState});
}

enum MsgState { data, error, loading, other }

enum ErrorState {
  unknownErr,
  serverErr,
  notFoundErr,
  noErr,
  forbiddenErr,
  badRequest
}

enum PageState { first, load, noMore }
