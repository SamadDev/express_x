import 'package:x_express/Screens/Shipment/ShipmentFilter/shipment_filter_result.dart';
import 'package:x_express/Utils/exports.dart';

class ShipmentFilterScreen extends StatefulWidget {
  const ShipmentFilterScreen({Key? key}) : super(key: key);

  @override
  State<ShipmentFilterScreen> createState() => _ShipmentFilterScreenState();
}

class _ShipmentFilterScreenState extends State<ShipmentFilterScreen> {
  final shipmentNmberController = TextEditingController();
  String state = '';
  var startDate = "";
  var endDate = "";
  DateTime initialStart = DateTime.now();
  DateTime initialEnd = DateTime.now();

  @override
  void initState() {
    final provider = Provider.of<ShipmentStatusService>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.removeAll();
    });
    super.initState();
  }

  void dispose() {
    state = '';
    startDate = '';
    endDate = '';
    shipmentNmberController.clear();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final status = Provider.of<ShipmentStatusService>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
        appBar: AppBar(
          title: Text(language["filter"]),
        ),
        body: SingleChildScrollView(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlobalText(
                          text: language["shipmentNumber"],
                          fontSize: 16,
                          fontFamily: 'nrt-reg',
                          fontWeight: FontWeight.w500,
                          color: AppTheme.black,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      color: AppTheme.card,
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: SizedBox(
                        child: CustomTextFormField(
                          onFieldSubmit: (value) {
                            SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
                          },
                          textInputAction: TextInputAction.done,
                          suffix: IconButton(
                            icon: Icon(Icons.search, size: 25, color: AppTheme.grey_thin),
                            onPressed: () async {
                              SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
                              String s_date =
                                  startDate.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate));
                              String e_date =
                                  endDate.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(DateTime.parse(endDate));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => ShipmentFilterResultScreen(
                                        e_date: e_date,
                                        s_date: s_date,
                                        shipmentNmber: shipmentNmberController.text,
                                        status: status.existStateFilterList.map((e) => e.id).toList(),
                                      )));
                            },
                          ),
                          hintText: "",
                          controller: shipmentNmberController,
                          fillColor: AppTheme.grey_thin.withOpacity(0.3),
                        ),
                      ),
                    ),
                    Divider(
                      height: 50,
                      thickness: 1.2,
                      color: Colors.grey.shade300,
                    ),
                    GlobalText(
                      text: language["dateRange"],
                      fontSize: 16,
                      fontFamily: 'nrt-reg',
                      fontWeight: FontWeight.w500,
                      color: AppTheme.black,
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
                    Divider(
                      height: 50,
                      thickness: 1.2,
                      color: Colors.grey.shade300,
                    ),
                    GlobalText(
                      text: language['status'],
                      fontSize: 16,
                      fontFamily: 'nrt-reg',
                      fontWeight: FontWeight.w500,
                      color: AppTheme.black,
                    ),
                    FilterArrivedSheet(),
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
                                builder: (ctx) => ShipmentFilterResultScreen(
                                      e_date: e_date,
                                      s_date: s_date,
                                      shipmentNmber: shipmentNmberController.text,
                                      status: status.existStateFilterList.map((e) => e.id).toList(),
                                    )));
                          },
                          child: GlobalText(
                            text: language['search'],
                            fontSize: 16,
                            fontFamily: 'nrt-reg',
                            fontWeight: FontWeight.w500,
                            color: AppTheme.white,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
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
    final fetchStates = Provider.of<ShipmentStatusService>(context);
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 12.0, left: 12),
      child: FutureBuilder(
        future: fetchStates.getStatusShipment(),
        builder: (ctx, snap) => Consumer<ShipmentStatusService>(
          builder: (ctx, state, _) => Wrap(
            children: state.shipmentStatus.map((e) {
              bool existItem = state.existStateFilterList.any((element) => element.id == e.id);
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: ChoiceChip(
                  selectedColor: AppTheme.primary.withOpacity(0.2),
                  padding: EdgeInsets.all(3),
                  label: TextLanguage(
                    titleAr: e.titleAr,
                    titleEn: e.title,
                    titleKr: e.titleKr,
                    style: TextStyle(fontFamily: 'nrt-reg', fontSize: 12, color: AppTheme.black),
                  ),
                  selected: existItem,
                  onSelected: (bool? value) {
                    if (value == true && e.title != "All") {
                      state.addItem(e);
                    } else if (value == false && state.existStateFilterList.length == state.shipmentStatus.length) {
                      state.removeItem(e.title);
                      state.removeItem("All");
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
