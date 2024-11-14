import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_me_deliveries/bloc/authentication/authentication_bloc.dart';
import 'package:send_me_deliveries/bloc/get_delivery/get_delivery_bloc.dart';
import 'package:send_me_deliveries/bloc/get_my_user/get_my_user_bloc.dart';
import 'package:send_me_deliveries/screens/add_delivery.dart';
import 'package:user_repository/user_repository.dart';

class AppBarContents extends StatefulWidget {
  final Function(String) onSearch;
  const AppBarContents({
    required this.onSearch,
    super.key,
  });

  @override
  State<AppBarContents> createState() => _AppBarContentsState();
}

class _AppBarContentsState extends State<AppBarContents> {
  final TextEditingController _searchController = TextEditingController();

  void _search() {
    final trackingId = _searchController.text;
    if (trackingId.isNotEmpty) {
      widget.onSearch(trackingId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetMyUserBloc(
        userRepository: FirebaseUserRepository(),
      )..add(GetMyUser(
          userId: context.read<AuthenticationBloc>().state.user!.uid)),
      child: BlocBuilder<GetMyUserBloc, GetMyUserState>(
        builder: (context, state) {
          if (state.status == MyUserStatus.success) {
            return FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.3),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(
                                state.user!.county,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Icon(
                                Icons.expand_more,
                                size: 20,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        IconButton.filled(
                          color: Theme.of(context).colorScheme.surface,
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AddDelivery();
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('Lets Track Your Package',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('Please enter your Tracking ID',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 12,
                        )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 50,
                          child: CupertinoTextField(
                            controller: _searchController,
                            style: TextStyle(fontSize: 10),
                            suffix: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  _searchController.clear();
                                },
                                icon: Icon(Icons.cancel),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            placeholderStyle: TextStyle(fontSize: 10),
                            placeholder: 'Enter Tracking ID',
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        IconButton.filled(
                            padding: const EdgeInsets.all(12),
                            onPressed: () {
                              _search;
                            },
                            icon: Icon(
                              CupertinoIcons.search,
                              color: Theme.of(context).colorScheme.surface,
                            ))
                      ],
                    ),
                  )
                ],
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
