import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_messaging_system/common/widgets/action_button.dart';
import 'package:libary_messaging_system/common/widgets/custom_text_field.dart';
import 'package:libary_messaging_system/router.gr.dart';
import 'package:libary_messaging_system/screens/authentication/bloc/auth_bloc.dart';
import 'package:libary_messaging_system/screens/authentication/bloc/auth_event.dart';
import 'package:libary_messaging_system/screens/authentication/bloc/auth_state.dart';
import 'package:libary_messaging_system/screens/authentication/models/login_model.dart';
import 'package:libary_messaging_system/utils/utils.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController pswdCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) => _processListener(state),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state.status == AuthStatus.loading,
            child: Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Enter your department\'s login details',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          labelText: 'Email',
                          controller: emailCtrl,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your email address';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          maxLines: 1,
                          controller: pswdCtrl,
                          labelText: 'Password',
                          isPasswordField: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your valid password';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        ActionButton(
                          title: 'Login',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              authBloc.add(
                                LoginRequestEvent(
                                  loginModel: LoginModel(
                                    password: pswdCtrl.text,
                                    email: emailCtrl.text,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _processListener(AuthState state) {
    switch (state.status) {
      case AuthStatus.authenticated:
        context.replaceRoute(HomeScreen());
        break;
      case AuthStatus.unauthenticated:
        break;
      case AuthStatus.error:
        showSnackbar(context: context, content: state.error!);
        break;
      default:
        break;
    }
  }
}
