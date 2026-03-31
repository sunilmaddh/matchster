class ApiContants {
  ApiContants._();

  static const contentTypeKey = 'Content-Type';
  static const acceptKey = 'Accept';
  static const authorizationKey = 'Authorization';

  static const applicationJson = 'application/json';
  static const bearer = 'Bearer';

  static const defaultTimeoutSeconds = 30;
  static const maxValidStatusCode = 500;
  static const defaultErrorStatusCode = -1;
  static const successStatusCode = 200;
}
