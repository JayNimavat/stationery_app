import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/default_address/bloc_default_address.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/default_address/event_default_address.dart';

class DefaultPopupMenuDialog extends StatefulWidget {
  final String addressId;
  const DefaultPopupMenuDialog({super.key, required this.addressId});

  @override
  State<DefaultPopupMenuDialog> createState() => _DefaultPopupMenuDialogState();
}

class _DefaultPopupMenuDialogState extends State<DefaultPopupMenuDialog> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DefaultAddressBloc>(
          create: (context) => DefaultAddressBloc(),
        ),
        // BlocProvider<AddressListBloc>(
        //   create: (context) => AddressListBloc(),
        // ),
      ],
      child: PopupMenuDialog(
        addressId: widget.addressId,
      ),
    );
  }
}

class PopupMenuDialog extends StatefulWidget {
  final String addressId;
  const PopupMenuDialog({super.key, required this.addressId});

  @override
  State<PopupMenuDialog> createState() => _PopupMenuDialogState();
}

class _PopupMenuDialogState extends State<PopupMenuDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm'),
      content:
          const Text('Are you sure you wish to make this address default?'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            BlocProvider.of<DefaultAddressBloc>(context).add(
                DefaultAddressDataEvent(
                    addressId: widget.addressId, isDefault: '1'));
            // BlocProvider.of<AddressListBloc>(context)
            //     .add(AddressListDataEvent());
            _showToast('Default Address Successfully');
          },
          child: const Text('OK'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('CANCEL'),
        ),
      ],
    );
  }
}

void _showToast(String message) {
  // Show a toast message
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black45,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
