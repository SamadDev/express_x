import 'package:x_express/Screens/UserForm/OrderUser/Filter/ordere_user_filter_result.dart';
import 'package:x_express/Utils/exports.dart';

class OrderUserFilterScreen extends StatefulWidget {
  const OrderUserFilterScreen({Key? key}) : super(key: key);

  @override
  State<OrderUserFilterScreen> createState() => _OrderUserFilterScreenState();
}

class _OrderUserFilterScreenState extends State<OrderUserFilterScreen> {
  final refNoController = TextEditingController();
  final orderNoController = TextEditingController();
  final customerController = TextEditingController();

  String state = '';
  var startDate = "";
  var endDate = "";
  DateTime initialStart = DateTime.now();
  DateTime initialEnd = DateTime.now();
  String customerId = "0";

  @override
  void initState() {
    final provider = Provider.of<OrderStatusService>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.removeAll();
    });

    super.initState();
  }

  void dispose() {
    state = '';
    startDate = '';
    endDate = '';
    customerController.clear();
    orderNoController.clear();
    refNoController.clear();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    // final status = Provider.of<OrderStatusService>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Order Filter"),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(right: 18, left: 18.0),
                child: AnimationLimiter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: Duration(milliseconds: 200),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 60,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        SizedBox(
                          height: 30,
                        ),

                        Text(
                          "Order No",
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'sf_med', fontWeight: FontWeight.w500, color: AppTheme.black),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          color: AppTheme.card,
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: SizedBox(
                            child: CustomTextFormField(
                              fillColor: AppTheme.grey_thin.withOpacity(0.3),
                              autofocus: false,
                              onFieldSubmit: (value) {
                                SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
                              },
                              textInputType: TextInputType.name,
                              textInputAction: TextInputAction.done,
                              suffix: IconButton(
                                icon: Icon(Icons.search, size: 25, color: AppTheme.grey_thin),
                                onPressed: () async {
                                  String s_date = startDate.isEmpty
                                      ? ""
                                      : DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate));
                                  String e_date =
                                      endDate.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(DateTime.parse(endDate));
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => OrderUserFilterResultScreen(
                                            e_date: e_date,
                                            s_date: s_date,
                                            customer: customerId,
                                            orderNo: orderNoController.text,
                                            refNo: refNoController.text,
                                          )));
                                },
                              ),
                              hintText: "Please Enter Order No",
                              controller: orderNoController,
                            ),
                          ),
                        ),

                        Divider(
                          height: 50,
                          thickness: 1.2,
                          color: Colors.grey.shade300,
                        ),

                        Text(
                          "Ref No",
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'sf_med', fontWeight: FontWeight.w500, color: AppTheme.black),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          color: AppTheme.card,
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: SizedBox(
                            child: CustomTextFormField(
                              fillColor: AppTheme.grey_thin.withOpacity(0.3),
                              autofocus: false,
                              onFieldSubmit: (value) {
                                SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
                              },
                              textInputType: TextInputType.name,
                              textInputAction: TextInputAction.done,
                              suffix: IconButton(
                                icon: Icon(Icons.search, size: 25, color: AppTheme.grey_thin),
                                onPressed: () async {
                                  String s_date = startDate.isEmpty
                                      ? ""
                                      : DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate));
                                  String e_date =
                                      endDate.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(DateTime.parse(endDate));
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => OrderUserFilterResultScreen(
                                            e_date: e_date,
                                            s_date: s_date,
                                            customer: customerId,
                                            orderNo: orderNoController.text,
                                            refNo: refNoController.text,
                                          )));
                                },
                              ),
                              hintText: "Please Enter Ref No",
                              controller: refNoController,
                            ),
                          ),
                        ),

                        Divider(
                          height: 50,
                          thickness: 1.2,
                          color: Colors.grey.shade300,
                        ),
                        Text(
                          "Customer",
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'sf_med', fontWeight: FontWeight.w500, color: AppTheme.black),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Consumer<CustomersService>(
                          builder: (ctx, customer, _) => Container(
                            color: AppTheme.card,
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: SizedBox(
                              child: CustomTextFormField(
                                fillColor: AppTheme.grey_thin.withOpacity(0.3),
                                autofocus: false,
                                onFieldSubmit: (value) {
                                  SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
                                },
                                textInputType: TextInputType.name,
                                textInputAction: TextInputAction.done,
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
                                              builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
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
                                                                        setState(() {
                                                                          customerController.text =
                                                                              customer.customersList[i].name.toString();
                                                                          customerId =
                                                                              customer.customersList[i].id.toString();
                                                                        });
                                                                        navigator_route_pop(context: context);
                                                                      },
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.person,
                                                                                  color: AppTheme.grey_thin,
                                                                                ),
                                                                                SizedBox(width: 8),
                                                                                RichText(
                                                                                  text: TextSpan(
                                                                                    children: [
                                                                                      TextSpan(
                                                                                          text:
                                                                                              "${customer.customersList[i].name} ",
                                                                                          style: TextStyle(
                                                                                              color: AppTheme.black,
                                                                                              fontFamily: "sf_med",
                                                                                              fontSize: 18)),
                                                                                      TextSpan(
                                                                                          text: "-",
                                                                                          style: TextStyle(
                                                                                              color: AppTheme.black)),
                                                                                      TextSpan(
                                                                                          text:
                                                                                              "${customer.customersList[i].code}",
                                                                                          style: TextStyle(
                                                                                              color: AppTheme.black,
                                                                                              fontFamily: "sf_med",
                                                                                              fontSize: 16)),
                                                                                    ],
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
                                                                                      .customersList[i].customerCodes!
                                                                                      .map<Widget>((e) => Text(
                                                                                            e.name.toString(),
                                                                                            style: TextStyle(
                                                                                                color: AppTheme.black,
                                                                                                fontFamily: "sf_med",
                                                                                                fontSize: 14),
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
                                hintText: "Please Enter Receive No",
                                controller: customerController,
                              ),
                            ),
                          ),
                        ),

                        Divider(
                          height: 50,
                          thickness: 1.2,
                          color: Colors.grey.shade300,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              language["dateRange"],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'sf_med',
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () async {
                            SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
                            startDate = "${(await showDialog(
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
                                      firstDate: DateTime(2000), lastDate: DateTime(2100), initialDate: initialStart),
                                );
                              },
                            ))}";
                            setState(() {
                              if (startDate.toString() != 'null') {
                                startDate = startDate;
                                initialStart = DateTime.parse(startDate);
                              }
                            });
                          },
                          child: Container(
                            color: AppTheme.card,
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: SizedBox(
                              child: CustomTextFormField(
                                hintText: startDate.toString().isNotEmpty && startDate.toString() != "null"
                                    ? DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate))
                                    : language['from'],
                                enabled: false,
                                fillColor: AppTheme.grey_thin.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () async {
                            SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
                            endDate = (await showDialog(
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
                                    // Add your DatePickerDialog properties here
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                    initialDate: initialEnd,
                                  ),
                                );
                              },
                            ))
                                .toString();
                            setState(() {
                              if (endDate.toString() != 'null') {
                                endDate = endDate;
                                initialEnd = DateTime.parse(endDate);
                              }
                            });
                          },
                          child: Container(
                            color: AppTheme.card,
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: SizedBox(
                              child: CustomTextFormField(
                                hintText: endDate.toString().isNotEmpty && endDate.toString() != "null"
                                    ? DateFormat('yyyy-MM-dd').format(DateTime.parse(endDate))
                                    : language['to'],
                                enabled: false,
                                fillColor: AppTheme.grey_thin.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                        // Divider(
                        //   height: 50,
                        //   thickness: 1.2,
                        //   color: Colors.grey.shade300,
                        // ),
                        // Text(
                        //   language['status'],
                        //   style: TextStyle(fontSize: 16, fontFamily: 'sf_med',fontWeight: FontWeight.w500, color: AppTheme.black),
                        // ),
                        // FilterArrivedSheet(),
                        Divider(
                          height: 60,
                          thickness: 1.2,
                          color: Colors.grey.shade300,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          width: Responsive.sH(context),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: AppTheme.primary),
                              onPressed: () async {
                                SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
                                String s_date =
                                    startDate.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate));
                                String e_date =
                                    endDate.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(DateTime.parse(endDate));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => OrderUserFilterResultScreen(
                                          e_date: e_date,
                                          s_date: s_date,
                                          customer: customerId,
                                          orderNo: orderNoController.text,
                                          refNo: refNoController.text,
                                        )));
                              },
                              child: Text(
                                language['search'],
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'sf_med',
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.white),
                              )),
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

