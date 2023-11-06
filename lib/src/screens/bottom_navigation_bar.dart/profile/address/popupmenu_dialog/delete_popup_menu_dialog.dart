import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/remove_address/bloc_remove_address.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/remove_address/event_remove_address.dart';

class DeletePopupMenuDialog extends StatefulWidget {
  final String id;
  const DeletePopupMenuDialog({super.key, required this.id});

  @override
  State<DeletePopupMenuDialog> createState() => _DeletePopupMenuDialogState();
}

class _DeletePopupMenuDialogState extends State<DeletePopupMenuDialog> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoveAddressBloc>(
          create: (context) => RemoveAddressBloc(),
        ),
      ],
      child: PopupDialog(
        id: widget.id,
      ),
    );
  }
}

class PopupDialog extends StatefulWidget {
  final String id;
  const PopupDialog({super.key, required this.id});

  @override
  State<PopupDialog> createState() => _PopupDialogState();
}

class _PopupDialogState extends State<PopupDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm'),
      content: const Text('Are you sure you wish to delete this address?'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            BlocProvider.of<RemoveAddressBloc>(context)
                .add(RemoveAddressBtnEvent(id: widget.id));
            _showToast('Address Removed Successfully');
            // BlocProvider.of<AddressListBloc>(context)
            //     .add(AddressListDataEvent());
          },
          child: const Text('DELETE'),
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
