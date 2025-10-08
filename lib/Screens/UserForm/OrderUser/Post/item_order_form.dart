import 'package:x_express/Utils/exports.dart';

class ItemOrderFormScreen extends StatefulWidget {
  final int? index;

  ItemOrderFormScreen({this.index});
  _ItemOrderFormScreenState createState() => _ItemOrderFormScreenState();
}

class _ItemOrderFormScreenState extends State<ItemOrderFormScreen> {
  final _formKey = GlobalKey<FormState>();

  List items = [];
  var codeController = TextEditingController();
  var itemController = TextEditingController();
  var cartonController = TextEditingController();
  var quantityController = TextEditingController();
  var totalQController = TextEditingController();
  var unitPriceController = TextEditingController();
  var totalPriceController = TextEditingController();
  var packingQuantity = TextEditingController();
  var descriptionController = TextEditingController();
  String uniqueId = '';
  String id = '';
  String orderId = '';

  onSubmit(context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();

      Navigator.of(context)
          .pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => NavigationButtonScreen()), (route) => false);
    } catch (e) {
      print(e);
    }
  }

  List<File?> _images = [];
  final picker = ImagePicker();

  Future getImage(ImageSource source, context) async {
    if (source == ImageSource.camera) {
      final pickedFile = await ImagePickerService.scan(context);
      if (pickedFile != null) {
        setState(() {
          _images.add(pickedFile);
        });
      }
    } else {
      final pickedFile = await ImagePickerService.multiGalleryImage(context);

      for (var value in pickedFile) {
        setState(() {
          _images.add(value);
        });
      }
    }
  }

  void initState() {
    final items = Provider.of<OrderUserServices>(context, listen: false);
    if (widget.index == null) return;
    final item = items.items[widget.index!];
    codeController.text = "${item["itemCode"] ?? "0"}";
    itemController.text = "${item['itemName'] ?? "0"}";
    cartonController.text = intStringValue("${item['packing'] ?? "0"}");
    descriptionController.text = "${item['description'] ?? ""}";
    quantityController.text = intStringValue("${item['quantity'] ?? "0"}");
    packingQuantity.text = intStringValue("${item['packingQuantity'] ?? "0"}");
    unitPriceController.text = intStringValue("${item['unitPrice'] ?? "0"}");
    totalPriceController.text = intStringValue("${item['total'] ?? "0"}");
    id = "${item['id'] ?? ''}";
    uniqueId = "${item['uniqueId'] ?? ""}";
    orderId = "${item['orderId'] ?? ""}";
    super.initState();
  }

  Widget build(BuildContext context) {
    final item = Provider.of<OrderUserServices>(context, listen: false);
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
      },
      child: Scaffold(
          backgroundColor: AppTheme.white,
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: AppTheme.white,
            title: Text(
              widget.index == null ? "Add Item" : "Update Item",
              style: TextStyle(fontSize: 16, color: AppTheme.black),
            ),
          ),
          bottomNavigationBar: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: EdgeInsets.only(bottom: 30, top: 25),
                child: GestureDetector(
                  onTap: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();

                    if (widget.index != null) {
                      final data = item.items[widget.index!];
                      item.removeItems(data['itemCode']);
                      item.addItems({
                        "itemCode": codeController.text,
                        "itemName": itemController.text,
                        "packing": cartonController.text,
                        "packingQuantity": packingQuantity.text,
                        "quantity": quantityController.text,
                        "unitPrice": unitPriceController.text,
                        "discountType": "%",
                        "total": totalPriceController.text,
                        "description": descriptionController.text,
                      });
                    } else {
                      item.addItems({
                        "itemCode": codeController.text,
                        "itemName": itemController.text,
                        "packing": cartonController.text,
                        "packingQuantity": packingQuantity.text,
                        "quantity": quantityController.text,
                        "unitPrice": unitPriceController.text,
                        "discountType": "%",
                        "total": totalPriceController.text,
                        "description": descriptionController.text,
                      });
                    }
                    codeController.clear();
                    itemController.clear();
                    quantityController.clear();
                    packingQuantity.clear();
                    cartonController.clear();
                    totalQController.clear();
                    unitPriceController.clear();
                    totalPriceController.clear();
                    descriptionController.clear();

                    _images.clear();

                    var snackBar = SnackBar(
                        backgroundColor: AppTheme.green,
                        content: Text(
                          widget.index == null ? "Item add successfully" : "Item update successfully",
                          style: TextStyle(color: AppTheme.white),
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    navigator_route_pop();
                    navigator_route_pop();
                  },
                  child: Container(
                    margin: EdgeInsets.all(12),
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppTheme.primary,
                        border: Border.all(width: 0, color: AppTheme.primary),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      widget.index == null ? "Add Item" : "Update Item",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppTheme.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                        textInputType: TextInputType.text,
                        validator: FormValidator.isEmpty,
                        controller: codeController,
                        title: "Code",
                        hintText: "Code",
                        borderType: true,
                        verticalPadding: 8),
                    CustomTextFormField(
                        textInputType: TextInputType.text,
                        // validator: FormValidator.isEmpty,
                        controller: itemController,
                        title: "Item Name",
                        hintText: "Item Name",
                        borderType: true,
                        isRequired: true,
                        verticalPadding: 8),
                    CustomTextFormField(
                      textInputType: TextInputType.text,
                      // validator: FormValidator.isEmpty,
                      controller: descriptionController,
                      title: "Description",
                      hintText: "Description",
                      borderType: true,
                      verticalPadding: 8,
                    ),
                    Row(children: [
                      Expanded(
                        child: CustomTextFormField(
                          textInputType: TextInputType.number,
                          validator: FormValidator.isPhone,
                          controller: cartonController,
                          title: "Carton",
                          hintText: "Carton",
                          borderType: true,
                          verticalPadding: 8,
                          onChange: (value) {
                            cartonController.text = value.replaceFirst(RegExp(r'^0+'), '');
                            onChangeCalculator(
                              type: "packing",
                              packing: value.toString(),
                              packingQuantity: packingQuantity.text,
                              quantity: quantityController.text,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                          child: CustomTextFormField(
                            textInputType: TextInputType.number,
                            validator: FormValidator.isPhone,
                            controller: packingQuantity,
                            title: "Quantity",
                            hintText: "Quantity",
                            borderType: true,
                            verticalPadding: 8,
                            onChange: (value) {
                              quantityController.text = value.replaceFirst(RegExp(r'^0+'), '');
                              value = value;
                              onChangeCalculator(
                                  type: "packing",
                                  packing: cartonController.text,
                                  packingQuantity: value,
                                  quantity: quantityController.text,
                                  unitPrice: unitPriceController.text,
                                  totalPrice: totalPriceController.text);
                            },
                          )),
                      SizedBox(width: 8),
                      Expanded(
                          child: CustomTextFormField(
                            textInputType: TextInputType.number,
                            validator: FormValidator.isPhone,
                            enabled: false,
                            controller: quantityController,
                            title: "Total Qty",
                            hintText: "Total Qty",
                            borderType: true,
                            verticalPadding: 8,
                          ))
                    ]),
                    Row(children: [
                      Expanded(
                          child: CustomTextFormField(
                            textInputType: TextInputType.number,
                            validator: FormValidator.isPhone,
                            controller: unitPriceController,
                            title: "Unit Price",
                            hintText: "Unit Price",
                            borderType: true,
                            verticalPadding: 8,
                            onChange: (value) {
                              onChangeCalculator(
                                packing: cartonController.text,
                                packingQuantity: packingQuantity.text,
                                quantity: "",
                                unitPrice: unitPriceController.text,
                                totalPrice: totalPriceController.text,
                              );
                            },
                          )),
                      SizedBox(width: 8),
                      Expanded(
                        child: CustomTextFormField(
                          enabled: false,
                          textInputType: TextInputType.number,
                          validator: FormValidator.isPhone,
                          controller: totalPriceController,
                          title: "Total Price",
                          hintText: "Total Price",
                          borderType: true,
                          verticalPadding: 8,
                        ),
                      ),
                    ]),
                    SizedBox(height: 100)
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void onChangeCalculator({packing, quantity, packingQuantity, unitPrice, totalPrice, type}) {
    print({packing, quantity, packingQuantity, unitPrice, totalPrice, type});
    print(unitPrice);
    print(totalPrice);
    packing = intParseValue(packing);
    packingQuantity = intParseValue(packingQuantity);
    quantity = intParseValue(quantity);
    unitPrice = doubleParseValue(unitPrice);
    totalPrice = doubleParseValue(totalPrice);

    setState(() {
      if (packing > 0) {
        quantityController.text.isEmpty;
        quantityController.text = "${packing * packingQuantity}";
      } else if (packingQuantity > 0) {
        quantityController.text = packingQuantity.toString();
      }

      if (unitPrice > 0) {
        totalPriceController.text = (packing * unitPrice).toStringAsFixed(2);
      }
    });
  }
}

String intStringValue(dynamic value) {
  if (value == null || value == '') {
    return "";
  } else {
    return double.tryParse(value.toString())!.toInt().toString() ?? "";
  }
}

double doubleParseValue(dynamic value) {
  if (value == null || value == '') {
    return 0.0;
  } else {
    return double.tryParse(value.toString())!;
  }
}

int intParseValue(dynamic value) {
  if (value == null || value == '') {
    return 0;
  } else {
    return int.tryParse(value.toString())!.toInt() ?? 0;
  }
}