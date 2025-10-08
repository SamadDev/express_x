import 'package:x_express/Utils/exports.dart';

import '../../../../Utils/Extention/double_parse.dart';

class UserFormScreen extends StatefulWidget {
  final data;
  UserFormScreen({this.data});
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final formKey = GlobalKey<FormState>();

  var customerData;
  var codesList;
  String orderId = '';

  var customerId = '';
  var customerCode = '';
  String id = '';
  String uniqueId = '';
  String receiveNo = '';
  bool isLoading = false;

  var dateController = TextEditingController();
  var customerController = TextEditingController();
  var refController = TextEditingController();
  var descriptionController = TextEditingController();
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
  DateTime initialDate = DateTime.now();

  @override
  void dispose() {
    dateController.dispose();
    customerController.dispose();
    refController.dispose();
    descriptionController.dispose();
    codeController.dispose();
    itemController.dispose();
    cartonController.dispose();
    quantityController.dispose();
    totalQController.dispose();
    heightController.dispose();
    widthController.dispose();
    totalCbmController.dispose();
    lengthController.dispose();
    weightController.dispose();
    totalWController.dispose();
    super.dispose();
  }

  void initState() {
    final data = Provider.of<ReceiveServices>(context, listen: false);
    final userForm = Provider.of<UserFormService>(context, listen: false);
    userForm.items = [];
    descriptionController.clear();
    refController.clear();
    customerData = null;
    userForm.markValue = '';
    userForm.warehouseValue = '';
    if (widget.data != null) {
      setState(() {
        isLoading = true;
      });

      data.getReceiveOrderWithId(context: context, id: widget.data).then((value) {
        setState(() {
          print(data.receiveDataModule!.customerCodeId);
          userForm.items = data.updateReceiveData['details'];
          userForm.warehouseValue = data.updateReceiveData['warehouseId'].toString();
          userForm.markValue = data.receiveDataModule!.customerCodeId.toString() ?? "";
          refController.text = data.updateReceiveData['refNo'] ?? "";
          descriptionController.text = data.updateReceiveData['description'] ?? "";
          customerController.text = data.updateReceiveData['customer']["name"] ?? "";
          customerId = data.updateReceiveData["customerId"].toString() ?? "";

          id = data.updateReceiveData["id"].toString();
          receiveNo = data.updateReceiveData["receiveNo"].toString();
          uniqueId = data.updateReceiveData["uniqueId"].toString();
          dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(data.updateReceiveData['receiveDate']));
          codesList = data.receiveDataModule!.customer!.customerCodes;
          customerData = data.receiveDataModule!.customer;
          isLoading = false;
        });
      });

      print("response for order is: ");
    } else {
      dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }

