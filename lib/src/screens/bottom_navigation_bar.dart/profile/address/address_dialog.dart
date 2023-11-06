import 'package:flutter/material.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/address.dart';

class AddressDialog extends StatefulWidget {
  const AddressDialog({super.key});

  @override
  State<AddressDialog> createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  @override
  Widget build(BuildContext context) {
    return const AddressDialogScreen();
  }
}

class AddressDialogScreen extends StatefulWidget {
  const AddressDialogScreen({super.key});

  @override
  State<AddressDialogScreen> createState() => _AddressDialogScreenState();
}

class _AddressDialogScreenState extends State<AddressDialogScreen> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

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
                      final newAddress = Address(
                        address: addressController.text,
                        country: countryController.text,
                        state: stateController.text,
                        city: cityController.text,
                        postalCode: postalCodeController.text,
                        phone: phoneController.text,
                      );
                      Navigator.of(context).pop(newAddress);
                    },
                    child: const Text('Add'),
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
