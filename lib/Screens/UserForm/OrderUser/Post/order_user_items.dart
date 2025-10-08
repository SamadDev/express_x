// import 'package:x_express/Modules/Currency/currency_type.dart';
// import 'package:x_express/Modules/User%20From/Customers/supplier.dart';
// import 'package:x_express/Screens/User Form/Order User/Post/item_order_form.dart';
// import 'package:x_express/Services/Usr Form/User Order/order_user.dart';
// import 'package:x_express/Services/Usr%20Form/Customers/supplier.dart';
// import 'package:x_express/Utils/exports.dart';
// import 'package:x_express/Widgets/statistic_card.dart';
//
// class OrderItemsScreen extends StatefulWidget {
//   final data;
//   OrderItemsScreen({this.data});
//   _OrderItemsScreenState createState() => _OrderItemsScreenState();
// }
//
// class _OrderItemsScreenState extends State<OrderItemsScreen> {
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
//
//   var codeController = TextEditingController();
//   var orderNoController = TextEditingController();
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
//     cartonController.dispose();
//     quantityController.dispose();
//     totalQController.dispose();
//     heightController.dispose();
//     widthController.dispose();
//     totalCbmController.dispose();
//     lengthController.dispose();
//     weightController.dispose();
//     totalWController.dispose();
//     orderNoController.dispose();
//     super.dispose();
//   }
//
//   void initState() {
//     final data = Provider.of<OrderUserServices>(context, listen: false);
//     final userForm = Provider.of<OrderUserServices>(context, listen: false);
//     userForm.items = [];
//     descriptionController.clear();
//     refController.clear();
//     orderNoController.clear();
//     customerData = null;
//     userForm.markValue = '';
//     userForm.currencyValue = '';
//     userForm.supplierValue = '';
//     if (widget.data != null) {
//       data.getOrderWithId(context: context, id: widget.data).then((value) {
//         setState(() {
//           userForm.items = data.updateOrderData['details'];
//           userForm.markValue = data.updateOrderData['customerCode']['id'].toString() ?? "";
//           userForm.supplierValue = data.updateOrderData["supplierId"].toString() ?? "";
//           userForm.currencyValue = data.updateOrderData['currencyId'].toString();
//           refController.text = data.updateOrderData['refNo'] ?? "";
//           descriptionController.text = data.updateOrderData['description'] ?? "";
//           customerController.text = data.updateOrderData['customer']["name"] ?? "";
//           customerId = data.updateOrderData["customerId"].toString() ?? "";
//           id = data.updateOrderModuleData.id.toString();
//           orderNoController.text = data.updateOrderData["orderNo"].toString();
//           uniqueId = data.updateOrderData["uniqueId"].toString();
//           dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(data.updateOrderData['orderDate']));
//
//           customerData = data.updateOrderModuleData.customer;
//           print("order is: $id");
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
//     final userForm = Provider.of<OrderUserServices>(context, listen: false);
//     final currency = Provider.of<CurrencyTypeService>(context, listen: false);
//     final supplier = Provider.of<SupplierService>(context, listen: false);
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
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       navigator_route(context: context, page: ItemOrderFormScreen());
//                     },
//                     child: Card(
//                       margin: EdgeInsets.symmetric(horizontal: 12),
//                       child: Container(
//                         padding: EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                             color: AppTheme.white,
//                             border: Border.all(width: 0, color: AppTheme.primary),
//                             borderRadius: BorderRadius.circular(8)),
//                         child: Text(
//                           "Add Items",
//                           textAlign: TextAlign.center,
//                           color: AppTheme.primary),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       if (!formKey.currentState!.validate()) {
//                         return;
//                       }
//                       formKey.currentState!.save();
//                       double total = 0;
//
//                       for (var item in userForm.items) {
//                         print(userForm.items);
//                         total += _parseDouble(item["total"]);
//                       }
//
//                       if (widget.data != null) {
//                         {
//                           userForm.updateOrderReceive(context: context, data: {
//                             "id": id,
//                             "orderNo": orderNoController.text,
//                             "orderDate": dateController.text,
//                             "refNo": refController.text,
//                             "refDate": dateController.text,
//                             'customerId': customerData!.id ?? "",
//                             'customerCodeId': customerData == null
//                                 ? ""
//                                 : customerData.customerCodes!.length == 1
//                                 ? customerData.customerCodes![0].id.toString()
//                                 : userForm.markValue.toString(),
//
//                             "total": total,
//                             "supplierId": userForm.supplierValue,
//                             "currencyId": userForm.currencyValue,
//                             "description": descriptionController.text,
//                             "uniqueId": uniqueId,
//                             "details": userForm.items
//                           });
//                         }
//                       } else {
//                         userForm.postOrder(context: context, data: {
//                           "orderNo": orderNoController.text,
//                           "orderDate": DateTime.now().toString(),
//                           "refNo": refController.text,
//                           "refDate": dateController.text,
//                           'customerId': customerData!.id ?? "",
//                           'customerCodeId': customerData == null
//                               ? ""
//                               : customerData.customerCodes!.length == 1
//                               ? customerData.customerCodes![0].id.toString()
//                               : userForm.markValue.toString(),
//                           "total": total,
//                           "supplierId": userForm.supplierValue,
//                           "currencyId": userForm.currencyValue,
//                           "statusId": 1,
//                           "description": descriptionController.text,
//                           "details": userForm.items
//                         });
//                       }
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(16),
//                       margin: EdgeInsets.symmetric(horizontal: 12),
//                       decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(8)),
//                       child: Text(
//                         "Submit",
//                         textAlign: TextAlign.center,
//                       ),
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
//               widget.data != null ? "Edit Order" : "New Order",
//               fontSize: 16, color: AppTheme.black),
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
//                       CustomTextFormField(
//                           textInputType: TextInputType.text,
//                           controller: orderNoController,
//                           title: "Order No",
//                           hintText: "Order No",
//                           borderType: true,
//                           verticalPadding: 8),
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
//                           verticalPadding: 8)
//                     ]),
//                     UserFormCard(
//                       children: [
//                         Consumer<CustomersService>(
//                           builder: (ctx, customer, _) => Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               CustomTextFormField(
//                                 isRequired: true,
//                                 validator: FormValidator.isEmpty,
//                                 title: "Customer",
//                                 hintText: "Customer",
//                                 controller: customerController,
//                                 borderType: true,
//                                 suffix: IconButton(
//                                   onPressed: () {
//                                     if (customerController.text.isEmpty) return;
//                                     ButtonSheetWidget(
//                                         context: context,
//                                         child: Scaffold(
//                                           appBar: AppBar(
//                                             leading: SizedBox.shrink(),
//                                             actions: [
//                                               IconButton(
//                                                   onPressed: () {
//                                                     Navigator.of(context).pop();
//                                                   },
//                                                   icon: Icon(Icons.close))
//                                             ],
//                                           ),
//                                           body: FutureBuilder(
//                                               future: customer.getCustomers(customer: customerController.text),
//                                               builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
//                                                   ? Center(
//                                                 child: CircularProgressIndicator(
//                                                   color: AppTheme.primary,
//                                                 ),
//                                               )
//                                                   : Consumer<OpenOrderServices>(
//                                                   builder: (ctx, loading, _) => customer.customersList.isEmpty
//                                                       ? EmptyScreen()
//                                                       : ListView.separated(
//                                                       padding: EdgeInsets.all(18),
//                                                       itemBuilder: (ctx, i) => SizedBox(
//                                                         width: double.infinity,
//                                                         child: InkWell(
//                                                           onTap: () async {
//                                                             setState(() {
//                                                               customerData = customer.customersList[i];
//                                                               customerController.text =
//                                                                   customer.customersList[i].name.toString();
//                                                               supplier.getSupplier(
//                                                                   customer: customerData.id);
//                                                             });
//                                                             navigator_route_pop(context: context);
//                                                           },
//                                                           child: Padding(
//                                                             padding: const EdgeInsets.all(8.0),
//                                                             child: Column(
//                                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                                               children: [
//                                                                 Row(
//                                                                   children: [
//                                                                     Icon(
//                                                                       Icons.person,
//                                                                       color: AppTheme.grey_thin,
//                                                                     ),
//                                                                     SizedBox(width: 8),
//                                                                     RichText(
//                                                                       text: TextSpan(
//                                                                         children: [
//                                                                           TextSpan(
//                                                                               text:
//                                                                               "${customer.customersList[i].name} ",
//                                                                               
//                                                                                   color: AppTheme.black,
//                                                                                   fontFamily: "sf_med",
//                                                                                   fontSize: 18)),
//                                                                           TextSpan(
//                                                                               text: "-",
//                                                                               
//                                                                                   color: AppTheme.black)),
//                                                                           TextSpan(
//                                                                               text:
//                                                                               "${customer.customersList[i].code}",
//                                                                               
//                                                                                   color: AppTheme.black,
//                                                                                   fontFamily: "sf_med",
//                                                                                   fontSize: 16)),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                                 SizedBox(height: 8),
//                                                                 Padding(
//                                                                   padding: const EdgeInsets.symmetric(
//                                                                       horizontal: 33.0),
//                                                                   child: Wrap(
//                                                                       children: customer
//                                                                           .customersList[i].customerCodes!
//                                                                           .map<Widget>((e) => Text(
//                                                                         e.name.toString(),
//                                                                         
//                                                                             color: AppTheme.black,
//                                                                             fontFamily: "sf_med",
//                                                                             fontSize: 14),
//                                                                       ))
//                                                                           .toList()),
//                                                                 )
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       separatorBuilder: (ctx, div) => Divider(),
//                                                       itemCount: customer.customersList.length))),
//                                         ),
//                                         heightFactor: 0.7);
//                                   },
//                                   icon: Icon(Icons.search, color: AppTheme.primary),
//                                 ),
//                                 verticalPadding: 8,
//                               ),
//                               SizedBox(height: 8),
//                               RawChipWidget(
//                                   title: "Order Mark",
//                                   list: customerData == null ? [] : customerData.customerCodes,
//                                   type: "mark")
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Consumer<SupplierService>(
//                         builder: (ctx, supplier, _) => supplier.supplierList.isEmpty
//                             ? SizedBox.shrink()
//                             : UserFormCard(children: [
//                           RawChipWidget(
//                               title: "Supplier",
//                               supplierList: supplier.supplierList.isEmpty ? [] : supplier.supplierList,
//                               type: "supplier")
//                         ])),
//                     UserFormCard(children: [
//                       FutureBuilder(
//                           future: currency.getCurrencyType(),
//                           builder: (ctx, snap) =>
//                           // currency.isLoading
//                           //     ? ShimmerEffect(width: double.infinity, height: 30)
//                           //     :
//                           RawChipWidget(
//                               title: "Currency",
//                               currencyList: currency.currencyTypeList.isEmpty ? [] : currency.currencyTypeList,
//                               type: "currency"))
//                     ]),
//                     Consumer<OrderUserServices>(
//                         builder: (ctx, items, _) => items.items.isEmpty
//                             ? SizedBox.shrink()
//                             : UserFormCard(
//                             children: items.items.map((e) {
//                               final index = items.items.indexOf(e);
//                               return ItemCardOrderReceive(
//                                 item: e,
//                                 index: index,
//                                 length: items.items.length,
//                               );
//                             }).toList())),
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
//                         GestureDetector(
//                           onTap: () {
//                             showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return AlertDialog(
//                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                                   title: const Text(
//                                     "Image from:",
//                                     fontSize: 26),
//                                   ),
//                                   content: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       TextButton(
//                                           onPressed: () async {
//                                             await getImage(ImageSource.gallery, context);
//                                             Navigator.pop(context);
//                                           },
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             children: const [
//                                               Icon(Icons.image, color: AppTheme.primary, size: 22),
//                                               SizedBox(
//                                                 width: 6,
//                                               ),
//                                               Text(
//                                                 "From gallery",
//                                                 
//                                                     fontFamily: "sf_med", fontSize: 16, color: AppTheme.black),
//                                               ),
//                                             ],
//                                           )),
//                                       const Divider(),
//                                       TextButton(
//                                         onPressed: () async {
//                                           await getImage(ImageSource.camera, context);
//                                           Navigator.pop(context);
//                                         },
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: const [
//                                             Icon(Icons.camera_alt_rounded, color: AppTheme.primary, size: 22),
//                                             SizedBox(
//                                               width: 6,
//                                             ),
//                                             Text(
//                                               "From Camera",
//                                               style:
//                                               TextStyle(fontFamily: "sf_med", fontSize: 16, color: AppTheme.black),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           child: CustomTextFormField(
//                             title: "Upload Image",
//                             hintText: "Upload Image",
//                             borderType: true,
//                             verticalPadding: 8,
//                             enabled: false,
//                             suffix: Icon(_images.isEmpty ? Icons.link : Icons.add),
//                           ),
//                         ),
//                         Wrap(
//                           direction: Axis.horizontal,
//                           children: List.generate(
//                             _images.length,
//                                 (index) {
//                               if (_images[index] != null) {
//                                 return Stack(
//                                   alignment: Alignment.topRight,
//                                   clipBehavior: Clip.hardEdge,
//                                   children: [
//                                     SizedBox(
//                                       height: MediaQuery.of(context).size.width * .31,
//                                       width: MediaQuery.of(context).size.width * .31,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(4.0),
//                                         child: Image.file(
//                                           _images[index]!,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       top: 4,
//                                       right: 4,
//                                       child: Container(
//                                         height: 30,
//                                         width: 30,
//                                         decoration:
//                                         BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(.3)),
//                                         child: FittedBox(
//                                           child: IconButton(
//                                             icon: const Icon(Icons.delete),
//                                             color: Colors.red,
//                                             onPressed: () {
//                                               areYouSure(
//                                                   onPress: () {
//                                                     _images.remove(_images[index]);
//                                                   },
//                                                   context: context,
//                                                   content: "Are you sure to Remove this image",
//                                                   title: "Remove Image");
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 );
//                               } else {
//                                 return SizedBox();
//                               }
//                             },
//                           ),
//                         ),
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
//   final List<CurrencyTypeModule>? currencyList;
//   final List<SupplierModule>? supplierList;
//   final type;
//   const RawChipWidget({
//     Key? key,
//     this.type,
//     this.currencyList,
//     this.supplierList,
//     this.title,
//     this.list,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return (type == "mark" && list!.isEmpty)
//         ? SizedBox.shrink()
//         : Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 5.0),
//           child: Row(
//             children: [
//               Text(
//                 title,
//                 fontSize: 13, fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, color: AppTheme.black),
//               ),
//               SizedBox(width: 6),
//               Icon(Icons.star, color: AppTheme.red, size: 10)
//             ],
//           ),
//         ),
//         Consumer<OrderUserServices>(builder: (ctx, userForm, _) {
//           return type == "mark"
//               ? Wrap(
//             crossAxisAlignment: WrapCrossAlignment.end,
//             children: List.generate(
//               list!.length,
//                   (index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 3.0),
//                   child: RawChip(
//                     padding: EdgeInsets.symmetric(horizontal: 3),
//                     selectedColor: AppTheme.grey_thin.withOpacity(0.1),
//                     onPressed: () {
//                       userForm.setOrderMarkValue(list![index].id.toString());
//                     },
//                     label: Text(
//                       list![index].name,
//                       
//                         color: AppTheme.black,
//                         fontSize: 13,
//                         fontFamily: 'nrt-reg',fontWeight: FontWeight.w500,
//
//                       ),
//                     ),
//                     selected: list!.length == 1
//                         ? true
//                         : list![index].id.toString() == userForm.markValue
//                         ? true
//                         : false,
//                   ),
//                 );
//               },
//             ),
//           )
//               : type == "supplier"
//               ? Wrap(
//             crossAxisAlignment: WrapCrossAlignment.end,
//             children: List.generate(
//               supplierList!.length,
//                   (index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 3.0),
//                   child: RawChip(
//                     padding: EdgeInsets.symmetric(horizontal: 3),
//                     selectedColor: AppTheme.grey_thin.withOpacity(0.1),
//                     onPressed: () {
//                       userForm.setOrderSupplierValue(supplierList![index].id.toString());
//                     },
//                     label: Text(
//                       supplierList![index].name!,
//                       
//                         color: AppTheme.black,
//                         fontSize: 13,
//                         fontFamily: 'nrt-reg',fontWeight: FontWeight.w500,
//
//                       ),
//                     ),
//                     selected:
//                     supplierList![index].id.toString() == userForm.supplierValue ? true : false,
//                   ),
//                 );
//               },
//             ),
//           )
//               : Wrap(
//             crossAxisAlignment: WrapCrossAlignment.end,
//             children: List.generate(
//               currencyList!.length,
//                   (index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 3.0),
//                   child: RawChip(
//                     padding: EdgeInsets.symmetric(horizontal: 3),
//                     selectedColor: AppTheme.grey_thin.withOpacity(0.1),
//                     onPressed: () {
//                       userForm.setOrderCurrencyValue(currencyList![index].id.toString());
//                     },
//                     label: Text(
//                       currencyList![index].name!,
//                       
//                         color: AppTheme.black,
//                         fontSize: 13,
//                         fontFamily: 'nrt-reg',fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     selected:
//                     currencyList![index].id.toString() == userForm.currencyValue ? true : false,
//                   ),
//                 );
//               },
//             ),
//           );
//         }),
//       ],
//     );
//   }
// }
//
// class RawChipWidgets extends StatelessWidget {
//   final title;
//   final List list;
//   final type;
//   final value;
//   final onTap;
//   const RawChipWidgets({
//     Key? key,
//     this.type,
//     this.title,
//     this.value,
//     required this.list,
//     this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return list.isEmpty
//         ? SizedBox.shrink()
//         : Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 5.0),
//           child: Row(
//             children: [
//               Text(
//                 title,
//                 fontSize: 13, fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, color: AppTheme.black),
//               ),
//               SizedBox(width: 6),
//               Icon(Icons.star, color: AppTheme.red, size: 10)
//             ],
//           ),
//         ),
//         Consumer<OrderUserServices>(builder: (ctx, userForm, _) {
//           return Wrap(
//             crossAxisAlignment: WrapCrossAlignment.end,
//             children: List.generate(
//               list.length,
//                   (index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 3.0),
//                   child: RawChip(
//                     padding: EdgeInsets.symmetric(horizontal: 3),
//                     selectedColor: AppTheme.grey_thin.withOpacity(0.1),
//                     onPressed: onTap,
//                     label: Text(
//                       list[index].name,
//                       
//                         color: AppTheme.black,
//                         fontSize: 13,
//                         fontFamily: 'nrt-reg',fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     selected: list.length == 1
//                         ? true
//                         : list[index].id.toString() == value
//                         ? true
//                         : false,
//                   ),
//                 );
//               },
//             ),
//           );
//         }),
//       ],
//     );
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
//   final length;
//   ItemCardOrderReceive({this.item, this.index, this.length});
//   @override
//   Widget build(BuildContext context) {
//     final language = Provider.of<Language>(context, listen: false).getWords;
//     return GestureDetector(
//       onTap: () {
//         ButtonSheetWidget(context: context, heightFactor: 0.8, child: ItemOrderFormScreen(index: index));
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
//                           ? SizedBox.shrink()
//                           : Text(
//                         item['itemCode'] ?? "",
//                         
//                           fontSize: 13,
//                           color: Colors.black.withOpacity(0.65),
//                         ),
//                       ),
//                       SizedBox(height: 3),
//                       IntrinsicHeight(
//                         child: Text(
//                           item['itemName'] ?? "",
//                           
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black.withOpacity(0.85),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Consumer<OrderUserServices>(
//                     builder: (ctx, action, _) => Container(
//                       child: PopupMenuButton<String>(
//                         child: Icon(
//                           Icons.more_vert,
//                           size: 16,
//                           color: AppTheme.grey_thin,
//                         ),
//                         padding: EdgeInsets.zero,
//                         itemBuilder: (BuildContext context) {
//                           return <PopupMenuEntry<String>>[
//                             PopupMenuItem<String>(
//                               value: 'edit',
//                               child: Text('Edit'),
//                             ),
//                             PopupMenuItem<String>(
//                               value: 'delete',
//                               child: Text('Delete'),
//                             ),
//                           ];
//                         },
//                         onSelected: (String value) {
//                           if (value == "edit") {
//                             ButtonSheetWidget(
//                                 context: context,
//                                 heightFactor: 0.8,
//                                 child: ItemFormScreen(index: index));
//                           } else {
//                             action.removeItems(item['itemCode']);
//                           }
//                         },
//                       ),
//                     )),
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
//                   StatisticCard(
//                     title: "Carton",
//                     type: "number",
//                     value: item['packing'].toString(),
//                   ),
//                   VerticalDivider(
//                     thickness: 1.1,
//                     color: Colors.grey.shade300,
//                   ),
//                   StatisticCard(
//                     title: language["quantity"].toString(),
//                     type: "number",
//                     value: item['quantity'].toString(),
//                   ),
//                   VerticalDivider(
//                     thickness: 1.1,
//                     color: Colors.grey.shade300,
//                   ),
//                   StatisticCard(
//                     title: "Unit Price",
//                     type: "number",
//                     value: "${item['unitPrice'] ?? "0"}",
//                   ),
//                   VerticalDivider(
//                     thickness: 1.1,
//                     color: Colors.grey.shade300,
//                   ),
//                   StatisticCard(
//                     title: "Total",
//                     value: "${item['total'] ?? "0"}",
//                   ),
//                 ],
//               ),
//             ),
//             item['description'] == null
//                 ? SizedBox.shrink()
//                 : Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 8,
//               ).copyWith(top: 25),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     "Description",
//                     style: const TextStyle(
//                       fontSize: 13,
//                       fontFamily: 'nrt-reg',fontWeight: FontWeight.w500,
//                       color: AppTheme.grey_thin,
//                     ),
//                   ),
//                   SizedBox(height: 6),
//                   Text(
//                     item['description'] ?? "",
//                     style: const TextStyle(
//                       fontSize: 13,
//                       fontFamily: 'nrt-bold',fontWeight: FontWeight.bold,
//                       color: AppTheme.grey_thin,
//                     ),
//                     textAlign: TextAlign.justify,
//                   ),
//                 ],
//               ),
//             ),
//
//             if (length - 1 != index) ...[
//               SizedBox(height: 8),
//               Divider(height: 20, color: AppTheme.grey_between),
//             ]
//           ],
//         ),
//       ),
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
