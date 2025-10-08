import 'package:x_express/Utils/exports.dart';
import 'package:x_express/Widgets/custom_text_form_field.dart';
import 'package:intl/intl.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final orderNumberController = TextEditingController();

  String state = '';
  var startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  void initState() {
    final provider = Provider.of<OrderStatusService>(context, listen: false);
    provider.removeAll();
    super.initState();
  }

  void dispose() {
    state = '';
    startDate = DateTime.now();
    endDate = DateTime.now();

    super.dispose();
  }

  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    final status = Provider.of<OrderStatusService>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
        appBar: AppBar(
          title: GlobalText(text: language['order_filter']),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlobalText(
                          text: language["orderNumber"],
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
                          textInputType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          suffix: IconButton(
                            icon: Icon(
                              Icons.search,
                              size: 25,
                              color: AppTheme.grey_thin,
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              String s_date = DateFormat('yyyy-MM-dd').format(startDate);
                              String e_date = DateFormat('yyyy-MM-dd').format(endDate);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => FilterResultScreen(
                                        e_date: e_date,
                                        s_date: s_date,
                                        orderNo: orderNumberController.text,
                                        status: status.existStateFilterList.map((e) => e.id).toList(),
                                      )));
                            },
                          ),
                          hintText: "",
                          controller: orderNumberController,
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
                      text: language['status'],
                      fontSize: 16,
                      fontFamily: 'nrt-reg',
                      fontWeight: FontWeight.w500,
                      color: AppTheme.black,
                    ),
                    FilterArrivedSheet(),
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
                        FocusScope.of(context).requestFocus(new FocusNode());
                        startDate = (await showDialog(
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
                                initialDate: startDate == DateTime.now() ? DateTime.now() : startDate,
                              ),
                            );
                          },
                        ));
                        setState(() {
                          startDate = startDate;
                        });
                      },
                      child: Container(
                        color: AppTheme.card,
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: SizedBox(
                          child: CustomTextFormField(
                            hintText:
                                startDate.toString().isNotEmpty ? DateFormat('yyyy-MM-dd').format(startDate) : 'From',
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
                        FocusScope.of(context).requestFocus(new FocusNode());
                        endDate = (await showDialog(
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
                                initialDate: endDate == DateTime.now() ? DateTime.now() : endDate,
                              ),
                            );
                          },
                        ))!;
                        setState(() {
                          endDate = endDate;
                        });
                      },
                      child: Container(
                        color: AppTheme.card,
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: SizedBox(
                          child: CustomTextFormField(
                            hintText: endDate.toString().isNotEmpty ? DateFormat('yyyy-MM-dd').format(endDate) : 'To',
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 150, right: 20, left: 20),
                      // padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 200,
                      width: Responsive.sH(context),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: AppTheme.primary),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            String s_date = DateFormat('yyyy-MM-dd').format(startDate);
                            String e_date = DateFormat('yyyy-MM-dd').format(endDate);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => FilterResultScreen(
                                      e_date: e_date,
                                      s_date: s_date,
                                      orderNo: orderNumberController.text,
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
                    Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
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
                  label: GlobalText(
                    text: e.title!,
                    fontFamily: 'nrt-reg',
                    fontSize: 12,
                    color: AppTheme.black,
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
