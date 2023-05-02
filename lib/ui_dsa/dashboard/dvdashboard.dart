import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/model/postofferdto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/dashboard/postoffer.dart';
import 'package:dhanvarsha/ui/profile/profilescreen.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DVDashboard extends StatefulWidget {
  final BuildContext context;
  const DVDashboard({Key? key, required this.context}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DVDashboardState();
}

class _DVDashboardState extends State<DVDashboard>
    with TickerProviderStateMixin {
  late AnimationController controller;
  int num = 10;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  List<PostOfferDTO> listOfPostOffer = [
    new PostOfferDTO("Agreement Stage", 23, 24),
    new PostOfferDTO("Repayment Setup", 27, 19),
    new PostOfferDTO("Loan Disbursal", 15, 20),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   // SizeConfig().init(context);
    return BaseView(
      context: context,
      body: SingleChildScrollView(
        child: Container(
          height: (SizeConfig.screenHeight * 2) - (68 * 2),
          child: Column(
            children: [
              Expanded(
                flex: 16,
                child: _getBannerImage(),
              ),
              Expanded(
                flex: 5,
                child: _getProductsDropDown(),
              ),
              Expanded(
                flex: 16,
                child: _ProgressOverView(),
              ),
              Expanded(
                flex: 12,
                child: _getApplication(),
              ),
              Expanded(
                flex: 25,
                child: _getPostOffer(),
              ),
              Expanded(
                flex: 25,
                child: _getPostList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBannerImage() {
    return Container(
      color: AppColors.blue,
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Image.asset(
        DhanvarshaImages.banner,
        fit: BoxFit.fill,
        width: SizeConfig.screenWidth,
      ),
    );
  }

  Widget _getProductsDropDown() {
    return Container(
      width: SizeConfig.screenWidth * 0.70,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.lighterGrey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "All Products",
            style: CustomTextStyles.regularMediumFont,
          ),
          Image.asset(
            DhanvarshaImages.drop,
            width: 10,
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _ProgressOverView() {
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.lighterGrey,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(top: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Overview",
                        style: CustomTextStyles.regularMediumFont,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColors.lighterGrey,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                        child: Text("JUL 21"),
                      )
                    ],
                  ),
                )),
            Expanded(
              flex: 10,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: SizeConfig.screenHeight * 0.15,
                      width: SizeConfig.screenHeight * 0.15,
                      child: CircularPercentIndicator(
                        radius: SizeConfig.screenHeight * 0.15,
                        animation: true,
                        animationDuration: 1200,
                        lineWidth: 8.0,
                        percent: 0.4,
                        center: new Text("25.8 %",
                            style: CustomTextStyles.regularsmalleFonts),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: AppColors.lighterGrey,
                        progressColor: AppColors.light,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '186',
                                    style: CustomTextStyles.boldsmallRedFontGotham),
                                TextSpan(
                                    text: ' Applications',
                                    style: CustomTextStyles.regularsmalleFonts),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '46',
                                    style: CustomTextStyles.boldsmallRedFontGotham),
                                TextSpan(
                                    text: ' Loan Disbursed',
                                    style: CustomTextStyles.regularsmalleFonts),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Value of Loans",
                                  style: CustomTextStyles.regularMediumFont,
                                ),
                                Text(
                                  "₹ 18.5 L",
                                  style: CustomTextStyles.boldMediumFont,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getApplication() {
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.lighBox,
          ),
          color: AppColors.lighBox,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text(
              "Application",
              style: CustomTextStyles.boldMediumFont,
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 7),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "246",
                        style: CustomTextStyles.boldLargeFonts,
                      ),
                      Text(
                        "Pending",
                        style: CustomTextStyles.regularLightBoxsmalleFonts,
                      ),
                    ],
                  )),
                  Container(
                      height: 30,
                      child: VerticalDivider(color: AppColors.lighterGrey)),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "186",
                        style: CustomTextStyles.boldLargeFonts,
                      ),
                      Text(
                        "Submitted",
                        style: CustomTextStyles.regularLightBoxsmalleFonts,
                      ),
                    ],
                  )),
                  Container(
                      height: 30,
                      child: VerticalDivider(color: AppColors.lighterGrey)),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "74",
                        style: CustomTextStyles.boldLargeFonts,
                      ),
                      Text(
                        "Expired",
                        style: CustomTextStyles.regularLightBoxsmalleFonts,
                      ),
                    ],
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getPostOffer() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pre- Offer",
                style: CustomTextStyles.regularMediumFont,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostOffer(
                        type: "Pre",
                      ),
                    ),
                  );
                },
                child: Text(
                  "14 Tasks",
                  style: CustomTextStyles.boldsmallRedFontGotham,
                ),
              )
            ],
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Container(
                child: Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.lighBox,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 13,
                        child: Container(
                          color: AppColors.lighBox,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "246",
                                style: CustomTextStyles.boldMediumFont,
                              ),
                              Text(
                                "Pending",
                                style: CustomTextStyles.regularSmallGreyFont,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 35,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Credit Descision",
                                style: CustomTextStyles.boldMediumFont,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "15 approved * ",
                                    style:
                                        CustomTextStyles.regularSmallGreyFont,
                                  ),
                                  Text(
                                    "9 rejected",
                                    style:
                                        CustomTextStyles.regularSmallGreyFont,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Container(
                child: Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.lighBox,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 12,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        DhanvarshaImages.burger,
                                        height: 20,
                                        width: 20,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Offer",
                                          style:
                                              CustomTextStyles.boldMediumFont,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: AppColors.lighBox,
                                  ),
                                  child: Text(
                                    "5 Expired",
                                    style:
                                        CustomTextStyles.regularSmallGreyFont,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "23 Approved * ",
                                        style: CustomTextStyles
                                            .regularSmallGreyFont,
                                      ),
                                      Text(
                                        "39 Rejected",
                                        style: CustomTextStyles
                                            .regularSmallGreyFont,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: CustomButton(
                                    onButtonPressed: () {},
                                    title: "51 Pending",
                                    boxDecoration: ButtonStyles
                                        .greyButtonWithCircularBorder,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getPostList() {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Post-Offer",
                      style: CustomTextStyles.regularMediumFont,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostOffer(),
                          ),
                        );
                      },
                      child: Text(
                        "14 Tasks",
                        style: CustomTextStyles.boldsmallRedFontGotham,
                      ),
                    )
                  ],
                ),
                _horizontalListView()
              ],
            ),
            CustomButton(
              onButtonPressed: () {},
              title: "NEW APPLICATION",
            )
          ],
        ));
  }

  Widget _horizontalListView() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
          itemCount: listOfPostOffer.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              _returnSimpleCard(listOfPostOffer, index)),
    );
  }

  Widget _returnSimpleCard(List<PostOfferDTO> list, int index) {
    return Container(
      width: (SizeConfig.screenWidth - 15) / 3,
      height: 140,
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.lighterGrey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            list.elementAt(index).title,
            style: CustomTextStyles.boldMediumFont,
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                Text(
                  list.elementAt(index).pending.toString() + " Pending",
                  style: CustomTextStyles.regularsmalleFonts,
                ),
                Text(
                  list.elementAt(index).signed.toString() + " Signed",
                  style: CustomTextStyles.regularsmalleFonts,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBox({Color color = Colors.black}) => Container(
        margin: EdgeInsets.all(12),
        height: 100,
        width: 200,
        color: color,
      );
}
