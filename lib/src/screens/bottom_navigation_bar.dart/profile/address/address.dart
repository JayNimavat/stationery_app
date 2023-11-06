import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/constants/colors.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/address_dialog.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/address_list/bloc_address_list.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/address_list/event_address_list.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/address_list/state_address_list.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/default_address/bloc_default_address.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/popupmenu_dialog/default_popupmenu_dialog.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/popupmenu_dialog/delete_popup_menu_dialog.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/popupmenu_dialog/edit_address_dialog.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddressListBloc>(
          create: (context) => AddressListBloc(),
        ),
        BlocProvider<DefaultAddressBloc>(
          create: (context) => DefaultAddressBloc(),
        ),
      ],
      child: const AddressData(),
    );
  }
}

class AddressData extends StatefulWidget {
  const AddressData({super.key});

  @override
  State<AddressData> createState() => _AddressDataState();
}

class Address {
  final String address;
  final String country;
  final String state;
  final String city;
  final String postalCode;
  final String phone;

  Address({
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.postalCode,
    required this.phone,
  });
}

class _AddressDataState extends State<AddressData> {
  List<Address> addresses = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddressListBloc>(context).add(AddressListDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        title: const Text('Addresses of User'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.redAccent],
            ),
          ),
        ),
      ),
      body: BlocBuilder<AddressListBloc, AddressListState>(
        builder: (context, state) {
          if (state is AddressListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AddressListLoadedState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final newAddress = await showDialog<Address>(
                          context: context,
                          builder: (context) {
                            return const AddressDialog();
                          },
                        );
                        if (newAddress != null) {
                          setState(() {
                            addresses.add(newAddress);
                          });
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 2,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.amber[100],
                          border: Border.all(
                            color: Colors.orange,
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Add Address',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.add,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                      itemCount:
                          state.addressListData.addressListModelData.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        //  Address address = addresses[index];
                        return Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(8),
                          height: 160,
                          width: MediaQuery.of(context).size.width - 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: state.addressListData
                                        .addressListModelData[index].isDefault
                                        .toString() ==
                                    '1'
                                ? Border.all(
                                    color: Colors.blue,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  )
                                : null,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Address: ',
                                      style: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 15,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: state
                                                      .addressListData
                                                      .addressListModelData[
                                                          index]
                                                      .address
                                                      .length >
                                                  28
                                              ? '${state.addressListData.addressListModelData[index].address.substring(0, 28)}...'
                                              : state
                                                  .addressListData
                                                  .addressListModelData[index]
                                                  .address,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  PopupMenuButton(
                                    elevation: 1,
                                    //  iconSize: 5,
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: Colors.blue,
                                    ),
                                    itemBuilder: (context) {
                                      if (state
                                              .addressListData
                                              .addressListModelData[index]
                                              .isDefault
                                              .toString() ==
                                          '0') {
                                        return [
                                          const PopupMenuItem(
                                            value: 'delete',
                                            child: Text(
                                              'Delete',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            value: 'edit',
                                            child: Text('Edit'),
                                          ),
                                          const PopupMenuItem(
                                            value: 'default',
                                            child: Text('Set as Default'),
                                          ),
                                        ];
                                      } else {
                                        return [
                                          const PopupMenuItem(
                                            value: 'delete',
                                            child: Text(
                                              'Delete',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            value: 'edit',
                                            child: Text('Edit'),
                                          ),
                                        ];
                                      }
                                    },
                                    onSelected: (value) {
                                      if (value == 'delete') {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DeletePopupMenuDialog(
                                              id: state
                                                  .addressListData
                                                  .addressListModelData[index]
                                                  .id
                                                  .toString(),
                                            );
                                          },
                                        );
                                      } else if (value == 'edit') {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return EditAddressDialog(
                                              addressId: state
                                                  .addressListData
                                                  .addressListModelData[index]
                                                  .id
                                                  .toString(),
                                              address: state
                                                  .addressListData
                                                  .addressListModelData[index]
                                                  .address,
                                              country: state
                                                  .addressListData
                                                  .addressListModelData[index]
                                                  .country,
                                              state: state
                                                  .addressListData
                                                  .addressListModelData[index]
                                                  .state,
                                              city: state
                                                  .addressListData
                                                  .addressListModelData[index]
                                                  .city,
                                              postalCode: state
                                                  .addressListData
                                                  .addressListModelData[index]
                                                  .pincode
                                                  .toString(),
                                              mobileNo: state
                                                  .addressListData
                                                  .addressListModelData[index]
                                                  .mobileNo,
                                              isDefault: state
                                                  .addressListData
                                                  .addressListModelData[index]
                                                  .isDefault
                                                  .toString(),
                                            );
                                          },
                                        );
                                      } else if (value == 'default') {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DefaultPopupMenuDialog(
                                              addressId: state
                                                  .addressListData
                                                  .addressListModelData[index]
                                                  .id
                                                  .toString(),
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'City: ',
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 15,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: state.addressListData
                                          .addressListModelData[index].city,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'State: ',
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 15,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: state.addressListData
                                          .addressListModelData[index].state,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Country: ',
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 15,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: state.addressListData
                                          .addressListModelData[index].country,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Postal Code: ',
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 15,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: state.addressListData
                                          .addressListModelData[index].pincode
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Phone: ',
                                      style: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 15,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: state
                                              .addressListData
                                              .addressListModelData[index]
                                              .mobileNo,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  state
                                              .addressListData
                                              .addressListModelData[index]
                                              .isDefault
                                              .toString() ==
                                          '1'
                                      ? Text(
                                          'Default Address',
                                          style: TextStyle(
                                            color: Colors.green[500],
                                            fontSize: 13,
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is AddressListErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }
}
