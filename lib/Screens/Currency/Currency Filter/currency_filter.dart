import 'package:x_express/Screens/Currency/Currency Filter/currency_filter_result.dart';
import 'package:x_express/Utils/exports.dart';
import 'package:x_express/Widgets/dropdownbuttonWidget.dart';

class CurrencyFilterScreen extends StatefulWidget {
  const CurrencyFilterScreen({Key? key}) : super(key: key);

  @override
  State<CurrencyFilterScreen> createState() => _CurrencyFilterScreenState();
}

class _CurrencyFilterScreenState extends State<CurrencyFilterScreen> {
  final currencyController = TextEditingController();

  var startDate = "";
  var endDate = "";
  DateTime initialStart = DateTime.now();
  DateTime initialEnd = DateTime.now();

  List currencyList = [];
  var currencyValue;
  bool loading = false;
  void fetchCurrencyType() {
    setState(() {
      loading = true;
    });

    final currencyType = Provider.of<CurrencyTypeService>(context, listen: false);
    currencyType.getCurrencyType().then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    fetchCurrencyType();
    super.initState();
  }

  void dispose() {
    startDate = '';
    endDate = '';
    super.dispose();
  }

  Widget build(BuildContext context) {
    final currencyType = Provider.of<CurrencyTypeService>(context, listen: false);

    final language = Provider.of<Language>(context, listen: false).getWords;
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
      },
      child: Scaffold(
          appBar: AppBar(
            title: GlobalText(text: language["filter"]),
          ),
          body: SingleChildScrollView(
            reverse: true,
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
                      GlobalText(
                        text: language["currency"] ?? "",
                        fontSize: 16,
                        fontFamily: 'nrt-reg',
                        fontWeight: FontWeight.w500,
                        color: AppTheme.black,
                      ),
                      SizedBox(height: 15),

                      loading
                          ? ShimmerEffect(width: double.infinity, height: 50)
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppTheme.card,
                              ),
                              child: TextDropDownWidget(
                                value: currencyValue,
                                hintText: language["currencyType"],
                                function: (value) {
                                  setState(() {
                                    currencyValue = value;
                                  });
                                },
                                list: currencyType.currencyTypeList,
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
                          GlobalText(
                            text: language["dateRange"],
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
                        height: 60,
                        thickness: 1.2,
                        color: Colors.grey.shade300,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 47,
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
                                  builder: (ctx) => CurrencyFilterResultScreen(
                                      e_date: e_date, s_date: s_date, currency: currencyType)));
                            },
                            child: GlobalText(
                              text: language['search'],
                              fontSize: 16,
                              fontFamily: 'nrt-reg',
                              fontWeight: FontWeight.w500,
                              color: AppTheme.white,
                            )),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
                      // SizedBox(
                      //   height: 20,
                      // ),
                    ],
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
