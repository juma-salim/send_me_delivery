import 'package:delivery_repository/delivery_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:send_me_deliveries/bloc/authentication/authentication_bloc.dart';
import 'package:send_me_deliveries/bloc/get_delivery/get_delivery_bloc.dart';
import 'package:send_me_deliveries/widgets/app_bar_contents.dart';
import 'package:send_me_deliveries/widgets/home_container_circle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  void _onSearch(BuildContext context, String query) {
    context.read<GetDeliveryBloc>().add(SearchDelivery(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => GetDeliveryBloc(
        deliveryRepository: FirebaseDeliveryRepository(),
      )..add(GetDelivery(context.read<AuthenticationBloc>().state.user!.uid)),
      child: BlocBuilder<GetDeliveryBloc, GetDeliveryState>(
        builder: (context, state) {
          if (state is GetDeliverySuccess) {
            String shortenDeliveryNumber(String deliveryNumber,
                {int maxLength = 5}) {
              if (deliveryNumber.length <= maxLength) {
                return deliveryNumber;
              } else {
                return '${deliveryNumber.substring(0, maxLength)}...';
              }
            }

            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  floating: true,
                  pinned: false,
                  snap: true,
                  stretchTriggerOffset: 300.0,
                  expandedHeight: 250.0,
                  flexibleSpace: AppBarContents(
                      onSearch: (query) => _onSearch(context, query)),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            'Deliveries History',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          trailing:
                              Text('View all', style: TextStyle(fontSize: 13)),
                        ),
                      ),
                      Column(
                          children: List.generate(
                        state.delivery
                            .length, // number of items you want to display
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outline
                                    .withOpacity(0.1),
                                spreadRadius: 3,
                                blurRadius: 4,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                padding: const EdgeInsets.all(20),
                                child: SvgPicture.asset(
                                  'assets/images/package-checking-package-svgrepo-com.svg',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Delivery Number: ${shortenDeliveryNumber(state.delivery[index].deliveryNumber)}',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Delivered on 12/12/2021',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}
