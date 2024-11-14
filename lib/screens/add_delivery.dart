import 'dart:math';

import 'package:delivery_repository/delivery_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_me_deliveries/bloc/add_delivery/add_delivery_bloc.dart';
import 'package:send_me_deliveries/bloc/authentication/authentication_bloc.dart';
import 'package:send_me_deliveries/bloc/get_my_user/get_my_user_bloc.dart';
import 'package:send_me_deliveries/screens/registration.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

const List<String> list = <String>[
  'Electronic',
  'Clothes',
  'Documents',
  'Cosmetic',
  'Household',
  'Others'
];
const List<String> location = <String>[
  'Kisumu',
  'Nairobi',
  'Nakuru',
  'Mombasa',
];

class AddDelivery extends StatefulWidget {
  const AddDelivery({super.key});

  @override
  State<AddDelivery> createState() => _AddDeliveryState();
}

class _AddDeliveryState extends State<AddDelivery> {
  bool isDeliverySuccess = false;
  TextEditingController _deliveryAddressController = TextEditingController();
  TextEditingController _recipientEmailController = TextEditingController();
  TextEditingController _recipientFirstNameController = TextEditingController();
  TextEditingController _recipientLastNameController = TextEditingController();
  TextEditingController _recipientPhoneController = TextEditingController();
  TextEditingController _deliveryContyController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  final Uuid uuid = Uuid();
  @override
  void dispose() {
    _deliveryAddressController.dispose();
    _recipientEmailController.dispose();
    _recipientFirstNameController.dispose();
    _recipientLastNameController.dispose();
    _recipientPhoneController.dispose();
    _deliveryContyController.dispose();
    _weightController.dispose();

    super.dispose();
  }

  void _resetControllers() {
    setState(() {
      _deliveryAddressController.clear();
      _recipientEmailController.clear();
      _recipientFirstNameController.clear();
      _recipientLastNameController.clear();
      _recipientPhoneController.clear();
      _deliveryContyController.clear();
      _weightController.clear();
    });
  }