class ButtonAction extends StatelessWidget {
  final height;
  final width;
  final text;
  final title;
  final onTap;
  ButtonAction({this.text, this.width, this.height, this.onTap, this.title});
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GlobalText(
            text: title,
            color: AppTheme.black.withOpacity(0.8),
            fontSize: 15,
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3, left: 3.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                  elevation: 0,
                  minimumSize: Size(width, height),
                ),
                onPressed: onTap,
                child: GlobalText(
                  text: text,
                  color: AppTheme.secondary,
                  fontSize: 15,
                )),
          ),
        ],
      ),
    );
  }
}

class FilterArrivedSheet extends StatefulWidget {
  @override
  State<FilterArrivedSheet> createState() => _FilterArrivedSheetState();
}

class _FilterArrivedSheetState extends State<FilterArrivedSheet> {
  Widget build(BuildContext context) {
    final fetchStates = Provider.of<OrderStatusService>(context);
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 12.0, left: 12),
      child: FutureBuilder(
        future: fetchStates.getStatusOrder(),
        builder: (ctx, snap) => Consumer<OrderStatusService>(
          builder: (ctx, state, _) => Wrap(
            children: state.orderStatus.map((e) {
              bool existItem = state.existStateFilterList.any((element) => element.id == e.id);
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: ChoiceChip(
                  selectedColor: AppTheme.primary.withOpacity(0.2),
                  padding: EdgeInsets.all(3),
                  label: Text(
                    e.title!,
                    style: TextStyle(fontFamily: 'nrt-reg', fontSize: 12, color: AppTheme.black),
                  ),
                  selected: existItem,
                  onSelected: (bool? value) {
                    if (value == true && e.title != "All") {
                      state.addItem(e);
                    } else {
                      print('remove one');
                      state.removeItem(e.title);
                    }
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
