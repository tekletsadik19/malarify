import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:malarify/core/animations/animation.dart';

import '../../../../core/utils/app_theme/constants.dart';
import '../../../../core/utils/custom_animation.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../ui_components/components/text_input_field.dart';
import '../../../../ui_components/widgets/button_option.dart';
import 'controller/signin_controller.dart';

class SignIn extends ConsumerWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef widgetRef) {
    final signinState = widgetRef.watch(signinProvider);
    final showEmailError = signinState.email.invalid?Email.showEmailErrorMessege(signinState.email.error):null;
    final showPasswordError = signinState.password.invalid?Password.showPasswordErrorMessage(signinState.password.error):null;
    final signinController = widgetRef.read(signinProvider.notifier);
    final bool _isValidated = signinState.status.isValidated;
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        TextInputField(
          hintText: "Email",
          errorText: showEmailError,
          onChanged: (email){
            widgetRef.read(signinProvider.notifier).onEmailChange(email);
          },
        ),
        const SizedBox(
          height: 16,
        ),
        TextInputField(
          isObsecured: true,
          hintText: "Password",
          errorText: showPasswordError,
          onChanged: (password){
            widgetRef.read(signinProvider.notifier).onPasswordChange(password);
          },
        ),
        const SizedBox(
          height: 6,
        ),
        // GestureDetector(
        //   onTap: (){
        //     Navigator.pushNamed(context, ForgotPassword.routeName);
        //   },
        //   child: const Padding(
        //     padding: EdgeInsets.symmetric(vertical: 8),
        //     child: Align(
        //       alignment: Alignment.centerRight,
        //       child: Text(
        //         'Forgot Password',
        //         style: TextStyle(
        //           color: Color(0xFF6574FF)
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        const SizedBox(
          height: 20,
        ),
        Container(
          child: FFButtonWidget(
            onPressed:()async{
              if(!_isValidated){
                return;
              }
              await signinController.signinWithEmailAndPassword(context);
            },
            text: 'Log in',
            showLoadingIndicator: true,
            options: FFButtonOptions(
              width: ResponsiveWidget.isSmallScreen(context)
                  ?screenSize.width/1.5
                  :screenSize.width/3,
              height: 50,
              color: Theme.of(context).colorScheme.secondary,
              textStyle: AppTheme.bodyText1,
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius:BorderRadius.circular(50),
            ),
          ).animated([
            animationsMap[
            'buttonOnPageLoadAnimation1']!
          ]),
        ),
        const SizedBox(
          height: 8,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children:[
              Expanded(child: Divider()),
              Text('OR'),
              Expanded(child: Divider())
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          child: FFButtonWidget(
            onPressed:()async{
              final signinController = widgetRef.read(signinProvider.notifier);
              signinController.signinGoogle(context);
            },
            icon: const Icon(FontAwesomeIcons.google),
            text: 'Login with Google',
            showLoadingIndicator: true,
            options: FFButtonOptions(
              width: ResponsiveWidget.isSmallScreen(context)
                  ?screenSize.width/1.5
                  :screenSize.width/3,
              height: 50,
              color: Theme.of(context).colorScheme.secondary,
              textStyle: AppTheme.bodyText1,
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius:BorderRadius.circular(50),
            ),
          ).animated([
            animationsMap[
            'buttonOnPageLoadAnimation1']!
          ]),
        ),
      ],
    );
  }
}
