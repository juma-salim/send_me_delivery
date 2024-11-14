import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:send_me_deliveries/auth_state.dart';
import 'package:send_me_deliveries/bloc/sign_in/sign_in_bloc.dart';
import 'package:send_me_deliveries/regex.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? _emailerrorMsg;
  String? _passworderrorMsg;
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_slash_fill;
  bool signInRequired = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          setState(() {
            signInRequired = false;
          });
        } else if (state is SignInLoading) {
          signInRequired = true;
        } else if (state is SignInFailure) {
          setState(() {
            signInRequired = false;
            _passworderrorMsg = 'Invalid Email or Password';
          });
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: const Text('Welcome Back',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              )
                  .animate()
                  .slideY(
                      duration: 500.ms,
                      begin: 1,
                      end: 0,
                      curve: Curves.easeInOut)
                  .fadeIn(duration: 500.ms),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field';
                  } else if (!emailRexExp.hasMatch(val)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Email',
                ),
              )
                  .animate(delay: 250.ms)
                  .slideY(
                      duration: 500.ms,
                      begin: 1,
                      end: 0,
                      curve: Curves.easeInOut)
                  .fadeIn(duration: 500.ms),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field';
                  } else if (!passwordRexExp.hasMatch(val)) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                        if (obscurePassword) {
                          iconPassword = CupertinoIcons.eye_slash_fill;
                        } else {
                          iconPassword = CupertinoIcons.eye_fill;
                        }
                      });
                    },
                    icon: Icon(iconPassword),
                  ),
                  errorText: _passworderrorMsg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Password',
                ),
              )
                  .animate(delay: 500.ms)
                  .slideY(
                      duration: 500.ms,
                      begin: 1,
                      end: 0,
                      curve: Curves.easeInOut)
                  .fadeIn(duration: 500.ms),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Provider.of<AuthState>(context, listen: false)
                          .toggleAuth();
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              )
                  .animate(delay: 550.ms)
                  .slideY(
                      duration: 500.ms,
                      begin: 1,
                      end: 0,
                      curve: Curves.easeInOut)
                  .fadeIn(duration: 500.ms),
              const SizedBox(height: 20),
              !signInRequired
                  ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignInBloc>().add(SignInRequired(
                                  emailController.text,
                                  passwordController.text));
                            }
                          },
                          child: Text('Sign In',
                              style: TextStyle(color: Colors.white)))
                      .animate(delay: 600.ms)
                      .slideY(
                          duration: 500.ms,
                          begin: 1,
                          end: 0,
                          curve: Curves.easeInOut)
                      .fadeIn(duration: 500.ms)
                  : const Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
