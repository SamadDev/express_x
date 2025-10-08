// import 'package:x_express/Utils/exports.dart';
//
// class ItemFormScreenNext extends StatefulWidget {
//   final id;
//   final openOrder;
//   final index;
//   ItemFormScreenNext({this.id, this.openOrder, this.index});
//
//   _ItemFormScreenNextState createState() => _ItemFormScreenNextState();
// }
//
// class _ItemFormScreenNextState extends State<ItemFormScreenNext> {
//   final _formKey = GlobalKey<FormState>();
//
//   List items = [];
//   var codeController = TextEditingController();
//   var itemController = TextEditingController();
//   var cartonController = TextEditingController();
//   var quantityController = TextEditingController();
//   var totalQController = TextEditingController();
//   var heightController = TextEditingController();
//   var widthController = TextEditingController();
//   var totalCbmController = TextEditingController();
//   var lengthController = TextEditingController();
//   var weightController = TextEditingController();
//   var totalWController = TextEditingController();
//   var cbmController = TextEditingController();
//   var packingQuantity = TextEditingController();
//   var descriptionController = TextEditingController();
//   String uniqueId = '';
//   String id = '';
//   String orderId = '';
//
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
//   List<File?> _images = [];
//   final picker = ImagePicker();
//
//   Future getImage(ImageSource source, context) async {
//     if (source == ImageSource.camera) {
//       final pickedFile = await ImagePickerService.scan(context);
//       if (pickedFile != null) {
//         setState(() {
//           _images.add(pickedFile);
//         });
//       }
//     } else {
//       final pickedFile = await ImagePickerService.multiGalleryImage(context);
//
//       for (var value in pickedFile) {
//         setState(() {
//           _images.add(value);
//         });
//       }
//     }
//   }
//
//   void didChangeDependencies() {
//     final items = Provider.of<UserFormService>(context, listen: false);
//
//     // print("run type item is: ${items.runtimeType}");
//     // items.itemType = 0;
//     // if (widget.index == null) return;
//     // final item = items.items[widget.index!];
//     // codeController.text = "${item["itemCode"] ?? "0"}";
//     // itemController.text = "${item['itemName'] ?? "0"}";
//     // cartonController.text = intStringValue("${item['packing'] ?? "0"}");
//     // quantityController.text = intStringValue("${item['totalQty'] ?? "0"}");
//     // packingQuantity.text = intStringValue("${item['packingQuantity'] ?? "0"}");
//     // lengthController.text = intStringValue("${item['length'] ?? "0"}");
//     // widthController.text = intStringValue("${item['width'] ?? "0"}");
//     // heightController.text = intStringValue("${item['height'] ?? "0"}");
//     // totalCbmController.text = "${item['totalCBM'] ?? "0"}";
//     // cbmController.text = "${item['cbm'] ?? "0"}";
//     // weightController.text = "${item['weight'] ?? "0"}";
//     // totalWController.text = "${item['totalWeight'] ?? "0"}";
//     // id = "${item['id'] ?? ''}";
//     // uniqueId = "${item['uniqueId'] ?? ""}";
//     // orderId = "${item['orderId'] ?? ""}";
//     super.didChangeDependencies();
//   }
//
//   TabController? _controller;
//   Widget build(BuildContext context) {
//     final item = Provider.of<UserFormService>(context, listen: false);
//     return GestureDetector(
//       onTap: () {
//         SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
//       },
//       child: Scaffold(
//           backgroundColor: AppTheme.white,
//           appBar: AppBar(
//             elevation: 0.1,
//             backgroundColor: AppTheme.white,
//             title: Text(
//               "Add Item",
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
//                   onTap: () {
//                     if (!_formKey.currentState!.validate()) {
//                       return;
//                     }
//                     _formKey.currentState!.save();
//
//                     if (widget.index != null) {
//                       final data = item.items[widget.index!];
//
//                       if (data['id'] == null || data['uniqueId'] == null) {
//                         item.removeItems(data['itemCode']);
//                         item.addItems({
//                           "itemCode": codeController.text,
//                           "itemName": itemController.text,
//                           "packing": cartonController.text,
//                           "packingQuantity": quantityController.text,
//                           "quantity": quantityController.text,
//                           "length": lengthController.text,
//                           "width": widthController.text,
//                           "height": heightController.text,
//                           "cbm": cbmController.text,
//                           "totalCBM": totalCbmController.text,
//                           "weight": weightController.text,
//                           "totalWeight": totalWController.text,
//                         });
//                       } else if ((data['id'] != null || data['uniqueId'] != null) && data['orderId'] == null) {
//                         item.removeItems(data['itemCode']);
//                         item.addItems({
//                           "id": id.toString(),
//                           uniqueId: uniqueId.toString(),
//                           "itemCode": codeController.text,
//                           "itemName": itemController.text,
//                           "packing": cartonController.text,
//                           "packingQuantity": quantityController.text,
//                           "quantity": quantityController.text,
//                           "length": lengthController.text,
//                           "width": widthController.text,
//                           "height": heightController.text,
//                           "description": descriptionController.text,
//                           "cbm": cbmController.text,
//                           "totalCBM": totalCbmController.text,
//                           "weight": weightController.text,
//                           "totalWeight": totalWController.text,
//                           "images": _images
//                         });
//                       } else {
//                         item.removeItems(data['itemCode']);
//                         item.addItems({
//                           "id": id.toString(),
//                           "uniqueId": uniqueId.toString(),
//                           "orderId": orderId,
//                           "itemCode": codeController.text,
//                           "itemName": itemController.text,
//                           "packing": cartonController.text,
//                           "packingQuantity": quantityController.text,
//                           "quantity": quantityController.text,
//                           "length": lengthController.text,
//                           "width": widthController.text,
//                           "height": heightController.text,
//                           "cbm": cbmController.text,
//                           "totalCBM": totalCbmController.text,
//                           "description": descriptionController.text,
//                           "weight": weightController.text,
//                           "totalWeight": totalWController.text,
//                           "images": _images
//                         });
//                       }
//                     } else {
//                       item.addItems({
//                         "itemCode": codeController.text,
//                         "itemName": itemController.text,
//                         "packing": cartonController.text,
//                         "packingQuantity": quantityController.text,
//                         "quantity": quantityController.text,
//                         "length": lengthController.text,
//                         "width": widthController.text,
//                         "height": heightController.text,
//                         "cbm": cbmController.text,
//                         "totalCBM": totalCbmController.text,
//                         "description": descriptionController.text,
//                         "weight": weightController.text,
//                         "totalWeight": totalWController.text,
//                         "images": _images
//                       });
//                     }
//                     codeController.clear();
//                     itemController.clear();
//                     quantityController.clear();
//                     packingQuantity.clear();
//                     lengthController.clear();
//                     widthController.clear();
//                     heightController.clear();
//                     totalCbmController.clear();
//                     weightController.clear();
//                     totalWController.clear();
//                     cartonController.clear();
//                     totalQController.clear();
//                     _images.clear();
//                     descriptionController.clear();
//                     cbmController.clear();
//                     // _images.clear();
//
//                     var snackBar = SnackBar(
//                         backgroundColor: AppTheme.green,
//                         content: Text(
//                           "Item add successfully",
//                           style: TextStyle(color: AppTheme.white),
//                         ));
//                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
//           body: DefaultTabController(
//             length: 2,
//             child: Consumer<UserFormService>(
//                 builder: (ctx, item, _) => Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
//                       child: Form(
//                         key: _formKey,
//                         child: SingleChildScrollView(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.symmetric(vertical: 12),
//                                 height: 38,
//                                 decoration: BoxDecoration(
//                                   color: AppTheme.white,
//                                   borderRadius: BorderRadius.circular(
//                                     8.0,
//                                   ),
//                                 ),
//                                 child: TabBar(
//                                   controller: _controller,
//                                   indicator:
//                                       BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: AppTheme.primary),
//                                   labelColor: AppTheme.white,
//                                   labelPadding: EdgeInsets.zero,
//                                   unselectedLabelColor: AppTheme.black,
//                                   isScrollable: false,
//                                   onTap: (value) {
//                                     item.setItemType(value);
//                                   },
//                                   indicatorSize: TabBarIndicatorSize.tab,
//                                   tabs: [Tab(text: "Detail"), Tab(text: "Summary")],
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               // CustomTextFormField(
//                               //     textInputType: TextInputType.text,
//                               //     validator: FormValidator.isEmpty,
//                               //     controller: codeController,
//                               //     title: "Code",
//                               //     hintText: "Code",
//                               //     borderType: true,
//                               //     verticalPadding: 8),
//                               // CustomTextFormField(
//                               //     textInputType: TextInputType.text,
//                               //     // validator: FormValidator.isEmpty,
//                               //     controller: itemController,
//                               //     title: "Item Name",
//                               //     hintText: "Item Name",
//                               //     borderType: true,
//                               //     isRequired: true,
//                               //     verticalPadding: 8),
//                               // CustomTextFormField(
//                               //   textInputType: TextInputType.text,
//                               //   // validator: FormValidator.isEmpty,
//                               //   controller: descriptionController,
//                               //   title: "Description",
//                               //   hintText: "Description",
//                               //   borderType: true,
//                               //   verticalPadding: 8,
//                               // ),
//                               if (item.itemType == 1) ...[
//                                 Row(children: [
//                                   Expanded(
//                                     child: CustomTextFormField(
//                                       textInputType: TextInputType.number,
//                                       validator: FormValidator.isPhone,
//                                       controller: cartonController,
//                                       title: "Carton",
//                                       hintText: "Carton",
//                                       borderType: true,
//                                       verticalPadding: 8,
//                                       onChange: (value) {
//                                         item.itemType == 1
//                                             ? ""
//                                             : onChangeCalculator(
//                                                 type: "packing",
//                                                 packing: value.toString(),
//                                                 packingQuantity: packingQuantity.text,
//                                                 quantity: quantityController.text,
//                                                 width: widthController.text,
//                                                 cbm: cbmController.text,
//                                                 height: heightController.text,
//                                                 length: lengthController.text,
//                                                 totalCBM: totalCbmController.text,
//                                                 totalWeight: totalWController.text,
//                                                 weight: weightController.text,
//                                               );
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(width: 8),
//                                   Expanded(
//                                     child: CustomTextFormField(
//                                       textInputType: TextInputType.number,
//                                       validator: FormValidator.isPhone,
//                                       controller: totalWController,
//                                       title: "Total Weight",
//                                       hintText: "Total Weight",
//                                       borderType: true,
//                                       verticalPadding: 8,
//                                     ),
//                                   ),
//                                   SizedBox(width: 8),
//                                   Expanded(
//                                       child: CustomTextFormField(
//                                     textInputType: TextInputType.number,
//                                     validator: FormValidator.isPhone,
//                                     controller: totalCbmController,
//                                     title: "Total CBM",
//                                     hintText: "Total CBM",
//                                     borderType: true,
//                                     verticalPadding: 8,
//                                   ))
//                                 ]),
//                               ],
//                               if (item.itemType == 0) ...[
//                                 Row(children: [
//                                   Expanded(
//                                     child: CustomTextFormField(
//                                       textInputType: TextInputType.number,
//                                       validator: FormValidator.isPhone,
//                                       controller: cartonController,
//                                       title: "Carton",
//                                       hintText: "Carton",
//                                       borderType: true,
//                                       verticalPadding: 8,
//                                       onChange: (value) {
//                                         item.itemType == 1
//                                             ? ""
//                                             : onChangeCalculator(
//                                                 type: "packing",
//                                                 packing: value.toString(),
//                                                 packingQuantity: packingQuantity.text,
//                                                 quantity: quantityController.text,
//                                                 width: widthController.text,
//                                                 cbm: cbmController.text,
//                                                 height: heightController.text,
//                                                 length: lengthController.text,
//                                                 totalCBM: totalCbmController.text,
//                                                 totalWeight: totalWController.text,
//                                                 weight: weightController.text,
//                                               );
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(width: 8),
//                                   Expanded(
//                                       child: CustomTextFormField(
//                                     textInputType: TextInputType.number,
//                                     validator: FormValidator.isPhone,
//                                     controller: packingQuantity,
//                                     title: "Quantity",
//                                     hintText: "Quantity",
//                                     borderType: true,
//                                     verticalPadding: 8,
//                                     onChange: (value) {
//                                       value = value;
//                                       onChangeCalculator(
//                                         type: "packing",
//                                         packing: cartonController.text,
//                                         packingQuantity: value,
//                                         quantity: quantityController.text,
//                                         width: widthController.text,
//                                         cbm: cbmController.text,
//                                         height: heightController.text,
//                                         length: lengthController.text,
//                                         totalCBM: totalCbmController.text,
//                                         totalWeight: totalWController.text,
//                                         weight: weightController.text,
//                                       );
//                                     },
//                                   )),
//                                   SizedBox(width: 8),
//                                   Expanded(
//                                       child: CustomTextFormField(
//                                     textInputType: TextInputType.number,
//                                     validator: FormValidator.isPhone,
//                                     controller: quantityController,
//                                     title: "Total Qty",
//                                     hintText: "Total Qty",
//                                     borderType: true,
//                                     verticalPadding: 8,
//                                   ))
//                                 ]),
//                                 Row(children: [
//                                   Expanded(
//                                       child: CustomTextFormField(
//                                     textInputType: TextInputType.number,
//                                     validator: FormValidator.isPhone,
//                                     controller: heightController,
//                                     title: "Height",
//                                     hintText: "Height",
//                                     borderType: true,
//                                     verticalPadding: 8,
//                                     onChange: (value) {
//                                       onChangeCalculator(
//                                         packing: cartonController.text,
//                                         packingQuantity: packingQuantity.text,
//                                         quantity: quantityController.text,
//                                         width: widthController.text,
//                                         cbm: cbmController.text,
//                                         height: value,
//                                         length: lengthController.text,
//                                         totalCBM: totalCbmController.text,
//                                         totalWeight: totalWController.text,
//                                         weight: weightController.text,
//                                       );
//                                     },
//                                   )),
//                                   SizedBox(width: 7),
//                                   Expanded(
//                                       child: CustomTextFormField(
//                                     textInputType: TextInputType.number,
//                                     validator: FormValidator.isPhone,
//                                     controller: widthController,
//                                     title: "Width",
//                                     hintText: "Width",
//                                     borderType: true,
//                                     verticalPadding: 8,
//                                     onChange: (value) {
//                                       onChangeCalculator(
//                                         packing: cartonController.text,
//                                         packingQuantity: packingQuantity.text,
//                                         quantity: quantityController.text,
//                                         width: value,
//                                         cbm: cbmController.text,
//                                         height: heightController.text,
//                                         length: lengthController.text,
//                                         weight: weightController.text,
//                                         totalCBM: totalCbmController.text,
//                                         totalWeight: totalWController.text,
//                                       );
//                                     },
//                                   )),
//                                   SizedBox(width: 8),
//                                   Expanded(
//                                       child: CustomTextFormField(
//                                     textInputType: TextInputType.number,
//                                     validator: FormValidator.isPhone,
//                                     controller: lengthController,
//                                     title: "Length",
//                                     hintText: "Length",
//                                     borderType: true,
//                                     verticalPadding: 8,
//                                     onChange: (value) {
//                                       onChangeCalculator(
//                                         packing: cartonController.text,
//                                         packingQuantity: packingQuantity.text,
//                                         quantity: quantityController.text,
//                                         width: widthController.text,
//                                         cbm: cbmController.text,
//                                         height: heightController.text,
//                                         length: value,
//                                         totalCBM: totalCbmController.text,
//                                         totalWeight: totalWController.text,
//                                         weight: weightController.text,
//                                       );
//                                     },
//                                   )),
//                                 ]),
//                                 Row(children: [
//                                   Expanded(
//                                       child: CustomTextFormField(
//                                     textInputType: TextInputType.number,
//                                     controller: cbmController,
//                                     title: "CBM",
//                                     hintText: "CBM",
//                                     borderType: true,
//                                     verticalPadding: 8,
//                                   )),
//                                   SizedBox(width: 8),
//                                   Expanded(
//                                       child: CustomTextFormField(
//                                     textInputType: TextInputType.number,
//                                     validator: FormValidator.isPhone,
//                                     controller: totalCbmController,
//                                     title: "Total CBM",
//                                     hintText: "Total CBM",
//                                     borderType: true,
//                                     verticalPadding: 8,
//                                   )),
//                                 ]),
//                                 Row(children: [
//                                   Expanded(
//                                       child: CustomTextFormField(
//                                     textInputType: TextInputType.number,
//                                     validator: FormValidator.isPhone,
//                                     controller: weightController,
//                                     title: "Weight",
//                                     hintText: "Weight",
//                                     borderType: true,
//                                     verticalPadding: 8,
//                                     onChange: (value) {
//                                       onChangeCalculator(
//                                         packing: cartonController.text,
//                                         packingQuantity: packingQuantity.text,
//                                         quantity: "",
//                                         width: "",
//                                         cbm: "",
//                                         height: "",
//                                         length: "",
//                                         totalCBM: "",
//                                         totalWeight: "",
//                                         weight: value,
//                                       );
//                                     },
//                                   )),
//                                   SizedBox(width: 8),
//                                   Expanded(
//                                     child: CustomTextFormField(
//                                       textInputType: TextInputType.number,
//                                       validator: FormValidator.isPhone,
//                                       controller: totalWController,
//                                       title: "Total Weight",
//                                       hintText: "Total Weight",
//                                       borderType: true,
//                                       verticalPadding: 8,
//                                     ),
//                                   ),
//                                 ])
//                               ],
//                               // GestureDetector(
//                               //   onTap: () {
//                               //     showDialog(
//                               //       context: context,
//                               //       builder: (context) {
//                               //         return AlertDialog(
//                               //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                               //           title: const Text(
//                               //             "Image from:",
//                               //             style: TextStyle(fontSize: 26),
//                               //           ),
//                               //           content: Column(
//                               //             crossAxisAlignment: CrossAxisAlignment.start,
//                               //             mainAxisAlignment: MainAxisAlignment.start,
//                               //             mainAxisSize: MainAxisSize.min,
//                               //             children: [
//                               //               TextButton(
//                               //                   onPressed: () async {
//                               //                     await getImage(ImageSource.gallery, context);
//                               //                     Navigator.pop(context);
//                               //                   },
//                               //                   child: Row(
//                               //                     mainAxisAlignment: MainAxisAlignment.center,
//                               //                     children: const [
//                               //                       Icon(Icons.image, color: AppTheme.primary, size: 22),
//                               //                       SizedBox(
//                               //                         width: 6,
//                               //                       ),
//                               //                       Text(
//                               //                         "From gallery",
//                               //                         style: TextStyle(
//                               //                             fontFamily: "sf_med", fontSize: 16, color: AppTheme.black),
//                               //                       ),
//                               //                     ],
//                               //                   )),
//                               //               const Divider(),
//                               //               TextButton(
//                               //                 onPressed: () async {
//                               //                   await getImage(ImageSource.camera, context);
//                               //                   Navigator.pop(context);
//                               //                 },
//                               //                 child: Row(
//                               //                   mainAxisAlignment: MainAxisAlignment.center,
//                               //                   children: const [
//                               //                     Icon(Icons.camera_alt_rounded, color: AppTheme.primary, size: 22),
//                               //                     SizedBox(
//                               //                       width: 6,
//                               //                     ),
//                               //                     Text(
//                               //                       "From Camera",
//                               //                       style: TextStyle(
//                               //                           fontFamily: "sf_med", fontSize: 16, color: AppTheme.black),
//                               //                     ),
//                               //                   ],
//                               //                 ),
//                               //               )
//                               //             ],
//                               //           ),
//                               //         );
//                               //       },
//                               //     );
//                               //   },
//                               //   child: CustomTextFormField(
//                               //     title: "Upload Image",
//                               //     hintText: "upload Image",
//                               //     borderType: true,
//                               //     verticalPadding: 8,
//                               //     enabled: false,
//                               //     suffix: Icon(_images.isEmpty ? Icons.link : Icons.add),
//                               //   ),
//                               // ),
//                               // Wrap(
//                               //   direction: Axis.horizontal,
//                               //   children: List.generate(
//                               //     _images.length,
//                               //     (index) {
//                               //       if (_images[index] != null) {
//                               //         return Stack(
//                               //           alignment: Alignment.topRight,
//                               //           clipBehavior: Clip.hardEdge,
//                               //           children: [
//                               //             SizedBox(
//                               //               height: MediaQuery.of(context).size.width * .31,
//                               //               width: MediaQuery.of(context).size.width * .31,
//                               //               child: Padding(
//                               //                 padding: const EdgeInsets.all(4.0),
//                               //                 child: Image.file(
//                               //                   _images[index]!,
//                               //                   fit: BoxFit.cover,
//                               //                 ),
//                               //               ),
//                               //             ),
//                               //             Positioned(
//                               //               top: 4,
//                               //               right: 4,
//                               //               child: Container(
//                               //                 height: 30,
//                               //                 width: 30,
//                               //                 decoration: BoxDecoration(
//                               //                     shape: BoxShape.circle, color: Colors.grey.withOpacity(.3)),
//                               //                 child: FittedBox(
//                               //                   child: IconButton(
//                               //                     icon: const Icon(Icons.delete),
//                               //                     color: Colors.red,
//                               //                     onPressed: () {
//                               //                       areYouSure(
//                               //                           onPress: () {
//                               //                             _images.remove(_images[index]);
//                               //                           },
//                               //                           context: context,
//                               //                           content: "Are you sure to Remove this image",
//                               //                           title: "Remove Image");
//                               //                     },
//                               //                   ),
//                               //                 ),
//                               //               ),
//                               //             )
//                               //           ],
//                               //         );
//                               //       } else {
//                               //         return SizedBox();
//                               //       }
//                               //     },
//                               //   ),
//                               // ),
//                               SizedBox(height: 100)
//                             ],
//                           ),
//                         ),
//                       ),
//                     )),
//           )),
//     );
//   }
//
//   void onChangeCalculator(
//       {packing, quantity, packingQuantity, weight, totalWeight, length, width, height, totalCBM, cbm, type}) {
//     packing = int.parse(packing.toString().isEmpty ? "0" : packing);
//     packingQuantity = int.parse(packingQuantity.toString().isEmpty ? "0" : packingQuantity);
//     quantity = int.parse(quantity.toString().isEmpty ? "0" : quantity);
//     weight = double.parse(weight.toString().isEmpty ? "0" : weight);
//     totalWeight = double.parse(totalWeight.toString().isEmpty ? "0" : totalWeight);
//     length = int.parse(length.toString().isEmpty ? "0" : length);
//     width = int.parse(width.toString().isEmpty ? "0" : width);
//     height = int.parse(height.toString().isEmpty ? "0" : height);
//     totalCBM = double.parse(totalCBM.toString().isEmpty ? "0" : totalCBM);
//     cbm = double.parse(cbm.toString().isEmpty ? "0" : cbm);
//
//     print({packing, quantity, packingQuantity, weight, totalWeight, length, width, height, totalCBM, cbm});
//     setState(() {
//       if (packing > 0 && type == "packing") {
//         quantityController.text.isEmpty;
//         quantityController.text = "${packing * packingQuantity}";
//       } else if (packingQuantity > 0 && type == "packing") {
//         quantityController.text = packingQuantity.toString();
//       }
//
//       if (weight > 0) {
//         if (packing > 0) {
//           print("______if packing is not zero_________");
//           totalWController.text = ((packing * weight) / 1000).toStringAsFixed(3);
//         }
//         if ((packing == null || packing.toString().isEmpty || packing.toString() == "0.0") && quantity > 0) {
//           print("______if quantity is not zero_________");
//           totalWController.text = ((quantity * weight) / 1000).toStringAsFixed(3);
//         }
//       }
//
//       if (length > 0 && width > 0 && height > 0) {
//         cbmController.text = ((length * width * height) / 1000000).toStringAsFixed(3);
//         cbm = ((length * width * height) / 1000000);
//
//         if (packing > 0) {
//           totalCbmController.text = (cbm * packing).toStringAsFixed(3);
//         }
//
//         if (packing == null && quantity > 0) {
//           totalCbmController.text = (cbm * quantity).toStringAsFixed(3);
//           ;
//         }
//       }
//     });
//   }
// }
//
// String intStringValue(dynamic value) {
//   if (value == null || value == '') {
//     return "";
//   } else {
//     return double.tryParse(value.toString())!.toInt().toString() ?? "";
//   }
// }
