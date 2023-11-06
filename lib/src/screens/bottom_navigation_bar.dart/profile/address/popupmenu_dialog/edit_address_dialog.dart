import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/edit_address/bloc_edit_address.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/edit_address/event_edit_address.dart';

class EditAddressDialog extends StatefulWidget {
  final String addressId;
  final String address;
  final String country;
  final String state;
  final String city;
  final String postalCode;
  final String mobileNo;
  final String isDefault;

  const EditAddressDialog({
    super.key,
    required this.addressId,
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.postalCode,
    required this.mobileNo,
    required this.isDefault,
  });

  @override
  State<EditAddressDialog> createState() => _EditAddressDialogState();
}

class _EditAddressDialogState extends State<EditAddressDialog> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EditAddressBloc>(
          create: (context) => EditAddressBloc(),
        ),
      ],
      child: EditAddressDialogScreen(
        addressId: widget.addressId,
        address: widget.address,
        country: widget.country,
        state: widget.state,
        city: widget.city,
        postalCode: widget.postalCode,
        mobileNo: widget.mobileNo,
        isDefault: widget.isDefault,
      ),
    );
  }
}

class EditAddressDialogScreen extends StatefulWidget {
  final String addressId;
  final String address;
  final String country;
  final String state;
  final String city;
  final String postalCode;
  final String mobileNo;
  final String isDefault;

  const EditAddressDialogScreen({
    super.key,
    required this.addressId,
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.postalCode,
    required this.mobileNo,
    required this.isDefault,
  });

  @override
  State<EditAddressDialogScreen> createState() =>
      _EditAddressDialogScreenState();
}

class _EditAddressDialogScreenState extends State<EditAddressDialogScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController(text: widget.address);
    countryController = TextEditingController(text: widget.country);
    stateController = TextEditingController(text: widget.state);
    cityController = TextEditingController(text: widget.city);
    postalCodeController = TextEditingController(text: widget.postalCode);
    phoneController = TextEditingController(text: widget.mobileNo);
    // setState(() {
    //   widget.addressId;
    //   widget.address;
    //   widget.city;
    //   widget.state;
    //   widget.country;
    //   widget.postalCode;
    //   widget.mobileNo;
    // });
  }

  @override
  void dispose() {
    addressController.dispose();
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        height: 525,
        width: 340,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Address*'),
              SizedBox(
                height: 50,
                width: 400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.grey[300],
                  child: Container(
                    padding: const EdgeInsets.only(left: 12),
                    child: TextFormField(
                      autofocus: false,
                      controller: addressController,
                      decoration: const InputDecoration(
                        hintText: "Enter Full Address",
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Country*'),
              SizedBox(
                height: 50,
                width: 400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.grey[300],
                  child: Container(
                    padding: const EdgeInsets.only(left: 12),
                    child: TextFormField(
                      autofocus: false,
                      controller: countryController,
                      decoration: const InputDecoration(
                        hintText: "Enter Country",
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('State*'),
              SizedBox(
                height: 50,
                width: 400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.grey[300],
                  child: Container(
                    padding: const EdgeInsets.only(left: 12),
                    child: TextFormField(
                      autofocus: false,
                      controller: stateController,
                      decoration: const InputDecoration(
                        hintText: "Enter State",
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('City*'),
              SizedBox(
                height: 50,
                width: 400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.grey[300],
                  child: Container(
                    padding: const EdgeInsets.only(left: 12),
                    child: TextFormField(
                      autofocus: false,
                      controller: cityController,
                      decoration: const InputDecoration(
                        hintText: "Enter City",
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Postal Code*'),
              SizedBox(
                height: 50,
                width: 400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.grey[300],
                  child: Container(
                    padding: const EdgeInsets.only(left: 12),
                    child: TextFormField(
                      autofocus: false,
                      controller: postalCodeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Enter Postal Code",
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Phone*'),
              SizedBox(
                height: 50,
                width: 400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.grey[300],
                  child: Container(
                    padding: const EdgeInsets.only(left: 12),
                    child: TextFormField(
                      autofocus: false,
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Enter Phone",
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        BlocProvider.of<EditAddressBloc>(context).add(
                          EditAddressDataEvent(
                              addressId: widget.addressId,
                              address: addressController.text,
                              country: countryController.text,
                              state: stateController.text,
                              city: cityController.text,
                              pincode: postalCodeController.text,
                              isDefault: widget.isDefault,
                              mobileNo: phoneController.text),
                        );
                        _showToast('Edit Address Successfully');
                      });

                      // print(addressController.text);
                      // print(cityController.text);
                      // print(stateController.text);
                      // print(countryController.text);
                      // print(postalCodeController.text);
                      // print(phoneController.text);
                      // print(widget.isDefault);
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