  String _generateRandomString(int length) {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));
  }

  String dropdownValue = list.first;
  String locationValue = location.first;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Delivery'),
      ),
      body: isDeliverySuccess
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child:
                        Icon(Icons.check_circle, color: Colors.green, size: 50)
                            .animate()
                            .fadeIn(
                              duration: Duration(seconds: 1),
                            ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Delivery Added Successfully'),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      _resetControllers();
                      setState(() {
                        isDeliverySuccess = false;
                      });
                    },
                    child: const Text('Add Another Delivery',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.secondary),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add Another Delivery'),
                  ),
                ],
              ),
            )
          : BlocProvider(
              create: (context) => GetMyUserBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository)
                ..add(GetMyUser(userId: user!.uid)),
              child: BlocBuilder<GetMyUserBloc, GetMyUserState>(
                builder: (context, state) {
                  if (state.status == MyUserStatus.success) {
                    MyUser? myUser = state.user;
                    calculateBeforePrice() {
                      double locationrange;
                      double finalPrice = 0.0;
                      int weight = int.tryParse(_weightController.text) ?? 0;

                      if (weight == 0) {
                        return 0.0; // Handle invalid weight input
                      }

                      myUser!.county == locationValue
                          ? locationrange = 1.5
                          : locationrange = 2.5;

                      if (dropdownValue == 'Electronic') {
                        finalPrice = 500 * locationrange * weight;
                      } else if (dropdownValue == 'Clothes') {
                        finalPrice = 200 * locationrange * weight;
                        ;
                      } else if (dropdownValue == 'Documents') {
                        finalPrice = 150 * locationrange * weight;
                        ;
                      } else if (dropdownValue == 'Cosmetic') {
                        finalPrice = locationrange * weight;
                        ;
                      } else if (dropdownValue == 'Household') {
                        finalPrice = locationrange * weight;
                      }

                      return finalPrice.toString();
                    }

                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Please complete the form below',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _deliveryAddressController,
                                      decoration: InputDecoration(
                                        labelText: 'Delivery Address',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    TextField(
                                      controller: _recipientEmailController,
                                      decoration: InputDecoration(
                                        labelText: 'Recipients Email',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: TextField(
                                            controller:
                                                _recipientFirstNameController,
                                            style:
                                                const TextStyle(fontSize: 10),
                                            decoration: InputDecoration(
                                              labelText: 'First Name',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: TextField(
                                            controller:
                                                _recipientLastNameController,
                                            style: TextStyle(fontSize: 10),
                                            decoration: InputDecoration(
                                              labelText: 'Last Name',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
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
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        isExpanded: true,
                                        borderRadius: BorderRadius.circular(30),
                                        value: locationValue,
                                        elevation: 3,
                                        icon: const Icon(Icons.expand_more),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            locationValue = value!;
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
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    TextField(
                                      controller: _recipientPhoneController,
                                      decoration: InputDecoration(
                                        labelText: 'Recipients Phone',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Item Type',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.005),
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
                                            MediaQuery.of(context).size.width *
                                                0.8,
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
                                        items: list
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    TextField(
                                      keyboardType: TextInputType.number,
                                      controller: _weightController,
                                      style: const TextStyle(fontSize: 10),
                                      decoration: InputDecoration(
                                        labelText: 'Enter Weight',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Row(
                              children: [
                                IconButton.filled(
                                    onPressed: () {
                                      setState(() {});
                                      calculateBeforePrice();
                                    },
                                    icon: Icon(Icons.attach_money,
                                        color: Colors.white)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  calculateBeforePrice() == '0.0'
                                      ? 'Price'
                                      : 'Ksh ${calculateBeforePrice()}',
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 50,
                                child: BlocConsumer<AddDeliveryBloc,
                                    AddDeliveryState>(
                                  listener: (context, state) {
                                    if (state is AddDeliverySuccess) {
                                      setState(() {
                                        isDeliverySuccess = true;
                                      });
                                    }
                                  },
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      onPressed: () {
                                        calculatePrice() {
                                          double locationrange;
                                          double finalPrice = 0.0;

                                          myUser!.county == locationValue
                                              ? locationrange = 1.5
                                              : locationrange = 2.5;

                                          if (dropdownValue == 'Electronic') {
                                            finalPrice = 500 *
                                                locationrange *
                                                int.parse(
                                                    _weightController.text);
                                          } else if (dropdownValue ==
                                              'Clothes') {
                                            finalPrice = 200 *
                                                locationrange *
                                                int.parse(
                                                    _weightController.text);
                                            ;
                                          } else if (dropdownValue ==
                                              'Documents') {
                                            finalPrice = 150 *
                                                locationrange *
                                                int.parse(
                                                    _weightController.text);
                                            ;
                                          } else if (dropdownValue ==
                                              'Cosmetic') {
                                            finalPrice = locationrange *
                                                int.parse(
                                                    _weightController.text);
                                            ;
                                          } else if (dropdownValue ==
                                              'Household') {
                                            finalPrice = locationrange *
                                                int.parse(
                                                    _weightController.text);
                                          }

                                          return finalPrice.toString();
                                        }

                                        Delivery delivery = Delivery(
                                            deliveryWeight: int.parse(
                                                _weightController.text),
                                            deliveryPrice: calculatePrice(),
                                            deliveryCounty: locationValue,
                                            userId: user!.uid,
                                            deliveryNumber: uuid.v1(),
                                            deliveryDate: DateTime.now(),
                                            deliveryStatus: 'Pending',
                                            senderName: myUser!.name,
                                            senderPhone:
                                                myUser.phone.toString(),
                                            senderEmail: myUser.email,
                                            deliveryAddress:
                                                _deliveryAddressController.text,
                                            recipientEmail:
                                                _recipientEmailController.text,
                                            recipientName:
                                                _recipientFirstNameController
                                                        .text +
                                                    '' +
                                                    _recipientLastNameController
                                                        .text,
                                            recipientPhone:
                                                _recipientPhoneController.text,
                                            deliveryType: dropdownValue);
                                        context.read<AddDeliveryBloc>().add(
                                              CreateDelivery(delivery),
                                            );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          Text('Add Delivery',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface))
                                        ],
                                      ),
                                    );
                                  },
                                )),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: _resetControllers,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.restore,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    Text('Reset',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
    );
  }
}
