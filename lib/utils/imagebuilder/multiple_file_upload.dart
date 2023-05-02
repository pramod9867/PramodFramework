import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/imagepicker.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

enum ImagePickerStatus { Uploaded, IsNewUploaded }

class MultipleFileUploader extends StatefulWidget {
  final String? name;
  final String? title;
  final bool isPasswordProtected;
  final String? description;
  final bool isImageShown;
  final List<String> initialData;
  final String? imageNew;
  final bool? isBankStatements;
  final bool? isSalaryImage;

  const MultipleFileUploader(
      {Key? key,
      this.name,
      this.title = "Bank Statement Added",
      this.description =
          "Provide e-statement in PDF Format. Scanned bank statement are not valid",
      this.isPasswordProtected = true,
      this.isImageShown = true,
      this.initialData = const [],
      this.imageNew = DhanvarshaImages.poa,
      this.isSalaryImage = false,
      this.isBankStatements = false})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => MultipleFilerUploaderState();
}

class MultipleFilerUploaderState extends State<MultipleFileUploader> {
  int count = 1;
  TextEditingController pdfPassword = TextEditingController();
  late ValueNotifier<List<String>> imagepicked;
  bool isSwitchPressed = false;
  List<String>? originalImages = [];

  @override
  void initState() {
    imagepicked = ValueNotifier(widget.initialData);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: imagepicked,
        builder: (BuildContext context, List<String> hasError, child) {
          if (imagepicked.value.length <= 0) {
            return _getHoirzontalImageUpload();
          } else {
            return _getUploadedUI();
          }
        });
  }

  List<String> _getMultipleFiles() {
    List<String> myWidgets = [];
    for (int i = 0; i < imagepicked.value.length; i++) {
      myWidgets.add(imagepicked.value[i]);
    }

    return myWidgets;
  }

  Widget _getUploadedCard(int index) {
    return GestureDetector(
      onTap: () {
        print(imagepicked.value.elementAt(index));

        String fileName = imagepicked.value.elementAt(index).split('/').last;
        print("File Name");
        print(fileName);
        if (fileName.toUpperCase().contains("JPG") ||
            fileName.toUpperCase().contains("JPEG") ||
            fileName.toUpperCase().contains("PNG")) {
          DialogUtils.showInfo(context, imagepicked.value.elementAt(index),
              type: 'img');
          print("into the image");
        } else {
          DialogUtils.showInfo(context, imagepicked.value.elementAt(index));
        }
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              DhanvarshaImages.tickmrk,
              fit: BoxFit.contain,
              height: 35,
              width: 35,
            ),
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  if (imagepicked != null) {
                    for (int i = 0; i < imagepicked.value.length; i++) {
                      if (index == i) {
                        imagepicked.value.removeAt(i);
                        imagepicked.notifyListeners();
                      }
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Image.asset(
                    DhanvarshaImages.garbeicon,
                    height: 25,
                    width: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
    );
  }

  Widget _getUploadedUI() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
          width: SizeConfig.screenWidth - 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: AppColors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  widget.title!,
                  style: CustomTextStyles.boldMediumFontGotham,
                ),
              ),
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: imagepicked.value.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return _getUploadedCard(index);
                  }),
              GestureDetector(
                onTap: () {
                  ImagePickerUtils.openMultipleFilePicker(
                    context,
                    (result) => {
                      if (imagepicked.value.length == 0)
                        {
                          if (imagepicked.value.length > 0 &&
                              Uri.parse(imagepicked.value[0]).isAbsolute)
                            {
                              imagepicked.value = [],
                            },
                          imagepicked.value = result.paths.cast<String>(),
                          imagepicked.notifyListeners()
                        }
                      else
                        {
                          if (imagepicked.value.length > 0 &&
                              Uri.parse(imagepicked.value[0]).isAbsolute)
                            {
                              imagepicked.value = [],
                            },
                          imagepicked.value.addAll(result.paths.cast<String>()),
                          imagepicked.notifyListeners()
                        }
                    },
                    isBankStatements: widget.isBankStatements!,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(DhanvarshaImages.uploadnew),
                    GestureDetector(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          "UPLOAD",
                          style: CustomTextStyles.boldMediumRedFont,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              widget.isPasswordProtected
                  ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Password Protected",
                                    style: CustomTextStyles.boldLargeFonts,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Is the pdf statement password\nprotected?",
                                          style: CustomTextStyles
                                              .regularMedium2GreyFont1,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FlutterSwitch(
                                      width: 55,
                                      height: 35,
                                      activeColor: AppColors.buttonRed,
                                      value: isSwitchPressed,
                                      onToggle: (value) {
                                        setState(() {
                                          isSwitchPressed = value;
                                        });
                                        print(value);
                                      },
                                    ),
                                  ])
                            ],
                          ),
                        ),
                        _getTextField()
                      ],
                    )
                  : Container()
            ],
          )),
    );
  }

  Widget _getTextField() {
    bool getValue = isSwitchPressed;
    return getValue
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: DVTextField(
              controller: pdfPassword,
              obsureText: true,
              outTextFieldDecoration:
                  BoxDecorationStyles.outButtonOfBoxGreyCorner,
              inputDecoration: InputDecorationStyles.inputDecorationTextField,
              title: "Password",
              hintText: "Enter PDF Password",
              errorText: "Enter Valid PDF Password",
              maxLine: 1,
              isValidatePressed: false,
            ),
          )
        : Container();
  }

  Widget _getHoirzontalImageUpload() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: SizeConfig.screenWidth - 30,
        padding: EdgeInsets.symmetric(vertical: widget.isImageShown ? 0 : 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.white),
        child: Column(
          children: [
            widget.isImageShown
                ? GestureDetector(
                    onTap: () {
                      // ImagePickerUtils.showDialogUtil(context,
                      //     (imageFile) => {imagepicked.value = imageFile!.path});
                    },
                    child: Container(
                      width: SizeConfig.screenWidth * 0.35,
                      height: SizeConfig.screenHeight * 0.15,
                      child: Image.asset(widget.imageNew!),
                      margin: EdgeInsets.symmetric(vertical: 20),
                    ),
                  )
                : Container(),
            widget.isSalaryImage!
                ? Container(
                    width: SizeConfig.screenWidth * 0.35,
                    height: SizeConfig.screenHeight * 0.15,
                    child: Image.asset(widget.imageNew!),
                    margin: EdgeInsets.symmetric(vertical: 10),
                  )
                : Container(),
            Text(
              widget.title!,
              style: CustomTextStyles.boldLargeFontsGotham,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
              child: Text(
                widget.description!,
                style: CustomTextStyles.regularMediumGreyFont1,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(DhanvarshaImages.uploadnew),
                GestureDetector(
                  onTap: () {
                    ImagePickerUtils.openMultipleFilePicker(
                        context,
                        (result) => {
                              if (imagepicked.value.length == 0)
                                {
                                  if (imagepicked.value.length > 0 &&
                                      Uri.parse(imagepicked.value[0])
                                          .isAbsolute)
                                    {
                                      imagepicked.value = [],
                                    },
                                  imagepicked.value =
                                      result.paths.cast<String>(),
                                }
                              else
                                {
                                  if (imagepicked.value.length > 0 &&
                                      Uri.parse(imagepicked.value[0])
                                          .isAbsolute)
                                    {
                                      imagepicked.value = [],
                                    },
                                  imagepicked.value
                                      .addAll(result.paths.cast<String>())
                                }
                            },
                        isBankStatements: widget.isBankStatements!);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      "UPLOAD",
                      style: CustomTextStyles.boldMediumRedFontGotham,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
