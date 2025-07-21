import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/features/onboarding/onboarding_provider.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: PaddingsConstants.onboardingLeadingPadding,
        child: Text("${ref.watch(onboardingProvider).currentPage + 1}/${ref.watch(onboardingProvider).totalPages}"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.route.navigateToPage(const LoginWelcomeBack());
            if(SecureStorageKeys.hasSeenOnboarding.readKeys() == 'false'){
              SecureStorageKeys.hasSeenOnboarding.writeKeys('true');
            }
          }, 
          child: Text(
            LocaleKeys.skip.tr(),
            style: context.general.appTheme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
} 