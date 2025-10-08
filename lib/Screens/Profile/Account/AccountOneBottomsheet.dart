import 'package:x_express/Utils/exports.dart';


class AccountBottomsheet extends StatelessWidget {
  const AccountBottomsheet({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 13,
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6,
            width: 47,
            decoration: BoxDecoration(
              color: AppTheme.black,
              borderRadius: BorderRadius.circular(
                3,
              ),
            ),
          ),
          SizedBox(height: 13),
          Container(
            margin: EdgeInsets.only(left: 2),
            padding: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 5,
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: "assets/images/activity.png",
                  height: 40,
                  width: 40,
                  radius: BorderRadius.circular(
                    20,
                  ),
                  margin: EdgeInsets.only(
                    left: 3,
                    top: 13,
                    bottom: 14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 9,
                    top: 11,
                  ),
                  child: _buildFive(
                    context,
                    userName: "Delbert Stracke",
                    widgetText: "2593 5693 522",
                  ),
                ),
                Spacer(),
                CustomImageView(
                  imagePath: "assets/images/activity.png",
                  height: 24,
                  width: 24,
                  margin: EdgeInsets.only(
                    top: 21,
                    bottom: 22,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 13),
          Padding(
            padding: EdgeInsets.only(left: 2),
            child: _buildUserProfile(
              context,
              userName: "Delbert Stracke",
              widgetText: "2593 5693 522",
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.only(left: 2),
            child: _buildUserProfile(
              context,
              userName: "Delbert Stracke",
              widgetText: "2593 5693 522",
            ),
          ),
          SizedBox(height: 29),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildFive(
    BuildContext context, {
    required String userName,
    required String widgetText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName,
          style: TextStyle(fontSize: 12, fontFamily: 'sf_med',fontWeight: FontWeight.w500, color: AppTheme.grey_between),
        ),
        SizedBox(height: 2),
        SizedBox(
          width: 75,
          child: Text(
            widgetText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontFamily: 'sf_med',fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildUserProfile(
    BuildContext context, {
    required String userName,
    required String widgetText,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          CustomImageView(
            imagePath: "assets/images/activity.png",
            height: 40,
            width: 40,
            radius: BorderRadius.circular(
              20,
            ),
            margin: EdgeInsets.only(
              top: 13,
              bottom: 14,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 9,
              top: 11,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(fontFamily: 'sf_med',fontWeight: FontWeight.w500, fontSize: 13, color: AppTheme.grey_between),
                ),
                SizedBox(height: 2),
                SizedBox(
                  width: 75,
                  child: Text(
                    widgetText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontFamily: 'sf_med',fontWeight: FontWeight.w500, color: AppTheme.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
