import 'package:x_express/Utils/exports.dart';

class ResetPhoneScreen extends StatefulWidget {
  @override
  State<ResetPhoneScreen> createState() => _ResetPhoneScreenState();
}

class _ResetPhoneScreenState extends State<ResetPhoneScreen> {
  final phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    final height = Responsive.sH(context);
    final rest = Provider.of<ReSetPasswordService>(context, listen: false);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            right: 45,
            left: 45,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.09,
                ),
                GlobalText(
                  text: language.getWords['reset_password'],
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'inter-bold',
                  fontSize: 40,
                ),
                SizedBox(
                  height: 10,
                ),
                GlobalText(
                  text: language.getWords['please_provide_your_phone_number_bellow_to_reset_your_password'],
                  color: AppTheme.grey,
                ),
                SizedBox(
                  height: 60,
                ),
                Image.asset(
                  'assets/images/reset_password.png',
                  width: 280,
                  height: height * 0.23,
                ),
                SizedBox(
                  height: 70,
                ),
                Form(
                  key: _formKey,
                  child: TextFormFieldWidget(
                    buttonPrefix: Padding(
                      padding: EdgeInsets.only(right: 8.0, left: 8, top: 5),
                      child: GlobalText(
                        text: '+964',
                        color: AppTheme.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                    formValidator: FormValidator.isPhone,
                    controller: phone,
                    hintText: "750xxxxxxxx",
                    buttonPostfix: SizedBox.shrink(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Customer_Button(
                    text: language.getWords["reset_password"],
                    onPress: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      rest.check_phone_exist(context: context, phone: phone.text);
                    }),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 1, color: AppTheme.primary),
                        fixedSize: Size(336, 55),
                        backgroundColor: AppTheme.secondary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: GlobalText(
                      text: language.getWords["back"],
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
