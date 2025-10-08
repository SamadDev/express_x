import 'package:x_express/Utils/exports.dart';

class ItemFormScreen extends StatefulWidget {
  final int? index;

  ItemFormScreen({this.index});
  _ItemFormScreenState createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();

  List items = [];
  var codeController = TextEditingController();
  var itemController = TextEditingController();
  var cartonController = TextEditingController();
  var quantityController = TextEditingController();
  var totalQController = TextEditingController();
  var heightController = TextEditingController();
  var widthController = TextEditingController();
  var totalCbmController = TextEditingController();
  var lengthController = TextEditingController();
  var weightController = TextEditingController();
  var totalWController = TextEditingController();
  var cbmController = TextEditingController();
  var packingQuantity = TextEditingController();
  var descriptionController = TextEditingController();
  String uniqueId = '';
  String id = '';
  String orderId = '';
  String itemId = '';
  var uuid = Uuid().v1();

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

  List<File?> _imagesFile = [];
  List _imagesLink = [];
  final picker = ImagePicker();

  Future getImage(ImageSource source, context) async {
    if (source == ImageSource.camera) {
      final pickedFile = await ImagePickerService.scan(context);
      if (pickedFile != null) {
        setState(() {
          _imagesFile.add(pickedFile);
        });
      }
    } else {
      final pickedFile = await ImagePickerService.multiGalleryImage(context);
      for (var value in pickedFile) {
        setState(() {
          _imagesFile.add(value);
        });
      }
    }
  }

  void didChangeDependencies() async {
    final items = Provider.of<UserFormService>(context, listen: false);

    items.itemType = 0;
    if (widget.index == null) return;

    final item = items.items[widget.index!];
    await items.getImagesByUuId(item['uniqueId']);
    _imagesLink = items.imageListWithUuId;
    codeController.text = "${item["itemCode"] ?? ""}";
    itemController.text = "${item['itemName'] ?? ""}";
    cartonController.text = intStringValue("${item['packing'] ?? ""}");
    quantityController.text = intStringValue("${item['quantity'] ?? ""}");
    packingQuantity.text = intStringValue("${item['packingQuantity'] ?? ""}");
    lengthController.text = intStringValue("${item['length'] ?? ""}");
    widthController.text = intStringValue("${item['width'] ?? ""}");
    descriptionController.text = "${item['description'] ?? ""}";
    heightController.text = intStringValue("${item['height'] ?? ""}");
    totalCbmController.text = "${item['totalCBM'] ?? ""}";
    cbmController.text = "${item['cbm'] ?? ""}";
    weightController.text = "${item['weight'] ?? ""}";
    totalWController.text = "${item['totalWeight'] ?? ""}";
    id = "${item['id'] ?? ''}";
    uuid = "${item['uniqueId'] ?? ""}";
    orderId = "${item['orderId'] ?? ""}";
    super.didChangeDependencies();
  }

