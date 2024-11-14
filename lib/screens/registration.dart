import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:send_me_deliveries/auth_state.dart';
import 'package:send_me_deliveries/bloc/authentication/authentication_bloc.dart';
import 'package:send_me_deliveries/bloc/get_my_user/get_my_user_bloc.dart';
import 'package:send_me_deliveries/bloc/sign_in/sign_in_bloc.dart';
import 'package:send_me_deliveries/bloc/sign_up/sign_up_bloc.dart';
import 'package:send_me_deliveries/screens/main_screen.dart';
import 'package:send_me_deliveries/widgets/sign_in.dart';
import 'package:send_me_deliveries/widgets/sign_up.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return const MainScreen();
          } else if (state.status == AuthenticationStatus.unauthenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                      myUserRepository:
                          context.read<AuthenticationBloc>().userRepository),
                ),
                BlocProvider(
                  create: (context) => SignUpBloc(
                      myUserRepository:
                          context.read<AuthenticationBloc>().userRepository),
                ),
                BlocProvider(
                  create: (context) => GetMyUserBloc(
                      userRepository:
                          context.read<AuthenticationBloc>().userRepository)
                    ..add(GetMyUser(
                        userId: context
                            .read<AuthenticationBloc>()
                            .state
                            .user!
                            .uid)),
                ),
              ],
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.red],
                    begin: Alignment.centerLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    SvgPicture.asset(
                      'assets/images/logistics-delivery-truck-in-movement-svgrepo-com.svg',
                      height: 100,
                      color: Colors.white,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Consumer<AuthState>(
                                builder: (context, authState, child) {
                              return AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                child: authState.isSignIn
                                    ? const SignIn()
                                    : const SignUp(),
                              );
                            }),
                          ),
                        ),
                      ).animate().slideY(
                          duration: 500.ms,
                          begin: 1,
                          end: 0,
                          curve: Curves.easeInOut),
                    )
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
