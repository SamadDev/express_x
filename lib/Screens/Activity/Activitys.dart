import 'package:x_express/Utils/exports.dart';

class ActivityScreen extends StatefulWidget {
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> with SingleTickerProviderStateMixin {
  var startDate = DateTime(DateTime.now().year, DateTime.now().month, 1).toString();
  var endDate = DateTime(DateTime.now().year, DateTime.now().month, 30).toString();
  DateTime initialStart = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime initialEnd = DateTime.now();

  @override
  void initState() {
    Provider.of<CurrencyTypeService>(context, listen: false).existCurrencyList = [];
    super.initState();
  }

  Widget build(BuildContext context) {
    final activityProvider = Provider.of<ActivityService>(context, listen: false);
    final currency = Provider.of<CurrencyTypeService>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: GlobalText(text: (language["statement"])),
        leadingWidth: 40,
        actions: [
          GestureDetector(
            onTap: () {
              final currencyId = currency.existCurrencyList.isEmpty ? 0 : currency.existCurrencyList[0].id;
              Navigator.of(context).push(createRoute(PdfViewerScreen(
                fileExtension: DateTime.now().toString(),
                type: "activity",
                url: "account-statement",
                currencyId: currencyId,
                fromDate: DateFormat("dd/MM/yyyy").format(DateTime.parse(startDate.toString())),
                toDate: DateFormat("dd/MM/yyyy").format(DateTime.parse(endDate.toString())),
              )));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20, left: 20.0, top: 0),
              child: Image.asset('assets/images/print.png', width: 23, height: 23, color: AppTheme.primary),
            ),
          ),
        ],
        backgroundColor: AppTheme.white,
        toolbarHeight: 40.0,
      ),
      body: FutureBuilder(
          future: activityProvider.getActivity(s_date: startDate, e_date: endDate),
          builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
              ? ShimmerListCard()
              : SingleChildScrollView(
                  child: Consumer<ActivityService>(
                    builder: (ctx, activity, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 13, left: 13, top: 8, bottom: 2),
                          child: Row(children: [
                            TabFilterButton(
                              title: startDate.toString().isNotEmpty && startDate.toString() != "null"
                                  ? DateFormat('dd-MM-yyyy').format(DateTime.parse(startDate))
                                  : language['from'],
                              onPress: () async {
                                startDate = "${await showDialog(
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
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                          initialDate: initialStart),
                                    );
                                  },
                                )}";
                                setState(
                                  () {
                                    if (startDate.toString() != 'null') {
                                      startDate = startDate;
                                      initialStart = DateTime.parse(startDate);
                                    }
                                  },
                                );
                                await activity.getActivity(
                                    context: context,
                                    e_date: endDate,
                                    s_date: startDate,
                                    currencyType: currency.existCurrencyList);
                              },
                            ),
                            TabFilterButton(
                              title: endDate.toString().isNotEmpty && endDate.toString() != "null"
                                  ? DateFormat('dd-MM-yyyy').format(DateTime.parse(endDate))
                                  : language['to'],
                              onPress: () async {
                                endDate = "${await showDialog(
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
                                          firstDate: DateTime(1900), lastDate: DateTime(2100), initialDate: initialEnd),
                                    );
                                  },
                                )}";
                                setState(() {
                                  if (endDate.toString() != 'null') {
                                    endDate = endDate;
                                    initialEnd = DateTime.parse(endDate);
                                  }
                                });
                                await activity.getActivity(
                                    context: context,
                                    e_date: endDate,
                                    s_date: startDate,
                                    currencyType: currency.existCurrencyList);
                              },
                            ),
                            Stack(
                              children: [
                                TabFilterButton(
                                  title: language['currency'],
                                  onPress: () {
                                    ButtonSheetWidget(
                                        context: context,
                                        child: Scaffold(
                                          appBar: AppBar(
                                              title: GlobalText(
                                            text: (language['currency']),
                                          )),
                                          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                                          floatingActionButton: InkWell(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppTheme.primary, borderRadius: BorderRadius.circular(12)),
                                                width: double.infinity,
                                                height: 40,
                                                margin: EdgeInsets.symmetric(horizontal: 12),
                                                alignment: Alignment.center,
                                                child: GlobalText(
                                                  text: ("done"),
                                                ),
                                              )),
                                          body: Consumer<CurrencyTypeService>(
                                              builder: (ctx, currencyType, _) => FutureBuilder(
                                                  future: currencyType.getCurrencyType(),
                                                  builder: (ctx, snap) => StatefulBuilder(
                                                        builder: (context, setState) => SingleChildScrollView(
                                                          child: Column(
                                                            children: currencyType.currencyTypeList.map((e) {
                                                              bool existItem = currencyType.existCurrencyList
                                                                  .any((element) => element.id == e.id);

                                                              return CheckboxListTile(
                                                                value: existItem,
                                                                activeColor: AppTheme.primary,
                                                                onChanged: (value) async {
                                                                  print("_____________________");
                                                                  print(value);
                                                                  print(e.id.toString());
                                                                  print("_____________________");

                                                                  print(
                                                                      'if value is false${value == false && e.id.toString() == '0'}');
                                                                  print(
                                                                      'if value is true${value == true && e.id.toString() == '0'}');

                                                                  if (value == true && e.id.toString() == '0') {
                                                                    print("if first is run");
                                                                    currencyType.addAll();
                                                                    await activityProvider.getActivity(
                                                                        context: context,
                                                                        e_date: endDate,
                                                                        s_date: startDate,
                                                                        currencyType: "0".toString());
                                                                  } else if (value == false && e.id.toString() == '0') {
                                                                    currencyType.removeAll();
                                                                    await activityProvider.getActivity(
                                                                        context: context,
                                                                        e_date: endDate,
                                                                        s_date: startDate,
                                                                        currencyType: "0");
                                                                  } else if (value == true ||
                                                                      (value == false && e.id.toString() == '0')) {
                                                                    print("if add is run");
                                                                    currencyType.addItem(e);
                                                                    await activityProvider.getActivity(
                                                                        context: context,
                                                                        e_date: endDate,
                                                                        s_date: startDate,
                                                                        currencyType: currencyType
                                                                            .existCurrencyList[0].id
                                                                            .toString());
                                                                  } else if (value == false &&
                                                                      currencyType.existCurrencyList.length > 1 &&
                                                                      e.id.toString() != "0") {
                                                                    currencyType.addItem(e);
                                                                    await activityProvider.getActivity(
                                                                        context: context,
                                                                        e_date: endDate,
                                                                        s_date: startDate,
                                                                        currencyType: currencyType
                                                                            .existCurrencyList[0].id
                                                                            .toString());
                                                                  } else {
                                                                    print("if else");
                                                                    currencyType.removeItem(e);
                                                                    await activityProvider.getActivity(
                                                                        context: context,
                                                                        e_date: endDate,
                                                                        s_date: startDate,
                                                                        currencyType: currencyType
                                                                            .existCurrencyList[0].id
                                                                            .toString());
                                                                  }
                                                                },
                                                                title: GlobalText(
                                                                  text: e.name,
                                                                  fontFamily: 'nrt-reg',
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 15,
                                                                  color: AppTheme.black,
                                                                ),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ))),
                                        ),
                                        heightFactor: 0.5);
                                  },
                                ),
                                // currencyType.existCurrencyList.isEmpty
                                //     ? SizedBox.shrink()
                                //     :
                                Positioned(
                                    top: 2,
                                    right: 2,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration:
                                          BoxDecoration(color: AppTheme.green, borderRadius: BorderRadius.circular(90)),
                                    ))
                              ],
                            )
                          ]),
                        ),
                        Container(height: 150, child: ActivityTotalCard(balance: activityProvider.activity.balance!)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16, left: 16, top: 4, bottom: 4),
                              child: GlobalText(
                                text: language['transaction'],
                                fontSize: 18,
                                fontFamily: 'nrt-reg',
                                fontWeight: FontWeight.w500,
                                color: AppTheme.black,
                              ),
                            ),
                            Column(
                              children: activityProvider.activity.transactions!
                                  .map((e) => ActivityListCard(
                                        transaction: e,
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
    );
  }
}

class TabFilterButton extends StatelessWidget {
  final title;
  final onPress;
  final startDate;
  final endDate;
  final initialStart;
  final initialEnd;
  const TabFilterButton(
      {Key? key, this.title, this.onPress, this.initialEnd, this.initialStart, this.startDate, this.endDate})
      : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 5),
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          width: 100,
          height: 33,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: AppTheme.grey_between.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 0,
              offset: Offset(0, 0),
            ),
          ], borderRadius: BorderRadius.circular(8), color: AppTheme.white),
          alignment: Alignment.center,
          child: GlobalText(
            text: title,
            fontFamily: "sf_med",
            fontSize: 14,
            color: AppTheme.grey_thin,
          ),
        ),
      ),
    );
  }
}

void showDateTime({initialStart, context}) async {
  (await showDialog(
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
        child: DatePickerDialog(firstDate: DateTime(2000), lastDate: DateTime(2100), initialDate: initialStart),
      );
    },
  ));
}

