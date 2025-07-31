import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/features/login/provider/login_provider.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/border_radius.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class GlobalElevatedButton extends ConsumerWidget {
  const GlobalElevatedButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ElevatedButton(
      onPressed:ref.watch(loginProvider).isLoading == false? () async {
        //check internet connection
        final isConnected = await ref.read(loginProvider.notifier).checkInternetConnection();
        if (!isConnected) {
          return;
        }
        
        final User? user = await ref.read(loginProvider.notifier).signInWithEmailAndPassword();
        final emailVerifiedResult = user?.emailVerified;
        ref.read(loginProvider.notifier).setEmailVerified(emailVerifiedResult ?? false);
        if (user != null && user.emailVerified) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${user.email ?? ''} email adresine giriş yapıldı')));

          Future.delayed(Duration(seconds: 2), () {
            NavigatorManager.instance.navigatePage(context, HomeView());
          });

        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email veya şifre hatalı')));
        
        }
      }:null,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusConstants.instance.circularSmallBorderRadius,
        ),
        minimumSize: Size(double.infinity, WidgetSizeEnum.loginButtonHeight.value),
    
        backgroundColor: ColorName.sizzlingRed.withOpacity(0.8),
        padding: PaddingsConstants.instance.loginButtonPadding,
      ),
      child: ref.watch(loginProvider).isLoading ?  NormalText(text: text, color: ColorName.whiteColor, fontSize: 15) :const CircularProgressIndicator(),
    );
  }
}
