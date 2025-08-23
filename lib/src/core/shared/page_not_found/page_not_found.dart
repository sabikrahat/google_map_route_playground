import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;

import '../../config/constants.dart';
import '../../utils/extensions/extensions.dart';

class KPageNotFound extends StatelessWidget {
  const KPageNotFound({super.key, this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: mainMin,
            mainAxisAlignment: mainCenter,
            children: [
              SvgPicture.asset(
                'assets/svgs/error.svg',
                height: context.width * 0.35,
                width: context.width * 0.35,
              ),
              Text(
                error?.toString() ?? '404 - Page not found!',
                textAlign: TextAlign.center,
                style: context.text.bodyLarge?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccesDeniedPage extends StatelessWidget {
  const AccesDeniedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: mainMin,
              mainAxisAlignment: mainCenter,
              children: [
                SvgPicture.asset(
                  'assets/icons/app-icon.svg',
                  height: context.width * 0.15,
                  width: context.width * 0.15,
                  // colorFilter: context.theme.primaryColor.toColorFilter,
                ),
                const SizedBox(height: 20),
                Text(
                  'You are not authorized to access this page!\nIf you think this is a mistake, please contact your administrator.',
                  textAlign: TextAlign.center,
                  style: context.text.labelLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KDataNotFound extends StatelessWidget {
  const KDataNotFound({super.key, this.msg, this.onPressed});

  final String? msg;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: mainMin,
            mainAxisAlignment: mainCenter,
            children: [
              SvgPicture.asset(
                'assets/svgs/no-data.svg',
                height: 100,
                colorFilter: context.theme.dividerColor.withValues(alpha: 0.5).toColorFilter,
              ),
              const SizedBox(height: 15),
              Text(
                msg ?? 'No data found!',
                textAlign: TextAlign.center,
                style: context.text.bodyLarge?.copyWith(
                  color: context.theme.dividerColor.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (onPressed != null)
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 30.0,
                  child: TextButton(
                    onPressed: onPressed,
                    style: TextButton.styleFrom(
                      backgroundColor: context.theme.primaryColor.withValues(alpha: 0.3),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    ),
                    child: Text(
                      'Add Category',
                      style: context.text.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.theme.primaryColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
