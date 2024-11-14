import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:send_me_deliveries/auth_state.dart';
import 'package:send_me_deliveries/bloc/sign_up/sign_up_bloc.dart';
import 'package:send_me_deliveries/regex.dart';
import 'package:user_repository/user_repository.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool signUpRequired = false;
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_slash_fill;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            setState(() {
              signUpRequired = false;
            });
          } else if (state is SignUpProcess) {
            setState(() {
              signUpRequired = true;
            });
          } else if (state is SignUpFailure) {
            return;
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: const Text('Welcome',
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
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field';
                  } else if (!emailRexExp.hasMatch(val)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(CupertinoIcons.mail_solid),
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
                controller: _nameController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field';
                  } else if (val.length > 30) {
                    return 'Name too long';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(CupertinoIcons.person_fill),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Name',
                ),
              )
                  .animate(delay: 350.ms)
                  .slideY(
                      duration: 500.ms,
                      begin: 1,
                      end: 0,
                      curve: Curves.easeInOut)
                  .fadeIn(duration: 500.ms),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: obscurePassword,
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
                        iconPassword = obscurePassword
                            ? CupertinoIcons.eye_slash_fill
                            : CupertinoIcons.eye_fill;
                      });
                    },
                    icon: Icon(iconPassword),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Password',
                ),
              )
                  .animate(delay: 450.ms)
                  .slideY(
                      duration: 500.ms,
                      begin: 1,
                      end: 0,
                      curve: Curves.easeInOut)
                  .fadeIn(duration: 500.ms),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Provider.of<AuthState>(context, listen: false)
                          .toggleAuth();
                    },
                    child: const Text('Sign In'),
                  ),
                ],
              )
                  .animate(delay: 500.ms)
                  .slideY(
                      duration: 500.ms,
                      begin: 1,
                      end: 0,
                      curve: Curves.easeInOut)
                  .fadeIn(duration: 500.ms),
              const SizedBox(height: 20),
              !signUpRequired
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
                              MyUser myUser = MyUser.empty;
                              myUser = myUser.copyWith(
                                email: _emailController.text,
                                name: _nameController.text,
                              );
                              setState(() {
                                context.read<SignUpBloc>().add(SignUpRequired(
                                    user: myUser,
                                    password: _passwordController.text));
                              });
                            }
                          },
                          child: Text('Sign Up',
                              style: TextStyle(color: Colors.white)))
                      .animate(delay: 600.ms)
                      .slideY(
                          duration: 500.ms,
                          begin: 1,
                          end: 0,
                          curve: Curves.easeInOut)
                      .fadeIn(duration: 500.ms)
                  : const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
