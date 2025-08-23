part of '../extensions.dart';

extension GoRouteExtension on BuildContext {
  Future goPushRoute<T>(String path, {Object? extra}) async =>
      sl<PT>().isWeb
          ? GoRouter.of(this).go(path, extra: extra)
          : await GoRouter.of(this).push(path, extra: extra);

  Future goPush<T>(
    String name, {
    Map<String, String> pathParams = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
    String? fragment,
  }) async =>
      sl<PT>().isWeb
          ? GoRouter.of(this).goNamed(
            name,
            pathParameters: pathParams,
            queryParameters: queryParams,
            extra: extra,
            fragment: fragment,
          )
          : await GoRouter.of(
            this,
          ).pushNamed(name, pathParameters: pathParams, queryParameters: queryParams, extra: extra);

  Future goPushReplacement<T>(
    String name, {
    Map<String, String> pathParams = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
    String? fragment,
  }) async =>
      sl<PT>().isWeb
          ? GoRouter.of(this).pushReplacement(name, extra: extra)
          : await GoRouter.of(this).pushReplacementNamed(
            name,
            pathParameters: pathParams,
            queryParameters: queryParams,
            extra: extra,
          );
}

extension GoRouterExtension on GoRouter {
  void clearStackAndNavigate(String location) {
    while (canPop()) {
      pop();
    }
    pushReplacement(location);
  }
}
