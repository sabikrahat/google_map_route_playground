import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../config/constants.dart';
import '../../config/size.dart';
import '../../exception/exception.dart';
import '../../utils/extensions/extensions.dart';
import '../../utils/logger/logger_helper.dart';

Widget riverpodError(Object e, _) => KError(e);

Widget riverpodTextFieldError(Object e, _) => KTextFieldError(e);

Widget riverpodLoading() => const KLoading();

Widget riverpodTextFieldLoading() => const KTextFieldLoading();

Widget riverpodErrorSliver(Object e, _) => SliverToBoxAdapter(child: KError(e));

Widget riverpodLoadingSliver() => const SliverToBoxAdapter(child: KLoading());

class KLoading extends StatelessWidget {
  const KLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: 100.0, height: 100.0),
        child: SpinKitThreeBounce(color: context.theme.primaryColor, size: 30.0),
      ),
    );
  }
}

class KTextFieldLoading extends StatelessWidget {
  const KTextFieldLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: defaultBorderRadius,
        border: Border.all(color: context.text.bodyLarge?.color ?? Colors.grey),
      ),
      child: SpinKitThreeBounce(color: context.theme.primaryColor, size: 18.0),
    );
  }
}

class KError extends StatelessWidget {
  const KError(this.e, {super.key});

  final dynamic e;

  @override
  Widget build(BuildContext context) {
    log.e(e);
    return Center(
      child: Column(
        mainAxisSize: mainMin,
        children: [
          const Icon(Icons.error, size: 20.0, color: Colors.red),
          const SizedBox(height: 5.0),
          Text('Error: ${e is KException ? e.message : e}', style: const TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}

class KTextFieldError extends StatelessWidget {
  const KTextFieldError(this.e, {super.key});

  final dynamic e;

  @override
  Widget build(BuildContext context) {
    log.e(e);
    return Center(
      child: Row(
        mainAxisSize: mainMin,
        children: [
          const Icon(Icons.error, size: 20.0, color: Colors.red),
          const SizedBox(width: 5.0),
          Flexible(
            child: Text(
              'Error: $e',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
