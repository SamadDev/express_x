// import 'package:x_express/Services/Usr%20Form/Receive/open_orders.dart';
// import 'package:x_express/Services/Usr%20Form/Receive/revceive_list.dart';
// import 'package:x_express/Utils/exports.dart';
// import 'package:intl/intl.dart';
//
// class UserFormScreenNext extends StatefulWidget {
//   final data;
//   UserFormScreenNext({this.data});
//   _UserFormScreenNextState createState() => _UserFormScreenNextState();
// }
//
// class _UserFormScreenNextState extends State<UserFormScreenNext> {
//   final formKey = GlobalKey<FormState>();
//
//   var dateController = TextEditingController();
//   var customerController = TextEditingController();
//   var refController = TextEditingController();
//   var descriptionController = TextEditingController();
//   var customerData;
//   var codesList;
//
//   var customerId = '';
//   String id = '';
//   String uniqueId = '';
//   String receiveNo = '';
//
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
//
//   DateTime initialDate = DateTime.now();
//
//   final List<File?> _images = [];
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
//   @override
//   void dispose() {
//     dateController.dispose();
//     customerController.dispose();
//     refController.dispose();
//     descriptionController.dispose();
//     codeController.dispose();
//     itemController.dispose();
//     cartonController.dispose();
//     quantityController.dispose();
//     totalQController.dispose();
//     heightController.dispose();
//     widthController.dispose();
//     totalCbmController.dispose();
//     lengthController.dispose();
//     weightController.dispose();
//     totalWController.dispose();
//     super.dispose();
//   }
//
//   void initState() {
//     final data = Provider.of<ReceiveServices>(context, listen: false);
//     final userForm = Provider.of<UserFormService>(context, listen: false);
//     userForm.items = [];
//     descriptionController.clear();
//     refController.clear();
//     customerData = null;
//     userForm.markValue = '';
//     userForm.warehouseValue = '';
//
//     if (widget.data != null) {
//       data.getReceiveOrderWithId(context: context, id: widget.data).then((value) {
//         setState(() {
//           userForm.items = data.updateReceiveData['details'];
//           userForm.warehouseValue = data.updateReceiveData['warehouseId'].toString();
//           userForm.markValue = data.updateReceiveData['customerCode']['id'].toString() ?? "";
//           refController.text = data.updateReceiveData['refNo'] ?? "";
//           descriptionController.text = data.updateReceiveData['description'] ?? "";
//           customerController.text = data.updateReceiveData['customer']["name"] ?? "";
//           customerId = data.updateReceiveData["customerId"].toString() ?? "";
//           id = data.updateReceiveData["id"].toString();
//           receiveNo = data.updateReceiveData["receiveNo"].toString();
//           uniqueId = data.updateReceiveData["uniqueId"].toString();
//           dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(data.updateReceiveData['receiveDate']));
//           codesList = data.receiveDataModule!.customer!.customerCodes;
//           customerData = data.receiveDataModule!.customer;
//         });
//       });
//     } else {
//       dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
//     }
//
//     super.initState();
//   }
//
//   Widget build(BuildContext context) {
//     final warehouse = Provider.of<WarehouseService>(context, listen: false);
//     final userForm = Provider.of<UserFormService>(context, listen: false);
//     final loading = Provider.of<UserFormService>(context, listen: true);
//     print(userForm.items.length);
//     return GestureDetector(
//       onTap: () {
//         SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
//       },
//       child: Scaffold(
//           resizeToAvoidBottomInset: true,
//           backgroundColor: AppTheme.grey_thick,
//           bottomNavigationBar: Padding(
//             padding: MediaQuery.of(context).viewInsets,
//             child: Container(
//               padding: EdgeInsets.only(bottom: 30, top: 25),
//               color: AppTheme.white,
//               child: Row(children: [
//                 // Expanded(
//                 //   child: InkWell(
//                 //     onTap: () {
//                 //       navigator_route(context: context, page: ItemFormScreen());
//                 //     },
//                 //     child: Card(
//                 //       margin: EdgeInsets.symmetric(horizontal: 12),
//                 //       child: Container(
//                 //         padding: EdgeInsets.all(16),
//                 //         decoration: BoxDecoration(
//                 //             color: AppTheme.white,
//                 //             border: Border.all(width: 0, color: AppTheme.primary),
//                 //             borderRadius: BorderRadius.circular(8)),
//                 //         child: Text(
//                 //           "Add Items",
//                 //           textAlign: TextAlign.center,
//                 //           style: TextStyle(color: AppTheme.primary),
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       if (!formKey.currentState!.validate()) {
//                         return;
//                       }
//                       formKey.currentState!.save();
//                       double totalCBM = 0;
//                       double totalWeight = 0;
//                       double totalQuantity = 0;
//                       double totalPacking = 0;
//
//                       for (var item in userForm.items) {
//                         print(userForm.items);
//                         totalCBM += _parseDouble(item["totalCBM"]);
//                         totalWeight += _parseDouble(item["totalWeight"]);
//                         totalQuantity += _parseDouble(item["quantity"]);
//                         totalPacking += _parseDouble(item["packing"]);
//                       }
//
//                       if (widget.data != null) {
//                         {
//                           userForm.updateOrderReceive(context: context, data: {
//                             'totalCBM': totalCBM ?? 0,
//                             'totalWeight': totalWeight ?? 0,
//                             'totalQty': totalQuantity ?? 0,
//                             'totalPacking': totalPacking ?? 0,
//                             'receiveDate': dateController.text ?? "",
//                             'refNo': refController.text ?? "",
//                             'refDate': dateController.text ?? "",
//                             'customerId': customerId.toString() ?? "",
//                             'description': descriptionController.text ?? "",
//                             'customerCodeId': customerData == null
//                                 ? ""
//                                 : customerData.customerCodes!.length == 1
//                                     ? customerData.customerCodes![0].id.toString()
//                                     : userForm.markValue.toString(),
//                             'warehouseId': userForm.warehouseValue.toString(),
//                             "details": userForm.items,
//                             "id": id.toString(),
//                             "uniqueId": uniqueId,
//                             "receiveNo": receiveNo.toString(),
//                             "orderId": userForm.orderId.isEmpty ? "" : userForm.orderId.toString()
//                           });
//                         }
//                       } else {
//                         userForm.postOrder(context: context, data: {
//                           'totalCBM': totalCBM ?? 0,
//                           'totalWeight': totalWeight ?? 0,
//                           'totalQty': totalQuantity ?? 0,
//                           'totalPacking': totalPacking ?? 0,
//                           'receiveDate': dateController.text ?? "",
//                           'refNo': refController.text ?? "",
//                           'refDate': dateController.text ?? "",
//                           'customerId': customerData!.id.toString() ?? "",
//                           'description': descriptionController.text ?? "",
//                           'customerCodeId': customerData == null
//                               ? ""
//                               : customerData!.customerCodes!.length == 1
//                                   ? customerData!.customerCodes![0].id.toString()
//                                   : userForm.markValue.toString(),
//                           'warehouseId': userForm.warehouseValue.toString(),
//                           "details": userForm.items,
//                           "orderId": userForm.orderId.isEmpty ? "" : userForm.orderId.toString()
//                         });
//                       }
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(16),
//                       margin: EdgeInsets.symmetric(horizontal: 12),
//                       decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(8)),
//                       child: Text("Next", textAlign: TextAlign.center),
//                     ),
//                   ),
//                 )
//               ]),
//             ),
//           ),
//           appBar: AppBar(
//             elevation: 0.1,
//             backgroundColor: AppTheme.white,
//             title: Text(
//               widget.data != null ? "Edit Receive" : "New Receive",
//               style: TextStyle(fontSize: 16, color: AppTheme.black),
//             ),
//           ),
//           body: SafeArea(
//             child: Form(
//               key: formKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     UserFormCard(children: [
//                       GestureDetector(
//                           onTap: () async {
//                             SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
//                             initialDate = (await showDialog(
//                               barrierDismissible: false,
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return Theme(
//                                   data: ThemeData.light().copyWith(
//                                     colorScheme: ColorScheme.light(
//                                       primary: AppTheme.primary,
//                                       onPrimary: Colors.white,
//                                     ),
//                                   ),
//                                   child: DatePickerDialog(
//                                     firstDate: DateTime(1900),
//                                     lastDate: DateTime(2100),
//                                     initialDate: initialDate,
//                                   ),
//                                 );
//                               },
//                             ));
//
//                             setState(() {
//                               if (initialDate.toString() != 'null') {
//                                 dateController.text = DateFormat('yyyy-MM-dd').format(initialDate);
//                                 initialDate = initialDate;
//                               }
//                             });
//                           },
//                           child: CustomTextFormField(
//                               title: "Date",
//                               hintText: "Date",
//                               enabled: false,
//                               controller: dateController,
//                               borderType: true,
//                               verticalPadding: 8)),
//                       CustomTextFormField(
//                           textInputType: TextInputType.text,
//                           controller: refController,
//                           title: "Ref No",
//                           hintText: "Reference Number",
//                           borderType: true,
//                           verticalPadding: 8),
//                       Consumer<CustomersService>(
//                         builder: (ctx, customer, _) => Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             CustomTextFormField(
//                               isRequired: true,
//                               validator: FormValidator.isEmpty,
//                               title: "Customer",
//                               hintText: "Customer",
//                               controller: customerController,
//                               borderType: true,
//                               suffix: IconButton(
//                                 onPressed: () {
//                                   if (customerController.text.isEmpty) return;
//                                   ButtonSheetWidget(
//                                       context: context,
//                                       child: Scaffold(
//                                         appBar: AppBar(
//                                           leading: SizedBox.shrink(),
//                                           actions: [
//                                             IconButton(
//                                                 onPressed: () {
//                                                   Navigator.of(context).pop();
//                                                 },
//                                                 icon: Icon(Icons.close))
//                                           ],
//                                         ),
//                                         body: FutureBuilder(
//                                             future: customer.getCustomers(customer: customerController.text),
//                                             builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
//                                                 ? Center(
//                                                     child: CircularProgressIndicator(
//                                                       color: AppTheme.primary,
//                                                     ),
//                                                   )
//                                                 : Consumer<OpenOrderServices>(
//                                                     builder: (ctx, loading, _) => customer.customersList.isEmpty
//                                                         ? EmptyScreen()
//                                                         : ListView.separated(
//                                                             padding: EdgeInsets.all(18),
//                                                             itemBuilder: (ctx, i) => SizedBox(
//                                                                   width: double.infinity,
//                                                                   child: InkWell(
//                                                                     onTap: () async {
//                                                                       setState(() {
//                                                                         customerData = customer.customersList[i];
//                                                                         customerController.text =
//                                                                             customer.customersList[i].name.toString();
//                                                                       });
//                                                                       navigator_route_pop(context: context);
//                                                                       ButtonSheetWidget(
//                                                                           context: context,
//                                                                           heightFactor: 0.7,
//                                                                           child:
//                                                                               OpenOrder(customerId: customerData!.id));
//                                                                     },
//                                                                     child: Padding(
//                                                                       padding: const EdgeInsets.all(8.0),
//                                                                       child: Column(
//                                                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                                                         children: [
//                                                                           Row(
//                                                                             children: [
//                                                                               Icon(
//                                                                                 Icons.person,
//                                                                                 color: AppTheme.grey_thin,
//                                                                               ),
//                                                                               SizedBox(width: 8),
//                                                                               Expanded(
//                                                                                 child: RichText(
//                                                                                   text: TextSpan(
//                                                                                     children: [
//                                                                                       TextSpan(
//                                                                                           text:
//                                                                                               "${customer.customersList[i].name} ",
//                                                                                           style: TextStyle(
//                                                                                               color: AppTheme.black,
//                                                                                               fontFamily: "sf_med",
//                                                                                               fontSize: 18)),
//                                                                                       TextSpan(
//                                                                                           text: "-",
//                                                                                           style: TextStyle(
//                                                                                               color: AppTheme.black)),
//                                                                                       TextSpan(
//                                                                                           text:
//                                                                                               "${customer.customersList[i].code}",
//                                                                                           style: TextStyle(
//                                                                                               color: AppTheme.black,
//                                                                                               fontFamily: "sf_med",
//                                                                                               fontSize: 16)),
//                                                                                     ],
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                           SizedBox(height: 8),
//                                                                           Padding(
//                                                                             padding: const EdgeInsets.symmetric(
//                                                                                 horizontal: 33.0),
//                                                                             child: Wrap(
//                                                                                 children: customer
//                                                                                     .customersList[i].customerCodes!
//                                                                                     .map<Widget>((e) => RawChip(
//                                                                                           padding: EdgeInsets.symmetric(
//                                                                                               vertical: 0),
//                                                                                           label: Text(
//                                                                                             e.name.toString(),
//                                                                                             style: TextStyle(
//                                                                                               color: AppTheme.black,
//                                                                                               fontSize: 11,
//                                                                                               fontFamily: 'sf_med',
//                                                                                               fontWeight:
//                                                                                                   FontWeight.w500,
//                                                                                             ),
//                                                                                           ),
//                                                                                         ))
//                                                                                     .toList()),
//                                                                           )
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                             separatorBuilder: (ctx, div) => Divider(),
//                                                             itemCount: customer.customersList.length))),
//                                       ),
//                                       heightFactor: 0.7);
//                                 },
//                                 icon: Icon(Icons.search, color: AppTheme.primary),
//                               ),
//                               verticalPadding: 8,
//                             ),
//                             SizedBox(height: 8),
//                             RawChipWidget(
//                                 title: "Shipment Mark",
//                                 list: customerData == null ? [] : customerData.customerCodes,
//                                 type: "mark")
//                           ],
//                         ),
//                       ),
//                     ]),
//                     UserFormCard(children: [
//                       FutureBuilder(
//                           future: warehouse.getWarehouse(),
//                           builder: (ctx, snap) => warehouse.isLoading
//                               ? ShimmerEffect(width: double.infinity, height: 30)
//                               : RawChipWidget(
//                                   title: "Warehouse",
//                                   warehouseList: warehouse.warehouseList.isEmpty ? [] : warehouse.warehouseList,
//                                   type: "shipment"))
//                     ]),
//                     Consumer<UserFormService>(
//                         builder: (ctx, items, _) => items.items.isEmpty
//                             ? SizedBox.shrink()
//                             : UserFormCard(
//                                 children: items.items.map((e) {
//                                 final index = items.items.indexOf(e);
//                                 return ItemCardOrderReceive(
//                                   type: "disable",
//                                   item: e,
//                                   index: index,
//                                 );
//                               }).toList())),
//                     UserFormCard(
//                       children: [
//                         CustomTextFormField(
//                           textInputType: TextInputType.text,
//                           controller: descriptionController,
//                           title: "Description",
//                           hintText: "Description",
//                           borderType: true,
//                           verticalPadding: 8,
//                         ),
//                         // GestureDetector(
//                         //   onTap: () {
//                         //     showDialog(
//                         //       context: context,
//                         //       builder: (context) {
//                         //         return AlertDialog(
//                         //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                         //           title: const Text(
//                         //             "Image from:",
//                         //             style: TextStyle(fontSize: 26),
//                         //           ),
//                         //           content: Column(
//                         //             crossAxisAlignment: CrossAxisAlignment.start,
//                         //             mainAxisAlignment: MainAxisAlignment.start,
//                         //             mainAxisSize: MainAxisSize.min,
//                         //             children: [
//                         //               TextButton(
//                         //                   onPressed: () async {
//                         //                     await getImage(ImageSource.gallery, context);
//                         //                     Navigator.pop(context);
//                         //                   },
//                         //                   child: Row(
//                         //                     mainAxisAlignment: MainAxisAlignment.center,
//                         //                     children: const [
//                         //                       Icon(Icons.image, color: AppTheme.primary, size: 22),
//                         //                       SizedBox(
//                         //                         width: 6,
//                         //                       ),
//                         //                       Text(
//                         //                         "From gallery",
//                         //                         style: TextStyle(
//                         //                             fontFamily: "sf_med", fontSize: 16, color: AppTheme.black),
//                         //                       ),
//                         //                     ],
//                         //                   )),
//                         //               const Divider(),
//                         //               TextButton(
//                         //                 onPressed: () async {
//                         //                   await getImage(ImageSource.camera, context);
//                         //                   Navigator.pop(context);
//                         //                 },
//                         //                 child: Row(
//                         //                   mainAxisAlignment: MainAxisAlignment.center,
//                         //                   children: const [
//                         //                     Icon(Icons.camera_alt_rounded, color: AppTheme.primary, size: 22),
//                         //                     SizedBox(
//                         //                       width: 6,
//                         //                     ),
//                         //                     Text(
//                         //                       "From Camera",
//                         //                       style:
//                         //                           TextStyle(fontFamily: "sf_med", fontSize: 16, color: AppTheme.black),
//                         //                     ),
//                         //                   ],
//                         //                 ),
//                         //               )
//                         //             ],
//                         //           ),
//                         //         );
//                         //       },
//                         //     );
//                         //   },
//                         //   child: CustomTextFormField(
//                         //     title: "Upload Image",
//                         //     hintText: "upload Image",
//                         //     borderType: true,
//                         //     verticalPadding: 8,
//                         //     enabled: false,
//                         //     suffix: Icon(_images.isEmpty ? Icons.link : Icons.add),
//                         //   ),
//                         // ),
//                         // Wrap(
//                         //   direction: Axis.horizontal,
//                         //   children: List.generate(
//                         //     _images.length,
//                         //     (index) {
//                         //       if (_images[index] != null) {
//                         //         return Stack(
//                         //           alignment: Alignment.topRight,
//                         //           clipBehavior: Clip.hardEdge,
//                         //           children: [
//                         //             SizedBox(
//                         //               height: MediaQuery.of(context).size.width * .31,
//                         //               width: MediaQuery.of(context).size.width * .31,
//                         //               child: Padding(
//                         //                 padding: const EdgeInsets.all(4.0),
//                         //                 child: Image.file(
//                         //                   _images[index]!,
//                         //                   fit: BoxFit.cover,
//                         //                 ),
//                         //               ),
//                         //             ),
//                         //             Positioned(
//                         //               top: 4,
//                         //               right: 4,
//                         //               child: Container(
//                         //                 height: 30,
//                         //                 width: 30,
//                         //                 decoration:
//                         //                     BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(.3)),
//                         //                 child: FittedBox(
//                         //                   child: IconButton(
//                         //                     icon: const Icon(Icons.delete),
//                         //                     color: Colors.red,
//                         //                     onPressed: () {
//                         //                       areYouSure(
//                         //                           onPress: () {
//                         //                             _images.remove(_images[index]);
//                         //                           },
//                         //                           context: context,
//                         //                           content: "Are you sure to Remove this image",
//                         //                           title: "Remove Image");
//                         //                     },
//                         //                   ),
//                         //                 ),
//                         //               ),
//                         //             )
//                         //           ],
//                         //         );
//                         //       } else {
//                         //         return SizedBox();
//                         //       }
//                         //     },
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                     SizedBox(height: 100)
//                   ],
//                 ),
//               ),
//             ),
//           )),
//     );
//   }
// }
//
// class RawChipWidget extends StatelessWidget {
//   final title;
//   final list;
//   final List<WarehouseModule>? warehouseList;
//   final type;
//   const RawChipWidget({
//     Key? key,
//     this.type,
//     this.warehouseList,
//     this.title,
//     this.list,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return (type == "mark" && list!.isEmpty) || (type == "warehouse" && warehouseList!.isEmpty)
//         ? SizedBox.shrink()
//         : Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                 child: Row(
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                           fontSize: 13, fontFamily: 'sf_med', fontWeight: FontWeight.w500, color: AppTheme.black),
//                     ),
//                     SizedBox(width: 6),
//                     Icon(Icons.star, color: AppTheme.red, size: 10)
//                   ],
//                 ),
//               ),
//               Consumer<UserFormService>(builder: (ctx, userForm, _) {
//                 return type == "mark"
//                     ? Wrap(
//                         crossAxisAlignment: WrapCrossAlignment.end,
//                         children: List.generate(
//                           list!.length,
//                           (index) {
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 3.0),
//                               child: RawChip(
//                                 padding: EdgeInsets.symmetric(horizontal: 3),
//                                 selectedColor: AppTheme.grey_thin.withOpacity(0.1),
//                                 onPressed: () {
//                                   userForm.setMarkValue(list![index].id.toString());
//                                 },
//                                 label: Text(
//                                   list![index].name,
//                                   style: TextStyle(
//                                     color: AppTheme.black,
//                                     fontSize: 13,
//                                     fontFamily: 'sf_med',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 selected: list!.length == 1
//                                     ? true
//                                     : list![index].id.toString() == userForm.markValue
//                                         ? true
//                                         : false,
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                     : Wrap(
//                         crossAxisAlignment: WrapCrossAlignment.end,
//                         children: List.generate(
//                           warehouseList!.length,
//                           (index) {
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 3.0),
//                               child: RawChip(
//                                 padding: EdgeInsets.symmetric(horizontal: 3),
//                                 selectedColor: AppTheme.grey_thin.withOpacity(0.1),
//                                 onPressed: () {
//                                   userForm.setWarehouseValue(warehouseList![index].id.toString());
//                                 },
//                                 label: Text(
//                                   warehouseList![index].name!,
//                                   style: TextStyle(
//                                     color: AppTheme.black,
//                                     fontSize: 13,
//                                     fontFamily: 'sf_med',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 selected: warehouseList![index].id.toString() == userForm.warehouseValue ? true : false,
//                               ),
//                             );
//                           },
//                         ),
//                       );
//               }),
//             ],
//           );
//   }
// }
//
// class UserFormCard extends StatelessWidget {
//   final children;
//   const UserFormCard({Key? key, this.children}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       color: AppTheme.white,
//       margin: EdgeInsets.only(bottom: 12),
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: children,
//       ),
//     );
//   }
// }
//
// class ItemCardOrderReceive extends StatelessWidget {
//   final item;
//   final index;
//   final type;
//   ItemCardOrderReceive({this.item, this.index, this.type});
//   @override
//   Widget build(BuildContext context) {
//     final language = Provider.of<Language>(context, listen: false).getWords;
//     return GestureDetector(
//       onTap: () {
//         type == "disable"
//             ? print("")
//             : ButtonSheetWidget(context: context, heightFactor: 0.8, child: ItemFormScreen(index: index));
//       },
//       child: Container(
//         decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(8)),
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//         // margin: const EdgeInsets.symmetric(vertical: 8),
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Container(
//                 //   width: 45,
//                 //   height: 45,
//                 //   decoration: BoxDecoration(
//                 //     color: AppTheme.grey_thick,
//                 //     borderRadius: BorderRadius.circular(5),
//                 //   ),
//                 //   child: ClipRRect(
//                 //     borderRadius: BorderRadius.circular(5),
//                 //     child:item['attachments'].isEmpty?SizedBox.shrink():
//                 //         Text(item['attachments'])
//                 //     // Image.file(
//                 //     //   item['attachments'][0],
//                 //     // ),
//                 //   ),
//                 // ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       (item['itemCode'] == null || item['itemCode'].isEmpty)
//                           ? SizedBox.shrink()
//                           : item['itemCode'] == null
//                               ? SizedBox.shrink()
//                               : Text(
//                                   item['itemCode'] ?? "",
//                                   style: TextStyle(
//                                     fontSize: 13,
//                                     color: Colors.black.withOpacity(0.65),
//                                   ),
//                                 ),
//                       SizedBox(height: 3),
//                       IntrinsicHeight(
//                         child: Text(
//                           item['itemName'] ?? "",
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black.withOpacity(0.85),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 type == "disable"
//                     ? SizedBox()
//                     : Consumer<UserFormService>(
//                         builder: (ctx, action, _) => Container(
//                               child: PopupMenuButton<String>(
//                                 child: Icon(
//                                   Icons.more_vert,
//                                   size: 16,
//                                   color: AppTheme.grey_thin,
//                                 ),
//                                 padding: EdgeInsets.zero,
//                                 itemBuilder: (BuildContext context) {
//                                   return <PopupMenuEntry<String>>[
//                                     PopupMenuItem<String>(
//                                       value: 'edit',
//                                       child: Text('Edit'),
//                                     ),
//                                     PopupMenuItem<String>(
//                                       value: 'delete',
//                                       child: Text('Delete'),
//                                     ),
//                                   ];
//                                 },
//                                 onSelected: (String value) {
//                                   if (value == "edit") {
//                                     ButtonSheetWidget(
//                                         context: context, heightFactor: 0.8, child: ItemFormScreen(index: index));
//                                   } else {
//                                     action.removeItems(item['itemCode']);
//                                   }
//                                 },
//                               ),
//                             )),
//               ],
//             ),
//             //
//
//             SizedBox(height: 20),
//             IntrinsicHeight(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _StatisticCard(
//                     title: language["carton"] ?? "",
//                     type: "number",
//                     value: item['packing'].toString() ?? "",
//                   ),
//                   VerticalDivider(
//                     thickness: 1.1,
//                     color: Colors.grey.shade300,
//                   ),
//                   _StatisticCard(
//                     title: language["quantity"].toString(),
//                     type: "number",
//                     value: item['quantity'].toString(),
//                   ),
//                   VerticalDivider(
//                     thickness: 1.1,
//                     color: Colors.grey.shade300,
//                   ),
//                   _StatisticCard(
//                     title: "Total Weight",
//                     type: "number",
//                     value: item['totalWeight'] == null ? "0" : item['totalWeight'].toString() ?? "0",
//                   ),
//                   VerticalDivider(
//                     thickness: 1.1,
//                     color: Colors.grey.shade300,
//                   ),
//                   _StatisticCard(
//                     title: "Total CBM",
//                     value: "${item['totalCBM'] ?? "0"}",
//                   ),
//                 ],
//               ),
//             ),
//             item['description'] == null
//                 ? SizedBox.shrink()
//                 : Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                     ).copyWith(top: 25),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           "Description",
//                           style: const TextStyle(
//                             fontSize: 13,
//                             fontFamily: 'sf_med',
//                             fontWeight: FontWeight.w500,
//                             color: AppTheme.grey_thin,
//                           ),
//                         ),
//                         SizedBox(height: 6),
//                         Text(
//                           item['description'] ?? "",
//                           style: const TextStyle(
//                             fontSize: 13,
//                             fontFamily: 'sf_bold',
//                             fontWeight: FontWeight.bold,
//                             color: AppTheme.grey_thin,
//                           ),
//                           textAlign: TextAlign.justify,
//                         ),
//                       ],
//                     ),
//                   ),
//             Divider(
//               thickness: 1.1,
//               color: Colors.grey.shade300,
//               height: 35,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _StatisticCard extends StatelessWidget {
//   const _StatisticCard({
//     required this.title,
//     this.value,
//     this.type = '',
//   });
//
//   final String title;
//   final String? value;
//   final String type;
//
//   @override
//   Widget build(BuildContext context) {
//     print("value is: $value");
//     return Column(
//       children: [
//         const SizedBox(height: 4),
//         Text(
//           title ?? "",
//           style: const TextStyle(
//             fontSize: 13,
//             fontFamily: 'sf_med',
//             fontWeight: FontWeight.w500,
//             color: AppTheme.grey_thin,
//           ),
//         ),
//         SizedBox(height: 5),
//         Text(
//           (value == null || value.toString().isEmpty)
//               ? ""
//               : type == "number"
//                   ? NumberFormat.currency(symbol: "").format(double.parse(value.toString()))
//                   : value ?? "",
//           style: const TextStyle(
//             fontSize: 14,
//             fontFamily: 'sf_bold',
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// double _parseDouble(dynamic value) {
//   if (value == null || value == '') {
//     return 0.0;
//   } else {
//     return double.tryParse(value.toString()) ?? 0.0;
//   }
// }