    super.initState();
  }

  Widget build(BuildContext context) {
    final warehouse = Provider.of<WarehouseService>(context, listen: false);
    final userForm = Provider.of<UserFormService>(context, listen: false);

    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppTheme.grey_thick,
          bottomNavigationBar: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: EdgeInsets.only(bottom: 30, top: 25),
              color: AppTheme.white,
              child: Row(children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      navigator_route(context: context, page: ItemFormScreen());
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppTheme.white,
                            border: Border.all(width: 0, color: AppTheme.primary),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Add Items",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppTheme.primary),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      print("________________________________");
                      print("${{
                        'receiveDate': dateController.text,
                        'refNo': refController.text,
                        'refDate': dateController.text,
                        'customerId': customerId ?? "",
                        'description': descriptionController.text,
                        'customerCodeId': customerData == null
                            ? ""
                            : customerData!.customerCodes!.length == 1
                            ? customerData!.customerCodes![0].id.toString()
                            : userForm.markValue.toString(),
                        'warehouseId': userForm.warehouseValue.toString(),
                        "details": userForm.items,
                        "orderId": userForm.orderId.isEmpty ? "" : userForm.orderId.toString(),
                      }}");
                      print("________________________________");
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      formKey.currentState!.save();
                      double totalCBM = 0;
                      double totalWeight = 0;
                      double totalQuantity = 0;
                      double totalPacking = 0;
                      for (var item in userForm.items) {
                        totalCBM += parseDouble(item["totalCBM"]);
                        totalWeight += parseDouble(item["totalWeight"]);
                        totalQuantity += parseDouble(item["quantity"]);
                        totalPacking += parseDouble(item["packing"]);
                      }
                      var data = {
                        'totalCBM': totalCBM,
                        'totalWeight': totalWeight,
                        'totalQty': totalQuantity,
                        'totalPacking': totalPacking,
                        'receiveDate': dateController.text,
                        'refNo': refController.text,
                        'refDate': dateController.text,
                        'customerId': customerId,
                        'description': descriptionController.text,
                        'customerCodeId': customerData == null
                            ? ""
                            : customerData!.customerCodes!.length == 1
                            ? customerData!.customerCodes![0].id.toString()
                            : userForm.markValue.toString(),
                        'warehouseId': userForm.warehouseValue.toString(),
                        "details": userForm.items,
                        "orderId": userForm.orderId.isEmpty ? "" : userForm.orderId.toString(),
                      };
                      if (widget.data != null) {
                        data.addAll({
                          "id": id.toString(),
                          "uniqueId": uniqueId,
                          "receiveNo": receiveNo.toString(),
                        });
                        userForm.updateOrderReceive(context: context, data: data);
                      } else {
                        print("data is: $data");
                        userForm.postOrderReceive(context: context, data: data);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: GlobalText(text:"Submit", color: Colors.white,textAlign: TextAlign.center),
                    ),
                  ),
                )
              ]),
            ),
          ),
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: AppTheme.white,
            title: Text(
              widget.data != null ? "Edit Receive" : "New Receive",
              style: TextStyle(fontSize: 16, color: AppTheme.black),
            ),
          ),
          body: isLoading
              ? Center(
            child: CircularProgressIndicator(color: AppTheme.primary),
          )
              : SafeArea(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UserFormCard(children: [
                      GestureDetector(
                        onTap: () async {
                          SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
                          initialDate = (await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: AppTheme.primary,
                                    onPrimary: Colors.white,
                                  ),
                                ),
                                child: DatePickerDialog(
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                  initialDate: initialDate,
                                ),
                              );
                            },
                          ));

                          setState(() {
                            if (initialDate.toString() != 'null') {
                              dateController.text = DateFormat('yyyy-MM-dd').format(initialDate);
                              initialDate = initialDate;
                            }
                          });
                        },
                        child: CustomTextFormField(
                            title: "Date",
                            hintText: "Date",
                            enabled: false,
                            controller: dateController,
                            borderType: true,
                            verticalPadding: 8),
                      ),
                      Consumer<UserFormService>(builder: (ctx, ref, _) {
                        refController.text = ref.orderNo.isNotEmpty ? ref.orderNo.toString() : refController.text;
                        return CustomTextFormField(
                          textInputType: TextInputType.text,
                          controller: refController,
                          title: "Ref No",
                          hintText: "Reference Number",
                          borderType: true,
                          verticalPadding: 8,
                        );
                      }),
                      Consumer<CustomersService>(
                        builder: (ctx, customer, _) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              isRequired: true,
                              validator: FormValidator.isEmpty,
                              title: "Customer",
                              hintText: "Customer",
                              controller: customerController,
                              borderType: true,
                              suffix: IconButton(
                                onPressed: () {
                                  if (customerController.text.isEmpty) return;
                                  ButtonSheetWidget(
                                      context: context,
                                      child: Scaffold(
                                        appBar: AppBar(
                                          leading: SizedBox.shrink(),
                                          actions: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: Icon(Icons.close))
                                          ],
                                        ),
                                        body: FutureBuilder(
                                            future: customer.getCustomers(customer: customerController.text),
                                            builder: (ctx, snap) => snap.connectionState ==
                                                ConnectionState.waiting
                                                ? Center(
                                              child: CircularProgressIndicator(
                                                color: AppTheme.primary,
                                              ),
                                            )
                                                : Consumer<OpenOrderServices>(
                                                builder: (ctx, loading, _) => customer.customersList.isEmpty
                                                    ? EmptyScreen()
                                                    : ListView.separated(
                                                    padding: EdgeInsets.all(18),
                                                    itemBuilder: (ctx, i) => SizedBox(
                                                      width: double.infinity,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          WidgetsBinding.instance
                                                              .addPostFrameCallback((_) {
                                                            setState(() {
                                                              customerData =
                                                              customer.customersList[i];
                                                              customerId = customer
                                                                  .customersList[i].id
                                                                  .toString();

                                                              customerController.text = customer
                                                                  .customersList[i].name
                                                                  .toString();
                                                            });
                                                            print(
                                                                "customer id: $customerId && customer name is: ${customerController.text}");
                                                          });

                                                          navigator_route_pop(context: context);
                                                          ButtonSheetWidget(
                                                              context: context,
                                                              heightFactor: 0.7,
                                                              child:
                                                              OpenOrder(customerId: customerId));
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.person,
                                                                    color: AppTheme.grey_thin,
                                                                  ),
                                                                  SizedBox(width: 8),
                                                                  Expanded(
                                                                    child: RichText(
                                                                      text: TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                              text:
                                                                              "${customer.customersList[i].name} ",
                                                                              style: TextStyle(
                                                                                  color:
                                                                                  AppTheme.black,
                                                                                  fontFamily:
                                                                                  "sf_med",
                                                                                  fontSize: 18)),
                                                                          TextSpan(
                                                                              text: "-",
                                                                              style: TextStyle(
                                                                                  color: AppTheme
                                                                                      .black)),
                                                                          TextSpan(
                                                                              text:
                                                                              "${customer.customersList[i].code}",
                                                                              style: TextStyle(
                                                                                  color:
                                                                                  AppTheme.black,
                                                                                  fontFamily:
                                                                                  "sf_med",
                                                                                  fontSize: 16)),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 8),
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(
                                                                    horizontal: 33.0),
                                                                child: Wrap(
                                                                    children: customer
                                                                        .customersList[i]
                                                                        .customerCodes!
                                                                        .map<Widget>((e) => Padding(
                                                                      padding:
                                                                      const EdgeInsets
                                                                          .all(3.0),
                                                                      child: RawChip(
                                                                        padding: EdgeInsets
                                                                            .symmetric(
                                                                            vertical: 0),
                                                                        label: Text(
                                                                          e.name.toString(),
                                                                          style: TextStyle(
                                                                            color: AppTheme
                                                                                .black,
                                                                            fontSize: 11,
                                                                            fontFamily:
                                                                            'sf_med',
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ))
                                                                        .toList()),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    separatorBuilder: (ctx, div) => Divider(),
                                                    itemCount: customer.customersList.length))),
                                      ),
                                      heightFactor: 0.7);
                                },
                                icon: Icon(Icons.search, color: AppTheme.primary),
                              ),
                              verticalPadding: 8,
                            ),
                            SizedBox(height: 8),
                            RawChipWidget(
                              title: "Shipping Mark",
                              list: customerData == null ? [] : customerData.customerCodes,
                              type: "mark",
                            )
                          ],
                        ),
                      ),
                    ]),
                    UserFormCard(children: [
                      FutureBuilder(
                          future: warehouse.getWarehouse(),
                          builder: (ctx, snap) => warehouse.isLoading
                              ? ShimmerEffect(width: double.infinity, height: 30)
                              : RawChipWidget(
                            title: "Warehouse",
                            warehouseList: warehouse.warehouseList.isEmpty ? [] : warehouse.warehouseList,
                            type: "shipment",
                          ))
                    ]),
                    Consumer<UserFormService>(builder: (ctx, items, _) {
                      print(items.orderId.toString());
                      return items.items.isEmpty
                          ? SizedBox.shrink()
                          : UserFormCard(
                          children: items.items.map((e) {
                            final index = items.items.indexOf(e);
                            return ItemCardOrderReceive(
                              item: e,
                              index: index,
                            );
                          }).toList());
                    }),
                    UserFormCard(
                      children: [
                        CustomTextFormField(
                          textInputType: TextInputType.text,
                          controller: descriptionController,
                          title: "Description",
                          hintText: "Description",
                          borderType: true,
                          verticalPadding: 8,
                        ),
                      ],
                    ),
                    SizedBox(height: 100)
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class RawChipWidget extends StatelessWidget {
  final title;
  final list;
  final List<WarehouseModule>? warehouseList;
  final type;

  const RawChipWidget({
    Key? key,
    this.type,
    this.warehouseList,
    this.title,
    this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (type == "mark" && list!.isEmpty) || (type == "warehouse" && warehouseList!.isEmpty)
        ? SizedBox.shrink()
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 13, fontFamily: 'sf_med', fontWeight: FontWeight.w500, color: AppTheme.black),
              ),
              SizedBox(width: 6),
              Icon(Icons.star, color: AppTheme.red, size: 10)
            ],
          ),
        ),
        Consumer<UserFormService>(builder: (ctx, userForm, _) {
          print("warehouse user form${userForm.warehouseValue}");
          print("markvalue is: ${userForm.markValue}");
          return type == "mark"
              ? Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            children: List.generate(
              list!.length,
                  (index) {
                print(list![index].id.toString() == userForm.markValue.toString());
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: RawChip(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    selectedColor: AppTheme.grey_thin.withOpacity(0.1),
                    onPressed: () {
                      userForm.setMarkValue(list![index].id.toString());
                    },
                    label: Text(
                      list![index].name,
                      style: TextStyle(
                        color: AppTheme.black,
                        fontSize: 13,
                        fontFamily: 'sf_med',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    selected: list!.length == 1
                        ? true
                        : list![index].id.toString() == userForm.markValue.toString()
                        ? true
                        : false,
                  ),
                );
              },
            ),
          )
              : Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            children: List.generate(
              warehouseList!.length,
                  (index) {
                print(warehouseList![index].id.toString() == userForm.warehouseValue);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: RawChip(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    selectedColor: AppTheme.grey_thin.withOpacity(0.1),
                    onPressed: () {
                      userForm.setWarehouseValue(warehouseList![index].id.toString());
                    },
                    label: Text(
                      warehouseList![index].name!,
                      style: TextStyle(
                        color: AppTheme.black,
                        fontSize: 13,
                        fontFamily: 'sf_med',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    selected: warehouseList![index].id.toString() == userForm.warehouseValue ? true : false,
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}

class UserFormCard extends StatelessWidget {
  final children;
  const UserFormCard({Key? key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.white,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class ItemCardOrderReceive extends StatelessWidget {
  final item;
  final index;
  ItemCardOrderReceive({this.item, this.index});
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return GestureDetector(
      onTap: () {
        ButtonSheetWidget(context: context, heightFactor: 0.8, child: ItemFormScreen(index: index));
      },
      child: Container(
        decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        // margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (item['itemCode'] == null || item['itemCode'].isEmpty)
                          ? SizedBox.shrink()
                          : item['itemCode'] == null
                          ? SizedBox.shrink()
                          : Text(
                        item['itemCode'] ?? "",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),
                      SizedBox(height: 3),
                      IntrinsicHeight(
                        child: Text(
                          item['itemName'] ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.85),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<UserFormService>(
                    builder: (ctx, action, _) => Container(
                      child: PopupMenuButton<String>(
                        child: Icon(
                          Icons.more_vert,
                          size: 16,
                          color: AppTheme.grey_thin,
                        ),
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ];
                        },
                        onSelected: (String value) {
                          if (value == "edit") {
                            ButtonSheetWidget(
                                context: context, heightFactor: 0.8, child: ItemFormScreen(index: index));
                          } else {
                            action.removeItems(item['itemCode']);
                          }
                        },
                      ),
                    )),
              ],
            ),
            //

            SizedBox(height: 20),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatisticCard(
                    title: language["carton"].toString(),
                    type: "number",
                    value: item['packing'].toString(),
                  ),
                  VerticalDivider(
                    thickness: 1.1,
                    color: Colors.grey.shade300,
                  ),
                  _StatisticCard(
                    title: language["quantity"].toString(),
                    type: "number",
                    value: item['quantity'].toString(),
                  ),
                  VerticalDivider(
                    thickness: 1.1,
                    color: Colors.grey.shade300,
                  ),
                  _StatisticCard(
                    title: "Total Weight",
                    type: "number",
                    value: item['totalWeight'].toString(),
                  ),
                  VerticalDivider(
                    thickness: 1.1,
                    color: Colors.grey.shade300,
                  ),
                  _StatisticCard(
                    title: "Total CBM",
                    value: "${item['totalCBM'].toString()}",
                  ),
                ],
              ),
            ),
            item['description'] == null
                ? SizedBox.shrink()
                : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ).copyWith(top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Description",
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'sf_med',
                      fontWeight: FontWeight.w500,
                      color: AppTheme.grey_thin,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    item['description'] ?? "",
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'nrt-bold',
                      fontWeight: FontWeight.bold,
                      color: AppTheme.grey_thin,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.1,
              color: Colors.grey.shade300,
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatisticCard extends StatelessWidget {
  const _StatisticCard({
    required this.title,
    this.value,
    this.type = '',
  });

  final String title;
  final String? value;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        Text(
          title ?? "",
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'sf_med',
            fontWeight: FontWeight.w500,
            color: AppTheme.grey_thin,
          ),
        ),
        SizedBox(height: 5),
        Text(
          (value == null || value == "null" || value.toString().isEmpty)
              ? ""
              : type == "number"
              ? NumberFormat.currency(symbol: "").format(double.parse(value.toString()))
              : value ?? "",
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'nrt-bold',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

