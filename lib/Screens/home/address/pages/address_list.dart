import 'package:flutter/material.dart';
import 'package:x_express/Widgets/global_text.dart';
import 'package:x_express/custom_text_form_field.dart';

class Address {
  final String id;
  final String streetAddress;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final bool isDefault;

  Address({
    required this.id,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    this.isDefault = false,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] ?? '',
      streetAddress: json['street_address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipCode: json['zip_code'] ?? '',
      country: json['country'] ?? '',
      isDefault: json['is_default'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'street_address': streetAddress,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      'country': country,
      'is_default': isDefault,
    };
  }

  Address copyWith({
    String? id,
    String? streetAddress,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    bool? isDefault,
  }) {
    return Address(
      id: id ?? this.id,
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  final List<Address> addresses = [
    Address(
      id: '1',
      streetAddress: '123 Main Street',
      city: 'New York',
      state: 'NY',
      zipCode: '10001',
      country: 'USA',
      isDefault: true,
    ),
    Address(
      id: '2',
      streetAddress: '456 Park Avenue',
      city: 'San Francisco',
      state: 'CA',
      zipCode: '94107',
      country: 'USA',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5C3A9E),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        title: GlobalText(
          text: 'Addresses',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final address = addresses[index];
          return AddressCard(
            address: address,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF5C3A9E),
        onPressed: _navigateToAddAddress,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _navigateToAddAddress() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressFormScreen(
          onSave: (newAddress) {
            setState(() {
              addresses.add(newAddress);
            });
          },
        ),
      ),
    );
  }

  void _setDefaultAddress(String id) {
    setState(() {
      for (var i = 0; i < addresses.length; i++) {
        addresses[i] = addresses[i].copyWith(
          isDefault: addresses[i].id == id,
        );
      }
    });
  }
}

class AddressCard extends StatelessWidget {
  final Address address;

  const AddressCard({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade200)],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            color: Color(0xFF5C3A9E),
          ),
          child: Icon(
            Icons.maps_home_work,
            color: Colors.white,
            size: 18,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
          size: 18,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlobalText(
              text: address.streetAddress ?? "",
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade900,
              fontSize: 16,
            ),
            GlobalText(
              text: address.country,
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

class AddressFormScreen extends StatefulWidget {
  final Address? address;
  final Function(Address) onSave;

  const AddressFormScreen({
    super.key,
    this.address,
    required this.onSave,
  });

  @override
  _AddressFormScreenState createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _zipController;
  late TextEditingController _countryController;
  late bool _isDefault;

  @override
  void initState() {
    super.initState();
    final address = widget.address;
    _streetController = TextEditingController(text: address?.streetAddress ?? '');
    _cityController = TextEditingController(text: address?.city ?? '');
    _stateController = TextEditingController(text: address?.state ?? '');
    _zipController = TextEditingController(text: address?.zipCode ?? '');
    _countryController = TextEditingController(text: address?.country ?? '');
    _isDefault = address?.isDefault ?? false;
  }

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.address != null;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF5C3A9E),
        title: GlobalText(
          text: isEditing ? 'Edit Address' : 'Add New Address',
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            CustomTextFormField(
              hintText: "Street Address",
              title: "",
              controller: _streetController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter street address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              hintText: "City",
              title: "",
              controller: _cityController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter city';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    hintText: "State",
                    title: "",
                    controller: _stateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter state';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextFormField(
                    hintText: "Zip Code",
                    title: "",
                    controller: _zipController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter ZIP code';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              hintText: "Coountry",
              title: "",
              controller: _countryController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter country';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            CheckboxListTile(
              title: const Text('Set as default address'),
              value: _isDefault,
              onChanged: (value) {
                setState(() {
                  _isDefault = value ?? false;
                });
              },
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 55),
            ElevatedButton(
              onPressed: _saveAddress,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                backgroundColor: Color(0xFF5C3A9E),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: GlobalText(
                text: isEditing ? 'Update Address' : 'Add Address',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      final address = widget.address != null
          ? widget.address!.copyWith(
        streetAddress: _streetController.text,
        city: _cityController.text,
        state: _stateController.text,
        zipCode: _zipController.text,
        country: _countryController.text,
        isDefault: _isDefault,
      )
          : Address(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        streetAddress: _streetController.text,
        city: _cityController.text,
        state: _stateController.text,
        zipCode: _zipController.text,
        country: _countryController.text,
        isDefault: _isDefault,
      );

      widget.onSave(address);
      Navigator.pop(context);
    }
  }
}
