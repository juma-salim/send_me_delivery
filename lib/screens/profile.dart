import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_me_deliveries/bloc/authentication/authentication_bloc.dart';
import 'package:send_me_deliveries/bloc/get_my_user/get_my_user_bloc.dart';
import 'package:send_me_deliveries/bloc/update_user/update_user_bloc.dart';
import 'package:user_repository/user_repository.dart';

const List<String> location = <String>[
  'Kisumu',
  'Nairobi',
  'Nakuru',
  'Mombasa',
];

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  String dropdownValue = location.first;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.person),
        title: const Text('Profile Screen',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: BlocProvider(
        create: (context) => GetMyUserBloc(
            userRepository: context.read<AuthenticationBloc>().userRepository)
          ..add(GetMyUser(
              userId: user!.uid)), // Add this line to the build method
        child: BlocBuilder<GetMyUserBloc, GetMyUserState>(
          builder: (context, state) {
            print(context.read<AuthenticationBloc>().state.user!.uid);

            if (state.status == MyUserStatus.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == MyUserStatus.success) {
              MyUser user = state.user!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Please complete the form below ')),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Phone Number',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1),
                            ),
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: state.user!.phone == 0
                                ? 'Enter your phone number'
                                : state.user!.phone.toString()),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Email',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.5), width: 1),
                          ),
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: state.user!.email,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('City',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: DropdownButton(
                                    underline: const SizedBox(),
                                    menuWidth:
                                        MediaQuery.of(context).size.width * 0.8,
                                    isExpanded: true,
                                    borderRadius: BorderRadius.circular(30),
                                    value: dropdownValue,
                                    elevation: 3,
                                    icon: const Icon(Icons.expand_more),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: location
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Full Address',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.5), width: 1),
                          ),
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: state.user!.address == ''
                              ? 'Street name, City, P.O. Box 1234'
                              : state.user!.address,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15),
                      BlocBuilder<UpdateUserBloc, UpdateUserState>(
                        builder: (context, state) {
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize:
                                    Size(MediaQuery.of(context).size.width, 50),
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              onPressed: () {
                                final updatedUser = user.copyWith(
                                    phone: _phoneNumberController
                                            .text.isNotEmpty
                                        ? int.parse(_phoneNumberController.text)
                                        : user.phone,
                                    county: dropdownValue.isEmpty
                                        ? user.county
                                        : dropdownValue,
                                    address: _addressController.text.isEmpty
                                        ? user.address
                                        : _addressController.text);
                                context.read<UpdateUserBloc>().add(UpdateUser(
                                      updatedUser,
                                    ));
                              },
                              child: Text('Save Profile',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface)));
                        },
                      )
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: Text('An error occurred'),
            );
          },
        ),
      ),
    );
  }
}
