import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/model/postofferdatadto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/dashboard/buisinessloanstatus.dart';
import 'package:dhanvarsha/ui/dashboard/goldloanstatus.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:flutter/material.dart';

class PostOffer extends StatefulWidget {
  final String type;

  const PostOffer({Key? key, this.type = "Post"}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostOfferState();
}

class _PostOfferState extends State<PostOffer> {
  List<PostOfferDataDTO> listOfPostOffer = [
    new PostOfferDataDTO("Pramod Siraskar", "Docs Collection"),
    new PostOfferDataDTO("Nasatya Gharapure", "Call & Follow up"),
    new PostOfferDataDTO("Viswamitra Mallya", "Set Appointment"),
    new PostOfferDataDTO("Gopal Gharpure", "Gold Pickup"),
    new PostOfferDataDTO("Mahava Bakshi", "Attend Query"),
    new PostOfferDataDTO("Keshav Upandhye", "Call & Follow up"),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView(
        type: false,
        title: widget.type == "Post" ? "Post Offer" : "Pre Offer",
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              _getTitleCompoenent(),
              _nameStatusHeader(),
              _getListWidgets()
            ],
          ),
        ),
        context: context);
  }

  Widget _getTitleCompoenent() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "14 Tasks",
            style: CustomTextStyles.boldLargeFonts,
          ),
        ],
      ),
    );
  }

  Widget _nameStatusHeader() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  child: Text(
                    "Name",
                    style: CustomTextStyles.regularMediumGreyFontGotham,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Image.asset(
                    DhanvarshaImages.up,
                    height: 10,
                    width: 10,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  child: Text(
                    "Status",
                    style: CustomTextStyles.regularMediumGreyFontGotham,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Image.asset(
                    DhanvarshaImages.up,
                    height: 10,
                    width: 10,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getListWidgets() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: false,
          itemCount: listOfPostOffer.length,
          itemBuilder: (BuildContext context, int index) =>
              _getListViewItem(listOfPostOffer, index)),
    );
  }

  Widget _getListViewItem(List<PostOfferDataDTO> listOfPostOffer, int index) {
    return (GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuisinessLoan(),
          ),
        );
      },
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 7),
                child: Text(
                  listOfPostOffer.elementAt(index).Name,
                  style: CustomTextStyles.regularMediumFont,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      listOfPostOffer.elementAt(index).documents,
                      style: CustomTextStyles.regularMediumFont,
                    ),
                    Image.asset(
                      DhanvarshaImages.left,
                      height: 10,
                      width: 10,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
