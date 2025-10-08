import 'package:x_express/Screens/Profile/Agreement/agreement.dart';
import 'package:x_express/Utils/exports.dart';

class AccountScreen extends StatefulWidget {
  final type;
  const AccountScreen({Key? key, this.type}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final picker = ImagePicker();
  var fileImage;

  Future getImage(ImageSource source, context) async {
    if (source == ImageSource.camera) {
      final pickedFile = await ImagePickerService.scan(context);
      if (pickedFile != null) {
        setState(() {
          fileImage = pickedFile;
        });
      }
    } else {
      final pickedFile = await ImagePickerService.singleGalleryImage(context);
      setState(() {
        fileImage = pickedFile;
      });
    }
  }

  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false);
    final profile = Provider.of<ProfileService>(context, listen: false);
    return Scaffold(
      backgroundColor: AppTheme.scaffold,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 65),
        child: AppBar(
          title: FutureBuilder(
              future: profile.getProfile(),
              builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
                  ? Center(child: ShimmerEffect(width: double.infinity, height: 60))
                  : Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: GestureDetector(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                title: GlobalText(text: "Upload image"),
                                content: Wrap(
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: const GlobalText(text: 'Photo Library'),
                                      onTap: () async {
                                        await getImage(ImageSource.gallery, context);
                                        await profile.uploadImage(context: context, imageFile: fileImage);
                                        await profile.getProfile(isReload: true);
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.photo_camera),
                                      title: const GlobalText(text: 'Camera'),
                                      onTap: () async {
                                        await getImage(ImageSource.camera, context);
                                        await profile.uploadImage(context: context, imageFile: fileImage);
                                        await profile.getProfile(isReload: true);
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Stack(
                                children: [
                                  fileImage == null
                                      ? Container(
                                          margin: EdgeInsets.only(top: 17, bottom: 18, right: 2, left: 2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(90),
                                          ),
                                          child: (profile.profile!.photo.toString().isEmpty ||
                                                  profile.profile!.photo == null)
                                              ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(90),
                                                  child: Image.asset(
                                                    'assets/images/profile.png',
                                                    height: 40,
                                                    width: 40,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              : ClipRRect(
                                                  borderRadius: BorderRadius.circular(90),
                                                  child: Image.network(
                                                      dotenv.env['UPLOADURL']! + profile.profile!.photo!,
                                                      height: 40,
                                                      width: 40,
                                                      fit: BoxFit.fill),
                                                ),
                                        )
                                      : Container(
                                          margin: EdgeInsets.only(top: 17, bottom: 18, right: 2, left: 2),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(90),
                                            child: Image.file(
                                              fileImage,
                                              fit: BoxFit.fill,
                                              height: 45,
                                              width: 45,
                                            ),
                                          ),
                                        ),
                                  Positioned(
                                    right: language.languageCode == "en" ? 0 : null,
                                    left: language.languageCode != "en" ? 0 : null,
                                    bottom: 15,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: AppTheme.primary.withOpacity(0.7),
                                          borderRadius: BorderRadius.circular(90)),
                                      child: Icon(Icons.camera_alt, size: 18, color: AppTheme.grey),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 9),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    GlobalText(
                                      text: language.languageCode == "en"
                                          ? profile.profile!.name!
                                          : profile.profile!.nameAR ?? profile.profile!.name!,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: AppTheme.black,
                                    ),
                                    SizedBox(height: 6),
                                    GlobalText(
                                      text: profile.profile!.phoneNumber! ?? "",
                                      maxLines: 1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.grey_between,
                                    )
                                  ])),
                              Spacer(),
                              SizedBox()
                              // Icon(Icons.arrow_forward_ios, size: 17)
                            ])),
                      ),
                    )),
        ),
      ),
      body: Consumer<Language>(
          builder: (ctx, language, _) => Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   margin: EdgeInsets.zero,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(12),
                      //       border: Border.all(width: 0.1, color: AppTheme.black)),
                      //   width: double.maxFinite,
                      //   child: _buildThirtyRow(context),
                      // ),

                      SizedBox(height: 10),

                      if (widget.type != "user") ...[
                        _buildPersonalInfRow(context,
                            icon: Icons.inventory_outlined,
                            appearance: language.getWords["activity"],
                            page: ActivityScreen()),
                        SizedBox(height: 32),
                      ],

                      _buildPersonalInfRow(context,
                          icon: Icons.receipt_outlined,
                          appearance: language.getWords["receiptNav"],
                          page: ReceiptListScreen()),
                      SizedBox(height: 32),
                      _buildPersonalInfRow(context,
                          icon: Icons.currency_exchange,
                          appearance: language.getWords["currencyRate"],
                          page: CurrencyListScreen()),

                      SizedBox(height: 32),
                      // _buildPersonalInfRow(context,
                      //     icon: Icons.chat_outlined,
                      //     appearance: language.getWords["chat"] ?? "chat",
                      //     page: ChatScreen()),
                      //
                      // Divider(height: 32, thickness: 1),
                      // (widget.type == "user")
                      //     ? SizedBox()
                      //     : Column(children: [
                      //         _buildPersonalInfRow(context,
                      //             icon: Icons.leaderboard, appearance: "Leads", page: LeadersScreen()),
                      //         SizedBox(height: 32),
                      //         _buildPersonalInfRow(context,
                      //             icon: Icons.maps_home_work, appearance: "Visit", page: LeaderVisitScreen()),
                      //         Divider(height: 32, thickness: 1),
                      //       ]),

                      GlobalText(
                        text: language.getWords['settings'] ?? "",
                        color: AppTheme.grey_thin,
                      ),
                      SizedBox(height: 32),
                      if (widget.type != "user") ...[
                        _buildPersonalInfRow(context,
                            icon: Icons.language,
                            appearance:
                                "${language.getWords['language']} (${language.languageCode == "en" ? "English" : language.languageCode == "kr" ? "کوردی" : "عربی"})",
                            page: LanguageStarterScreen(
                              type: '',
                            )),
                        SizedBox(height: 32),
                      ],

                      _buildPersonalInfRow(context,
                          icon: Icons.notifications_active_outlined,
                          appearance: language.getWords["notification"],
                          page: NotificationScreen()),
                      SizedBox(height: 32),
                      _buildPersonalInfRow(context,
                          icon: Icons.support, appearance: language.getWords["customer_service"], func: () {
                        customerService(context);
                      }, page: ''),
                      SizedBox(height: 32),
                      GlobalText(
                        text: language.getWords['agreement'] ?? '',
                        color: AppTheme.grey_thin,
                      ),
                      SizedBox(height: 32),
                      _buildPersonalInfRow(context,
                          icon: Icons.handshake_outlined,
                          appearance: language.getWords["agreement"],
                          page: AgreementScreen()),

                      Divider(height: 32, thickness: 1),
                      GlobalText(
                        text: language.getWords['about'],
                        color: AppTheme.grey_thin,
                      ),
                      SizedBox(height: 32),
                      _buildPersonalInfRow(context,
                          icon: Icons.info_outline, appearance: language.getWords["about"], page: LegalScreen()),
                      SizedBox(height: 32),



                      _buildPersonalInfRow(context,
                          icon: Icons.delete_outline, appearance: language.getWords["deleteAccount"], func: () {
                        areYouSure(
                            context: context,
                            title: language.getWords["deleteAccount"],
                            content: language.getWords['are_you_sure_you_want_to_delete_your_account'],
                            onPress: () {
                              auth.deleteAccount(context: context, userId: Auth.customer_id);
                            });
                      }, page: ''),
                      SizedBox(height: 32),
                      CustomElevatedButton(
                        buttonStyle: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppTheme.primary)),
                        text: language.getWords["logout"],
                        onPressed: () async {
                          await auth.removeToken();
                          profile.profile = null;
                          navigator_route_remove(context: context, page: LoginPage());
                        },
                      ),
                    ],
                  ),
                ),
              )),
    );
  }

  /// Common widget
  Widget _buildPersonalInfRow(
    BuildContext context, {
    required IconData icon,
    required String appearance,
    final func,
    required page,
  }) {
    return InkWell(
      onTap: func == null
          ? () {
              navigator_route(context: context, page: page);
            }
          : func,
      child: Row(children: [
        Icon(
          icon,
          size: 22,
          color: AppTheme.grey_thin,
        ),
        SizedBox(width: 3),
        Padding(
            padding: EdgeInsets.only(left: 12, right: 12, top: 2),
            child: GlobalText(
              text: appearance,
              fontSize: 16,
              fontFamily: 'nrt-reg',
              fontWeight: FontWeight.w500,
              color: AppTheme.black,
            )),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
          size: 17,
        )
      ]),
    );
  }
}
