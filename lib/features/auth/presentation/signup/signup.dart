import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_validators/form_validators.dart';
import 'package:malarify/core/animations/animation.dart';


import '../../../../core/utils/app_theme/constants.dart';
import '../../../../core/utils/custom_animation.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../ui_components/components/text_input_field.dart';
import '../../../../ui_components/widgets/button_option.dart';
import 'controller/signup_controller.dart';



class SignUp extends ConsumerWidget {
  const SignUp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context,WidgetRef widgetRef) {
    final signupState = widgetRef.watch(signupProvider);
    final showNameError =  signupState.name.invalid?Name.showNameErrorMessege(signupState.name.error):null;
    final showEmailError = signupState.email.invalid?Email.showEmailErrorMessege(signupState.email.error):null;
    final showPasswordError = signupState.password.invalid?Password.showPasswordErrorMessage(signupState.password.error):null;
    final signupController = widgetRef.read(signupProvider.notifier);
    final bool _isValidated = signupState.status.isValidated;
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        TextInputField(
          hintText: "Username",
          errorText: showNameError,
          onChanged: (name){
            widgetRef.read(signupProvider.notifier).onNameChange(name);
          },
        ),
        const SizedBox(
          height: 16,
        ),
        TextInputField(
          hintText: "Email",
          errorText: showEmailError,
          onChanged: (email){
            widgetRef.read(signupProvider.notifier).onEmailChange(email);
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
            widgetRef.read(signupProvider.notifier).onPasswordChange(password);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          child: FFButtonWidget(
            onPressed:()async{
              if(!_isValidated){
                return;
              }
              await signupController.signupWithEmailAndPassword(context);
            },
            text:  "Sign Up",
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
            onPressed:(){
              signupController.signupGoogle(context);
            },
            icon: const Icon(FontAwesomeIcons.google),
            text: 'signup with Google',
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