  TabController? _controller;
  Widget build(BuildContext context) {
    final item = Provider.of<UserFormService>(context, listen: false);
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
                  onTap: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    LoadingDialog(context);
                    final isEditMode = widget.index != null;
                    final data = isEditMode ? item.items[widget.index!] : null;
                    final itemMap = {
                      "uniqueId": uuid,
                      "itemCode": codeController.text,
                      "itemName": itemController.text,
                      "itemId": itemId ?? "",
                      "description": descriptionController.text,
                      // "images": _imagesFile,
                      "packing": cartonController.text,
                      "packingQuantity": quantityController.text,
                      "quantity": quantityController.text,
                      "length": lengthController.text,
                      "width": widthController.text,
                      "height": heightController.text,
                      "cbm": cbmController.text,
                      "totalCBM": totalCbmController.text,
                      "weight": weightController.text,
                      "totalWeight": totalWController.text,
                    };

                    // if (itemId.isEmpty) {
                    //   item.addItems({...itemMap, "itemId": itemId});
                    // }

                    if (isEditMode) {
                      // if (data == null || data['id'] == null || data['uniqueId'] == null) {
                      await item.postItemImage(context: context, images: _imagesFile, uuId: uuid);
                      item.removeItems(data!['itemCode']);
                      // }
                      // else {
                      //   item.removeItems(data['itemCode']);
                      // }
                      item.addItems({...itemMap, "id": id.toString(), "orderId": data?['orderId'] ?? orderId});
                    } else {
                      await item.postItemImage(context: context, images: _imagesFile, uuId: uuid);
                      item.addItems(itemMap);
                    }

                    codeController.clear();
                    itemController.clear();
                    quantityController.clear();
                    packingQuantity.clear();
                    lengthController.clear();
                    widthController.clear();
                    heightController.clear();
                    totalCbmController.clear();
                    weightController.clear();
                    totalWController.clear();
                    cartonController.clear();
                    totalQController.clear();
                    descriptionController.clear();
                    cbmController.clear();
                    uuid = '';
                    itemId = '';

                    var snackBar = SnackBar(
                        backgroundColor: AppTheme.green,
                        content: Text(
                          widget.index == null ? "Item add successfully" : "Item updated successfully",
                          style: TextStyle(color: AppTheme.white),
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    navigator_route_pop(context: context);
                    navigator_route_pop(context: context);
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
          body: DefaultTabController(
            length: 2,
            child: Consumer<UserFormService>(
                builder: (ctx, item, _) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 12),
                                height: 38,
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  borderRadius: BorderRadius.circular(
                                    8.0,
                                  ),
                                ),
                                child: TabBar(
                                  controller: _controller,
                                  indicator:
                                      BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: AppTheme.primary),
                                  labelColor: AppTheme.white,
                                  labelPadding: EdgeInsets.zero,
                                  unselectedLabelColor: AppTheme.black,
                                  isScrollable: false,
                                  onTap: (value) {
                                    item.setItemType(value);
                                  },
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: [Tab(text: "Detail"), Tab(text: "Summary")],
                                ),
                              ),
                              SizedBox(height: 10),
                              CustomTextFormField(
                                  textInputType: TextInputType.text,
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
                              if (item.itemType == 1) ...[
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
                                        item.itemType == 1
                                            ? ""
                                            : onChangeCalculator(
                                                type: "packing",
                                                packing: value.toString(),
                                                packingQuantity: packingQuantity.text,
                                                quantity: quantityController.text,
                                                width: widthController.text,
                                                cbm: cbmController.text,
                                                height: heightController.text,
                                                length: lengthController.text,
                                                totalCBM: totalCbmController.text,
                                                totalWeight: totalWController.text,
                                                weight: weightController.text,
                                              );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: CustomTextFormField(
                                      textInputType: TextInputType.number,
                                      validator: FormValidator.isPhone,
                                      controller: totalWController,
                                      title: "Total Weight",
                                      hintText: "Total Weight",
                                      borderType: true,
                                      verticalPadding: 8,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                      child: CustomTextFormField(
                                    textInputType: TextInputType.number,
                                    validator: FormValidator.isPhone,
                                    controller: totalCbmController,
                                    title: "Total CBM",
                                    hintText: "Total CBM",
                                    borderType: true,
                                    verticalPadding: 8,
                                  ))
                                ]),
                              ],
                              if (item.itemType == 0) ...[
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
                                        item.itemType == 1
                                            ? ""
                                            : onChangeCalculator(
                                                type: "packing",
                                                packing: value.toString(),
                                                packingQuantity: packingQuantity.text,
                                                quantity: quantityController.text,
                                                width: widthController.text,
                                                cbm: cbmController.text,
                                                height: heightController.text,
                                                length: lengthController.text,
                                                totalCBM: totalCbmController.text,
                                                totalWeight: totalWController.text,
                                                weight: weightController.text,
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
                                      value = value;
                                      onChangeCalculator(
                                        type: "packing",
                                        packing: cartonController.text,
                                        packingQuantity: value,
                                        quantity: quantityController.text,
                                        width: widthController.text,
                                        cbm: cbmController.text,
                                        height: heightController.text,
                                        length: lengthController.text,
                                        totalCBM: totalCbmController.text,
                                        totalWeight: totalWController.text,
                                        weight: weightController.text,
                                      );
                                    },
                                  )),
                                  SizedBox(width: 8),
                                  Expanded(
                                      child: CustomTextFormField(
                                    enabled: false,
                                    textInputType: TextInputType.number,
                                    validator: FormValidator.isPhone,
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
                                    controller: heightController,
                                    title: "Height",
                                    hintText: "Height",
                                    borderType: true,
                                    verticalPadding: 8,
                                    onChange: (value) {
                                      heightController.text = value.replaceFirst(RegExp(r'^0+'), '');
                                      onChangeCalculator(
                                        packing: cartonController.text,
                                        packingQuantity: packingQuantity.text,
                                        quantity: quantityController.text,
                                        width: widthController.text,
                                        cbm: cbmController.text,
                                        height: value,
                                        length: lengthController.text,
                                        totalCBM: totalCbmController.text,
                                        totalWeight: totalWController.text,
                                        weight: weightController.text,
                                      );
                                    },
                                  )),
                                  SizedBox(width: 7),
                                  Expanded(
                                      child: CustomTextFormField(
                                    textInputType: TextInputType.number,
                                    validator: FormValidator.isPhone,
                                    controller: widthController,
                                    title: "Width",
                                    hintText: "Width",
                                    borderType: true,
                                    verticalPadding: 8,
                                    onChange: (value) {
                                      widthController.text = value.replaceFirst(RegExp(r'^0+'), '');
                                      onChangeCalculator(
                                        packing: cartonController.text,
                                        packingQuantity: packingQuantity.text,
                                        quantity: quantityController.text,
                                        width: value,
                                        cbm: cbmController.text,
                                        height: heightController.text,
                                        length: lengthController.text,
                                        weight: weightController.text,
                                        totalCBM: totalCbmController.text,
                                        totalWeight: totalWController.text,
                                      );
                                    },
                                  )),
                                  SizedBox(width: 8),
                                  Expanded(
                                      child: CustomTextFormField(
                                    textInputType: TextInputType.number,
                                    validator: FormValidator.isPhone,
                                    controller: lengthController,
                                    title: "Length",
                                    hintText: "Length",
                                    borderType: true,
                                    verticalPadding: 8,
                                    onChange: (value) {
                                      lengthController.text = value.replaceFirst(RegExp(r'^0+'), '');
                                      onChangeCalculator(
                                        packing: cartonController.text,
                                        packingQuantity: packingQuantity.text,
                                        quantity: quantityController.text,
                                        width: widthController.text,
                                        cbm: cbmController.text,
                                        height: heightController.text,
                                        length: value,
                                        totalCBM: totalCbmController.text,
                                        totalWeight: totalWController.text,
                                        weight: weightController.text,
                                      );
                                    },
                                  )),
                                ]),
                                Row(children: [
                                  Expanded(
                                      child: CustomTextFormField(
                                    textInputType: TextInputType.number,
                                    controller: cbmController,
                                    title: "CBM",
                                    hintText: "CBM",
                                    borderType: true,
                                    verticalPadding: 8,
                                    onChange: (value) {
                                      cbmController.text = value.replaceFirst(RegExp(r'^0.0+'), '');
                                    },
                                  )),
                                  SizedBox(width: 8),
                                  Expanded(
                                      child: CustomTextFormField(
                                    textInputType: TextInputType.number,
                                    validator: FormValidator.isPhone,
                                    controller: totalCbmController,
                                    enabled: false,
                                    title: "Total CBM",
                                    hintText: "Total CBM",
                                    borderType: true,
                                    verticalPadding: 8,
                                    onChange: (value) {
                                      totalCbmController.text = value.replaceFirst(RegExp(r'^0.0+'), '');
                                    },
                                  )),
                                ]),
                                Row(children: [
                                  Expanded(
                                      child: CustomTextFormField(
                                    textInputType: TextInputType.number,
                                    validator: FormValidator.isPhone,
                                    controller: weightController,
                                    title: "Weight",
                                    hintText: "Weight",
                                    borderType: true,
                                    verticalPadding: 8,
                                    onChange: (value) {
                                      weightController.text = value.replaceFirst(RegExp(r'^0.0+'), '');
                                      onChangeCalculator(
                                        packing: cartonController.text,
                                        packingQuantity: packingQuantity.text,
                                        quantity: "",
                                        width: "",
                                        cbm: "",
                                        height: "",
                                        length: "",
                                        totalCBM: "",
                                        totalWeight: "",
                                        weight: value,
                                      );
                                    },
                                  )),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: CustomTextFormField(
                                      textInputType: TextInputType.number,
                                      validator: FormValidator.isPhone,
                                      controller: totalWController,
                                      enabled: false,
                                      title: "Total Weight",
                                      hintText: "Total Weight",
                                      borderType: true,
                                      verticalPadding: 8,
                                    ),
                                  ),
                                ])
                              ],
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        title: const Text(
                                          "Image from:",
                                          style: TextStyle(fontSize: 26),
                                        ),
                                        content: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextButton(
                                                onPressed: () async {
                                                  await getImage(ImageSource.gallery, context);
                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(Icons.image, color: AppTheme.primary, size: 22),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                      "From gallery",
                                                      style: TextStyle(
                                                          fontFamily: "sf_med", fontSize: 16, color: AppTheme.black),
                                                    ),
                                                  ],
                                                )),
                                            const Divider(),
                                            TextButton(
                                              onPressed: () async {
                                                await getImage(ImageSource.camera, context);
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: const [
                                                  Icon(Icons.camera_alt_rounded, color: AppTheme.primary, size: 22),
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  Text(
                                                    "From Camera",
                                                    style: TextStyle(
                                                        fontFamily: "sf_med", fontSize: 16, color: AppTheme.black),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: CustomTextFormField(
                                  title: "Upload Image",
                                  hintText: "Upload Image",
                                  borderType: true,
                                  verticalPadding: 8,
                                  enabled: false,
                                  suffix: Icon((_imagesFile.isEmpty && _imagesLink.isEmpty) ? Icons.link : Icons.add),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(
                                      _imagesLink.length,
                                      (index) {
                                        if (_imagesLink[index] != null) {
                                          return Stack(
                                            alignment: Alignment.topRight,
                                            clipBehavior: Clip.hardEdge,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context).size.width * .31,
                                                width: MediaQuery.of(context).size.width * .31,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Image.network(
                                                    dotenv.env['UPLOADURLDOMAIN']! + _imagesLink[index]['url'],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 4,
                                                right: 4,
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle, color: Colors.grey.withOpacity(.3)),
                                                  child: FittedBox(
                                                    child: IconButton(
                                                      icon: const Icon(Icons.delete),
                                                      color: Colors.red,
                                                      onPressed: () => areYouSure(
                                                          onPress: () async {
                                                            await item.removeImagesByUuId(_imagesLink[index]['id']);
                                                            _imagesLink.remove(_imagesLink[index]);
                                                            navigator_route_pop(context: context);
                                                          },
                                                          context: context,
                                                          content: "Are you sure to Remove this image",
                                                          title: "Remove Image"),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        } else {
                                          return SizedBox();
                                        }
                                      },
                                    ),
                                  ),
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(
                                      _imagesFile.length,
                                      (index) {
                                        if (_imagesFile[index] != null) {
                                          return Stack(
                                            alignment: Alignment.topRight,
                                            clipBehavior: Clip.hardEdge,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context).size.width * .31,
                                                width: MediaQuery.of(context).size.width * .31,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Image.file(
                                                    _imagesFile[index]!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 4,
                                                right: 4,
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle, color: Colors.grey.withOpacity(.3)),
                                                  child: FittedBox(
                                                    child: IconButton(
                                                      icon: const Icon(Icons.delete),
                                                      color: Colors.red,
                                                      onPressed: () {
                                                        areYouSure(
                                                            onPress: () {
                                                              _imagesFile.remove(_imagesFile[index]);
                                                              navigator_route_pop(context: context);
                                                            },
                                                            context: context,
                                                            content: "Are you sure to Remove this image",
                                                            title: "Remove Image");
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        } else {
                                          return SizedBox();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 100)
                            ],
                          ),
                        ),
                      ),
                    )),
          )),
    );
  }

  void onChangeCalculator(
      {packing, quantity, packingQuantity, weight, totalWeight, length, width, height, totalCBM, cbm, type}) {
    packing = int.parse(packing.toString().isEmpty ? "0" : packing);
    packingQuantity = int.parse(packingQuantity.toString().isEmpty ? "0" : packingQuantity);
    quantity = int.parse(quantity.toString().isEmpty ? "0" : quantity);
    weight = double.parse(weight.toString().isEmpty ? "0" : weight);
    totalWeight = double.parse(totalWeight.toString().isEmpty ? "0" : totalWeight);
    length = double.parse(length.toString().isEmpty ? "0" : length);
    width = double.parse(width.toString().isEmpty ? "0" : width);
    height = double.parse(height.toString().isEmpty ? "0" : height);
    totalCBM = double.parse(totalCBM.toString().isEmpty ? "0" : totalCBM);
    cbm = double.parse(cbm.toString().isEmpty ? "0" : cbm);

    setState(() {
      if (packing > 0 && type == "packing") {
        quantityController.text.isEmpty;
        quantityController.text = "${packing * packingQuantity}";
      } else if (packingQuantity > 0 && type == "packing") {
        quantityController.text = packingQuantity.toString();
      }

      if (weight > 0) {
        if (packing > 0) {
          print("______if packing is not zero_________");
          totalWController.text = ((packing * weight) / 1000).toStringAsFixed(3);
        }
        if ((packing == null || packing.toString().isEmpty || packing.toString() == "0.0") && quantity > 0) {
          print("______if quantity is not zero_________");
          totalWController.text = ((quantity * weight) / 1000).toStringAsFixed(3);
        }
      }

      if (length > 0 && width > 0 && height > 0) {
        cbmController.text = ((length * width * height) / 1000000).toStringAsFixed(3);
        cbm = ((length * width * height) / 1000000);

        if (packing > 0) {
          totalCbmController.text = (cbm * packing).toStringAsFixed(3);
        }

        if (packing == null && quantity > 0) {
          totalCbmController.text = (cbm * quantity).toStringAsFixed(3);
          ;
        }
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

///___________________________________________
//
// class ItemFormScreen extends StatefulWidget {
//   final int? index;
//
//   ItemFormScreen({this.index});
//   _ItemFormScreenState createState() => _ItemFormScreenState();
// }
//
// class _ItemFormScreenState extends State<ItemFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   List items = [];
//   var codeController = TextEditingController();
//   var itemController = TextEditingController();
//   var descriptionController = TextEditingController();
//   var colorController = TextEditingController();
//   var modelController = TextEditingController();
//   var customerController = TextEditingController();
//   var customerData;
//   var orderId;
//   String id = '';
//   String itemId = '';
//   var uuid = Uuid().v1();
//   final FocusNode _focusNode = FocusNode();
//   bool _showAutocomplete = false;
//   onSubmit(context) async {
//     try {
//       if (!_formKey.currentState!.validate()) {
//         return;
//       }
//       _formKey.currentState!.save();
//
//       Navigator.of(context)
//           .pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => NavigationButtonScreen()), (route) => false);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   List<File?> _imagesFile = [];
//   List _imagesLink = [];
//   final picker = ImagePicker();
//
//   Future getImage(ImageSource source, context) async {
//     if (source == ImageSource.camera) {
//       final pickedFile = await ImagePickerService.scan(context);
//       if (pickedFile != null) {
//         setState(() {
//           _imagesFile.add(pickedFile);
//         });
//       }
//     } else {
//       final pickedFile = await ImagePickerService.multiGalleryImage(context);
//       for (var value in pickedFile) {
//         setState(() {
//           _imagesFile.add(value);
//         });
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     customerController.dispose();
//     super.dispose();
//   }
//
//   List<String> colorList = ['Red', 'Green', 'Blue', 'Yellow', 'Purple', 'Orange', 'Black', 'White'];
//   List<String> filteredList = [];
//
//   void didChangeDependencies() async {
//     final items = Provider.of<UserFormService>(context, listen: false);
//     items.itemType = 0;
//     filteredList = colorList;
//     if (widget.index == null) return;
//     final item = items.items[widget.index!];
//     await items.getImagesByUuId(item['uniqueId']);
//     _imagesLink = items.imageListWithUuId;
//     codeController.text = "${item["itemCode"] ?? "0"}";
//     itemController.text = "${item['itemName'] ?? "0"}";
//     colorController.text = "${item['color'] ?? "0"}";
//     modelController.text = "${item['model'] ?? "0"}";
//     id = "${item['id'] ?? ''}";
//     uuid = "${item['uniqueId'] ?? ""}";
//     super.didChangeDependencies();
//   }
//
//   Widget build(BuildContext context) {
//     final item = Provider.of<UserFormService>(context, listen: false);
//     return GestureDetector(
//       onTap: () => SystemChannels.textInput.invokeMethod<void>('TextInput.hide'),
//       child: Scaffold(
//           backgroundColor: AppTheme.white,
//           appBar: AppBar(
//             elevation: 0.1,
//             backgroundColor: AppTheme.white,
//             title: Text(
//               widget.index == null ? "Add Item" : "Update Item",
//               style: TextStyle(fontSize: 16, color: AppTheme.black),
//             ),
//           ),
//           bottomNavigationBar: SizedBox(
//             width: double.infinity,
//             child: Padding(
//               padding: MediaQuery.of(context).viewInsets,
//               child: Container(
//                 padding: EdgeInsets.only(bottom: 30, top: 25),
//                 child: GestureDetector(
//                   onTap: () async {
//                     if (!_formKey.currentState!.validate()) {
//                       return;
//                     }
//                     _formKey.currentState!.save();
//                     LoadingDialog(context);
//
//                     final isEditMode = widget.index != null;
//                     final data = isEditMode ? item.items[widget.index!] : null;
//
//                     // Define a common item map
//                     final itemMap = {
//                       "uniqueId": uuid,
//                       "itemCode": codeController.text,
//                       "itemName": itemController.text,
//                       "itemId": itemId ?? "",
//                       "description": descriptionController.text,
//                       "color": colorController.text,
//                       "model": modelController.text,
//                       "images": _imagesFile,
//                     };
//
//                     if (itemId.isEmpty) {
//                       item.addItems({...itemMap, "itemId": itemId});
//                     }
//                     if (customerData != null) {
//                       item.addItems({...itemMap, "customerId": customerData.id ?? ""});
//                     }
//                     if (isEditMode) {
//                       if (data == null || data['id'] == null || data['uniqueId'] == null) {
//                         await item.postItemImage(context: context, images: _imagesFile, uuId: uuid);
//                         item.removeItems(data!['itemCode']);
//                       } else {
//                         item.removeItems(data['itemCode']);
//                       }
//                       item.addItems({...itemMap, "id": id.toString(), "orderId": data?['orderId'] ?? orderId});
//                     } else {
//                       await item.postItemImage(context: context, images: _imagesFile, uuId: uuid);
//                       item.addItems(itemMap);
//                     }
//
//                     // Clear fields
//                     codeController.clear();
//                     itemController.clear();
//                     _imagesFile.clear();
//                     descriptionController.clear();
//                     uuid = '';
//                     itemId = '';
//
//                     // Show success message and navigate
//                     var snackBar = SnackBar(
//                         backgroundColor: AppTheme.green,
//                         content: Text(
//                           "Item added successfully",
//                           style: TextStyle(color: AppTheme.white),
//                         ));
//                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                     navigator_route_pop(context: context);
//                     navigator_route_pop(context: context);
//                   },
//                   child: Container(
//                     margin: EdgeInsets.all(12),
//                     width: double.infinity,
//                     padding: EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                         color: AppTheme.primary,
//                         border: Border.all(width: 0, color: AppTheme.primary),
//                         borderRadius: BorderRadius.circular(8)),
//                     child: Text(
//                       widget.index == null ? "Add Item" : "Update Item",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: AppTheme.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           body: Consumer<UserFormService>(
//               builder: (ctx, item, _) => Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
//                     child: Form(
//                       key: _formKey,
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             SizedBox(height: 10),
//                             CustomTextFormField(
//                                 textInputType: TextInputType.text,
//                                 validator: FormValidator.isEmpty,
//                                 controller: codeController,
//                                 title: "Chassis No",
//                                 hintText: "Chassis No",
//                                 borderType: true,
//                                 verticalPadding: 8),
//                             Consumer<UserFormService>(
//                               builder: (ctx, product, _) => CustomTextFormField(
//                                   textInputType: TextInputType.text,
//                                   controller: itemController,
//                                   title: "Car Type",
//                                   hintText: "Car Type",
//                                   borderType: true,
//                                   isRequired: true,
//                                   verticalPadding: 8,
//                                   suffix: IconButton(
//                                     onPressed: () {
//                                       ButtonSheetWidget(
//                                           context: context,
//                                           child: Scaffold(
//                                             appBar: AppBar(
//                                               leading: SizedBox.shrink(),
//                                               actions: [
//                                                 IconButton(
//                                                     onPressed: () => Navigator.of(context).pop(),
//                                                     icon: Icon(Icons.close))
//                                               ],
//                                             ),
//                                             body: FutureBuilder(
//                                                 future: product.gerProducts(itemController.text),
//                                                 builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
//                                                     ? Center(child: CircularProgressIndicator(color: AppTheme.primary))
//                                                     : ListView.separated(
//                                                         padding: EdgeInsets.all(18),
//                                                         itemBuilder: (ctx, i) => SizedBox(
//                                                               width: double.infinity,
//                                                               child: InkWell(
//                                                                 onTap: () async {
//                                                                   setState(() {
//                                                                     itemController.text = product.product[i]['name'];
//                                                                     itemId = product.product[i]['id'].toString();
//                                                                     navigator_route_pop(context: context);
//                                                                   });
//                                                                 },
//                                                                 child: Padding(
//                                                                   padding: const EdgeInsets.all(8.0),
//                                                                   child: Column(
//                                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                                     children: [
//                                                                       Row(
//                                                                         children: [
//                                                                           Image.asset('assets/images/box.png',
//                                                                               width: 25, height: 25),
//                                                                           SizedBox(width: 8),
//                                                                           Expanded(
//                                                                             child: RichText(
//                                                                               text: TextSpan(
//                                                                                 children: [
//                                                                                   TextSpan(
//                                                                                       text: product.product[i]
//                                                                                               ['name'] ??
//                                                                                           "null",
//                                                                                       style: TextStyle(
//                                                                                           color: AppTheme.black,
//                                                                                           fontFamily: "sf_med",
//                                                                                           fontSize: 18)),
//                                                                                   TextSpan(
//                                                                                       text: "-",
//                                                                                       style: TextStyle(
//                                                                                           color: AppTheme.black)),
//                                                                                   TextSpan(
//                                                                                       text: product.product[i]['group']
//                                                                                               ['name'] ??
//                                                                                           "null",
//                                                                                       style: TextStyle(
//                                                                                           color: AppTheme.black,
//                                                                                           fontFamily: "sf_med",
//                                                                                           fontSize: 16)),
//                                                                                 ],
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                         separatorBuilder: (ctx, div) => Divider(),
//                                                         itemCount: product.product.length)),
//                                           ),
//                                           heightFactor: 0.7);
//                                     },
//                                     icon: Icon(Icons.search, color: AppTheme.primary),
//                                   )),
//                             ),
//                             Consumer<CustomersService>(
//                               builder: (ctx, customer, _) => Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   CustomTextFormField(
//                                     isRequired: true,
//                                     validator: FormValidator.isEmpty,
//                                     title: "Customer",
//                                     hintText: "Customer",
//                                     controller: customerController,
//                                     borderType: true,
//                                     suffix: IconButton(
//                                       onPressed: () {
//                                         if (customerController.text.isEmpty) return;
//                                         ButtonSheetWidget(
//                                             context: context,
//                                             child: Scaffold(
//                                               appBar: AppBar(
//                                                 leading: SizedBox.shrink(),
//                                                 actions: [
//                                                   IconButton(
//                                                       onPressed: () {
//                                                         Navigator.of(context).pop();
//                                                       },
//                                                       icon: Icon(Icons.close))
//                                                 ],
//                                               ),
//                                               body: FutureBuilder(
//                                                   future: customer.getCustomers(customer: customerController.text),
//                                                   builder: (ctx, snap) => snap.connectionState ==
//                                                           ConnectionState.waiting
//                                                       ? Center(
//                                                           child: CircularProgressIndicator(
//                                                             color: AppTheme.primary,
//                                                           ),
//                                                         )
//                                                       : Consumer<OpenOrderServices>(
//                                                           builder: (ctx, loading, _) => customer.customersList.isEmpty
//                                                               ? EmptyScreen()
//                                                               : ListView.separated(
//                                                                   padding: EdgeInsets.all(18),
//                                                                   itemBuilder: (ctx, i) => SizedBox(
//                                                                         width: double.infinity,
//                                                                         child: InkWell(
//                                                                           onTap: () async {
//                                                                             setState(() {
//                                                                               customerData = customer.customersList[i];
//                                                                               customerController.text = customer
//                                                                                   .customersList[i].name
//                                                                                   .toString();
//                                                                             });
//                                                                             navigator_route_pop(context: context);
//                                                                             ButtonSheetWidget(
//                                                                                 context: context,
//                                                                                 heightFactor: 0.7,
//                                                                                 child: OpenOrder(
//                                                                                     customerId: customerData!.id));
//                                                                           },
//                                                                           child: Padding(
//                                                                             padding: const EdgeInsets.all(8.0),
//                                                                             child: Column(
//                                                                               crossAxisAlignment:
//                                                                                   CrossAxisAlignment.start,
//                                                                               children: [
//                                                                                 Row(
//                                                                                   children: [
//                                                                                     Icon(
//                                                                                       Icons.person,
//                                                                                       color: AppTheme.grey_thin,
//                                                                                     ),
//                                                                                     SizedBox(width: 8),
//                                                                                     Expanded(
//                                                                                       child: RichText(
//                                                                                         text: TextSpan(
//                                                                                           children: [
//                                                                                             TextSpan(
//                                                                                                 text:
//                                                                                                     "${customer.customersList[i].name} ",
//                                                                                                 style: TextStyle(
//                                                                                                     color:
//                                                                                                         AppTheme.black,
//                                                                                                     fontFamily:
//                                                                                                         "sf_med",
//                                                                                                     fontSize: 18)),
//                                                                                             TextSpan(
//                                                                                                 text: "-",
//                                                                                                 style: TextStyle(
//                                                                                                     color: AppTheme
//                                                                                                         .black)),
//                                                                                             TextSpan(
//                                                                                                 text:
//                                                                                                     "${customer.customersList[i].code}",
//                                                                                                 style: TextStyle(
//                                                                                                     color:
//                                                                                                         AppTheme.black,
//                                                                                                     fontFamily:
//                                                                                                         "sf_med",
//                                                                                                     fontSize: 16)),
//                                                                                           ],
//                                                                                         ),
//                                                                                       ),
//                                                                                     ),
//                                                                                   ],
//                                                                                 ),
//                                                                                 SizedBox(height: 8),
//                                                                                 Padding(
//                                                                                   padding: const EdgeInsets.symmetric(
//                                                                                       horizontal: 33.0),
//                                                                                   child: Wrap(
//                                                                                       children: customer
//                                                                                           .customersList[i]
//                                                                                           .customerCodes!
//                                                                                           .map<Widget>((e) => RawChip(
//                                                                                                 padding: EdgeInsets
//                                                                                                     .symmetric(
//                                                                                                         vertical: 0),
//                                                                                                 label: Text(
//                                                                                                   e.name.toString(),
//                                                                                                   style: TextStyle(
//                                                                                                     color:
//                                                                                                         AppTheme.black,
//                                                                                                     fontSize: 11,
//                                                                                                     fontFamily:
//                                                                                                         'sf_med',
//                                                                                                     fontWeight:
//                                                                                                         FontWeight.w500,
//                                                                                                   ),
//                                                                                                 ),
//                                                                                               ))
//                                                                                           .toList()),
//                                                                                 )
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                   separatorBuilder: (ctx, div) => Divider(),
//                                                                   itemCount: customer.customersList.length))),
//                                             ),
//                                             heightFactor: 0.7);
//                                       },
//                                       icon: Icon(Icons.search, color: AppTheme.primary),
//                                     ),
//                                     verticalPadding: 8,
//                                   ),
//                                   SizedBox(height: 8),
//                                   RawChipWidget(
//                                       title: "Shipment Mark",
//                                       list: customerData == null ? [] : customerData.customerCodes,
//                                       type: "mark")
//                                 ],
//                               ),
//                             ),
//                             CustomTextFormField(
//                               textInputType: TextInputType.text,
//                               controller: descriptionController,
//                               title: "Description",
//                               hintText: "Description",
//                               borderType: true,
//                               verticalPadding: 8,
//                             ),
//                             Row(children: [
//                               Expanded(
//                                 child: CustomTextFormField(
//                                   textInputType: TextInputType.text,
//                                   validator: FormValidator.isEmpty,
//                                   controller: colorController,
//                                   title: "Color",
//                                   hintText: "Color",
//                                   borderType: true,
//                                   verticalPadding: 8,
//                                   onChange: (value) {
//                                     setState(() {
//                                       filteredList = colorList
//                                           .where((color) => color.toLowerCase().contains(value.toLowerCase()))
//                                           .toList();
//                                     });
//                                   },
//                                   prefix: IconButton(
//                                     onPressed: () {
//                                       ButtonSheetWidget(
//                                           context: context,
//                                           child: Scaffold(
//                                             appBar: AppBar(
//                                               leading: SizedBox.shrink(),
//                                               actions: [
//                                                 IconButton(
//                                                     onPressed: () => Navigator.of(context).pop(),
//                                                     icon: Icon(Icons.close))
//                                               ],
//                                             ),
//                                             body: ListView.separated(
//                                                 padding: EdgeInsets.all(18),
//                                                 itemBuilder: (ctx, i) => SizedBox(
//                                                       width: double.infinity,
//                                                       child: InkWell(
//                                                         onTap: () async {
//                                                           setState(() {
//                                                             colorController.text = filteredList[i];
//                                                             navigator_route_pop(context: context);
//                                                           });
//                                                         },
//                                                         child: Padding(
//                                                           padding: const EdgeInsets.all(8.0),
//                                                           child: Text(filteredList[i],
//                                                               style: TextStyle(
//                                                                 color: AppTheme.black,
//                                                                 fontFamily: "sf_med",
//                                                                 fontSize: 18,
//                                                               )),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                 separatorBuilder: (ctx, div) => Divider(),
//                                                 itemCount: filteredList.length),
//                                           ),
//                                           heightFactor: 0.7);
//                                     },
//                                     icon: Icon(Icons.search, color: AppTheme.primary),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 12),
//                               Expanded(
//                                 child: CustomTextFormField(
//                                   textInputType: TextInputType.text,
//                                   validator: FormValidator.isEmpty,
//                                   controller: modelController,
//                                   title: "Model",
//                                   hintText: "Model",
//                                   borderType: true,
//                                   verticalPadding: 8,
//                                 ),
//                               ),
//                             ]),
//                             GestureDetector(
//                               onTap: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return AlertDialog(
//                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                                       title: const Text(
//                                         "Image from:",
//                                         style: TextStyle(fontSize: 26),
//                                       ),
//                                       content: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           TextButton(
//                                               onPressed: () async {
//                                                 await getImage(ImageSource.gallery, context);
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: const [
//                                                   Icon(Icons.image, color: AppTheme.primary, size: 22),
//                                                   SizedBox(
//                                                     width: 6,
//                                                   ),
//                                                   Text(
//                                                     "From gallery",
//                                                     style: TextStyle(
//                                                         fontFamily: "sf_med", fontSize: 16, color: AppTheme.black),
//                                                   ),
//                                                 ],
//                                               )),
//                                           const Divider(),
//                                           TextButton(
//                                             onPressed: () async {
//                                               await getImage(ImageSource.camera, context);
//                                               Navigator.pop(context);
//                                             },
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               children: const [
//                                                 Icon(Icons.camera_alt_rounded, color: AppTheme.primary, size: 22),
//                                                 SizedBox(
//                                                   width: 6,
//                                                 ),
//                                                 Text(
//                                                   "From Camera",
//                                                   style: TextStyle(
//                                                       fontFamily: "sf_med", fontSize: 16, color: AppTheme.black),
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                               child: CustomTextFormField(
//                                 title: "Upload Image",
//                                 hintText: "upload Image",
//                                 borderType: true,
//                                 verticalPadding: 8,
//                                 enabled: false,
//                                 suffix: Icon((_imagesFile.isEmpty && _imagesLink.isEmpty) ? Icons.link : Icons.add),
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 Wrap(
//                                   direction: Axis.horizontal,
//                                   children: List.generate(
//                                     _imagesLink.length,
//                                     (index) {
//                                       if (_imagesLink[index] != null) {
//                                         return Stack(
//                                           alignment: Alignment.topRight,
//                                           clipBehavior: Clip.hardEdge,
//                                           children: [
//                                             SizedBox(
//                                               height: MediaQuery.of(context).size.width * .31,
//                                               width: MediaQuery.of(context).size.width * .31,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(4.0),
//                                                 child: Image.network(
//                                                   dotenv.env['UPLOADURL']! + _imagesLink[index]['url'],
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                             ),
//                                             Positioned(
//                                               top: 4,
//                                               right: 4,
//                                               child: Container(
//                                                 height: 30,
//                                                 width: 30,
//                                                 decoration: BoxDecoration(
//                                                     shape: BoxShape.circle, color: Colors.grey.withOpacity(.3)),
//                                                 child: FittedBox(
//                                                   child: IconButton(
//                                                     icon: const Icon(Icons.delete),
//                                                     color: Colors.red,
//                                                     onPressed: () => areYouSure(
//                                                         onPress: () async {
//                                                           await item.removeImagesByUuId(_imagesLink[index]['id']);
//                                                           _imagesLink.remove(_imagesLink[index]);
//                                                           navigator_route_pop(context: context);
//                                                         },
//                                                         context: context,
//                                                         content: "Are you sure to Remove this image",
//                                                         title: "Remove Image"),
//                                                   ),
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         );
//                                       } else {
//                                         return SizedBox();
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 Wrap(
//                                   direction: Axis.horizontal,
//                                   children: List.generate(
//                                     _imagesFile.length,
//                                     (index) {
//                                       if (_imagesFile[index] != null) {
//                                         return Stack(
//                                           alignment: Alignment.topRight,
//                                           clipBehavior: Clip.hardEdge,
//                                           children: [
//                                             SizedBox(
//                                               height: MediaQuery.of(context).size.width * .31,
//                                               width: MediaQuery.of(context).size.width * .31,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(4.0),
//                                                 child: Image.file(
//                                                   _imagesFile[index]!,
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                             ),
//                                             Positioned(
//                                               top: 4,
//                                               right: 4,
//                                               child: Container(
//                                                 height: 30,
//                                                 width: 30,
//                                                 decoration: BoxDecoration(
//                                                     shape: BoxShape.circle, color: Colors.grey.withOpacity(.3)),
//                                                 child: FittedBox(
//                                                   child: IconButton(
//                                                     icon: const Icon(Icons.delete),
//                                                     color: Colors.red,
//                                                     onPressed: () {
//                                                       areYouSure(
//                                                           onPress: () {
//                                                             _imagesFile.remove(_imagesFile[index]);
//                                                             navigator_route_pop(context: context);
//                                                           },
//                                                           context: context,
//                                                           content: "Are you sure to Remove this image",
//                                                           title: "Remove Image");
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         );
//                                       } else {
//                                         return SizedBox();
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 100)
//                           ],
//                         ),
//                       ),
//                     ),
//                   ))),
//     );
//   }
// }
