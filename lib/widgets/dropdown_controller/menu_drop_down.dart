import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/ui/loantype/employeedetails.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

typedef onItemPressedCallback = Function(int id);

class MenuDropDown<T extends MasterDataDTO> extends StatefulWidget {
  final List<T>? masterDto;
  final MenueBuilder builder;
  final onItemPressedCallback? callback;
  final String errorText;
  final bool isTitleVisible;
  final bool isValidatePressed;
  final String title;
  final String headerTitle;
  final String description;
  final String hintText;
  final bool isEmpPressed;
  final bool isCallBackRequired;
  const MenuDropDown(
      {Key? key,
      this.masterDto,
      required this.builder,
      this.errorText = "",
      required this.isValidatePressed,
      this.hintText = "",
      this.title = "",
      this.description = "",
      this.isEmpPressed = false,
      this.isTitleVisible = true,
      this.headerTitle = "",
      this.callback,
      this.isCallBackRequired = false})
      : super(key: key);

  @override
  _MenuDropDownState<T> createState() => _MenuDropDownState<T>();
}

class _MenuDropDownState<T> extends State<MenuDropDown> {
  TextEditingController officialEmailid = new TextEditingController();

  @override
  void initState() {
    print(widget.masterDto);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isEmpPressed) {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          onDropDownPressed();
        } else {
          onPressedEmpType();
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        }
      },
      child: _getNameContainer(),
    );
  }

  _getNameContainer() {
    return ValueListenableBuilder(
        valueListenable: widget.builder.menuNotifier,
        builder: (_, status, __) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: (widget.isTitleVisible &&
                              widget.builder.menuNotifier.value.length > 0)
                          ? 0
                          : 15),
                  decoration: (widget.builder.menuNotifier.value.length <= 0 &&
                          widget.isValidatePressed)
                      ? BoxDecorationStyles.outTextFieldBoxErrorDecoration
                      : BoxDecorationStyles.outTextFieldBoxDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (widget.isTitleVisible &&
                              widget.builder.menuNotifier.value.length > 0)
                          ? Container(
                              margin: EdgeInsets.only(top: 1, bottom: 4),
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                widget.headerTitle,
                                style: CustomTextStyles.regularSmallGreyFontGotham,
                              ),
                            )
                          : Container(),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: (widget.isTitleVisible &&
                              widget.builder.menuNotifier.value.length > 0)? 4:0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            
                              widget.builder.menuNotifier.value.length > 0
                                  ? widget.builder.menuNotifier.value
                                      .elementAt(0)
                                      .name!
                                  : widget.hintText,
                              style: widget.builder.menuNotifier.value.length <= 0
                                  ? CustomTextStyles.regularMediumFontGothamTextFieldGreyCalendar
                                  : CustomTextStyles.regularMediumFontGothamTextField,
                            ),
                            Image.asset(
                              DhanvarshaImages.drop6,
                              height: 15,
                              width: 15,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                (widget.builder.menuNotifier.value.length <= 0 &&
                        widget.isValidatePressed)
                    ? _getErrorText()
                    : Container()
              ],
            ),
          );
        });
  }

  _getErrorText() {
    if (true) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: Text(
          widget.errorText,
          style: CustomTextStyles.boldsmallRedFontGotham,
        ),
      );
    } else {
      return Container();
    }
  }

  onPressedEmpType() {
    print("widget updated");
    print(widget.masterDto);
    showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ValueListenableBuilder(
              valueListenable: widget.builder.menuNotifier,
              builder: (_, status, __) {
                return Container(
                  height: SizeConfig.blockSizeVertical * 35,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
            
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                            child: Text(
                          widget.title,
                          style: CustomTextStyles.MediumBoldLightFont,
                        )),
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: widget.masterDto!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (widget.masterDto!
                                          .elementAt(index)
                                          .name!
                                          .toUpperCase()
                                          .contains(officialEmailid.value.text
                                              .toUpperCase()) ||
                                      officialEmailid.value.text == "")
                                  ? GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        print(index);
                                        widget.builder.onItemSelect(
                                            widget.masterDto!.elementAt(index));
                                        Navigator.of(context).pop();
                                        print("This Pressed");
                                        officialEmailid.text = "";
                                        if (widget.isCallBackRequired) {
                                          print("This call back called");
                                          widget.callback!(widget
                                                  .builder
                                                  .menuNotifier
                                                  .value[0]
                                                  .value ??
                                              -1);
                                        }
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Image.asset(widget.masterDto!.elementAt(index)),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Image.asset(widget.masterDto!
                                                      .elementAt(index)
                                                      .image!),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          widget.masterDto!
                                                              .elementAt(index)
                                                              .name!,
                                                          style: CustomTextStyles
                                                              .boldMediumFontGotham,
                                                        ),
                                                        Text(
                                                          widget.masterDto!
                                                              .elementAt(index)
                                                              .description!,
                                                          style: CustomTextStyles
                                                              .regularSmallGreyFontGotham,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            (widget.builder.menuNotifier.value
                                                            .length >
                                                        0 &&
                                                    widget.masterDto!
                                                            .elementAt(index)
                                                            .value ==
                                                        widget.builder
                                                            .menuNotifier.value
                                                            .elementAt(0)
                                                            .value)
                                                ? Image.asset(
                                                    DhanvarshaImages.tickmrk,
                                                    height: 20,
                                                    width: 20,
                                                  )
                                                : Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .lighterGrey)),
                                                  )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              (widget.masterDto!
                                          .elementAt(index)
                                          .name!
                                          .contains(
                                              officialEmailid.value.text) ||
                                      officialEmailid.value.text == "")
                                  ? Divider()
                                  : Container()
                            ],
                          );
                        },
                      ))
                    ],
                  ),
                );
              });
        });
  }

  onDropDownPressed() {
    showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ValueListenableBuilder(
              valueListenable: widget.builder.menuNotifier,
              builder: (_, status, __) {
                return Container(
                  height: SizeConfig.screenHeight * 0.65,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          widget.title,
                          style: CustomTextStyles.boldLargeFontsGotham,
                        ),
                      ),
                   // widget.description!=""?  Text(
                   //      widget.description,
                   //      style: CustomTextStyles.regularSmallGreyFont,
                   //    ):Container(),
                      GestureDetector(
                        onTap: () {
                          widget.builder.menuNotifier.notifyListeners();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: DVTextField(
                            onEnterPressRequired: true,
                            onFieldSubmit: (text) {
                              widget.builder.menuNotifier.notifyListeners();

                              print(Platform.version);
                            },
                            textInputType: TextInputType.text,
                            controller: officialEmailid,
                            outTextFieldDecoration: BoxDecorationStyles
                                .outTextFieldBoxDecorationSearch,
                            inputDecoration:
                                InputDecorationStyles.inputDecorationTextField,
                            title: widget.title,
                            hintText: widget.hintText,
                            errorText: "Select employer name",
                            maxLine: 1,
                            isValidatePressed: false,
                            type: Validation.isEmpty,
                            isSearchIcon: true,
                            image: DhanvarshaImages.srch,
                          ),
                        ),
                      ),
                      widget.masterDto!.length > 0
                          ? Expanded(
                              child: ListView.builder(
                              itemCount: widget.masterDto!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    (widget.masterDto!
                                                .elementAt(index)
                                                .name!
                                                .toUpperCase()
                                                .contains(officialEmailid
                                                    .value.text
                                                    .toUpperCase()) ||
                                            officialEmailid.value.text == "")
                                        ? GestureDetector(
                                            behavior:
                                                HitTestBehavior.translucent,
                                            onTap: () {
                                              print(index);
                                              widget.builder.onItemSelect(widget
                                                  .masterDto!
                                                  .elementAt(index));
                                              Navigator.of(context).pop();
                                              print("This Pressed");
                                              officialEmailid.text = "";
                                              if (widget.isCallBackRequired) {
                                                print("This call back called");
                                                widget.callback!(widget
                                                        .builder
                                                        .menuNotifier
                                                        .value[0]
                                                        .value ??
                                                    -1);
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    widget.masterDto!
                                                        .elementAt(index)
                                                        .name!,
                                                    style: CustomTextStyles
                                                        .regularMediumFont,
                                                  ),
                                                  (widget
                                                                  .builder
                                                                  .menuNotifier
                                                                  .value
                                                                  .length >
                                                              0 &&
                                                          widget.masterDto!
                                                                  .elementAt(
                                                                      index)
                                                                  .value ==
                                                              widget
                                                                  .builder
                                                                  .menuNotifier
                                                                  .value
                                                                  .elementAt(0)
                                                                  .value)
                                                      ? Image.asset(
                                                          DhanvarshaImages
                                                              .tickmrk,
                                                          height: 20,
                                                          width: 20,
                                                        )
                                                      : Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .lighterGrey)),
                                                        )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    (widget.masterDto!
                                                .elementAt(index)
                                                .name!
                                                .contains(officialEmailid
                                                    .value.text) ||
                                            officialEmailid.value.text == "")
                                        ? Divider()
                                        : Container()
                                  ],
                                );
                              },
                            ))
                          : Expanded(
                              child: Center(
                                child: Container(
                                  child: Text(
                                    "No data available",
                                    style:
                                        CustomTextStyles.regularMediumGreyFont1Gotham,
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                );
              });
        });
  }
}
