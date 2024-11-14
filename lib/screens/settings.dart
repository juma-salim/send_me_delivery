import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_me_deliveries/bloc/sign_in/sign_in_bloc.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          const Center(
            child: const Text('Welcome to the Settings Screen'),
          ),
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<SignInBloc>().add(SignOutRequired());
                },
                child: const Text('Sign Out'),
              );
            },
          ),
        ],
      ),
    );
  }
}
