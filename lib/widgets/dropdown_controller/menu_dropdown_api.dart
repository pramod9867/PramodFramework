import 'package:dhanvarsha/bloc/empsearchbloc.dart';
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

typedef onItemPressedCallback = Function(int id);
typedef onSearchText = Function(String name);

class MenuDropDownApi<T extends MasterDataDTO> extends StatefulWidget {
  final List<T>? masterDto;
  final EmpSearchBloc? bloc;
  final MenueBuilder builder;
  final onItemPressedCallback? callback;
  final String errorText;
  final bool isTitleVisible;
  final bool isValidatePressed;
  final String title;
  final ValueChanged<String>? onFieldSubmit;
  final ValueChanged<String>? onChangedText;
  final String headerTitle;
  final String description;
  final String hintText;
  final bool isEmpPressed;
  final bool isCallBackRequired;
  final onSearchText? onSearchField;
  const MenuDropDownApi(
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
      this.isCallBackRequired = false,
      this.onSearchField,
      this.bloc,
      this.onFieldSubmit,
      this.onChangedText})
      : super(key: key);

  @override
  _MenuDropDownState<T> createState() => _MenuDropDownState<T>();
}

class _MenuDropDownState<T> extends State<MenuDropDownApi> {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: (widget.isTitleVisible &&
                              widget.builder.menuNotifier.value.length > 0)
                          ? 6
                          : 15),
                  decoration: (widget.builder.menuNotifier.value.length <= 0 &&
                          widget.isValidatePressed)
                      ? BoxDecorationStyles.outTextFieldBoxErrorDecoration
                      : BoxDecorationStyles.outTextFieldBoxDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (widget.isTitleVisible &&
                              widget.builder.menuNotifier.value.length > 0)
                          ? Container(
                               padding: EdgeInsets.symmetric(vertical: 4),
                              margin: EdgeInsets.only(top: 1, bottom: 4),
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
                            Expanded(
                              child: Text(
                                widget.builder.menuNotifier.value.length > 0
                                    ? widget.builder.menuNotifier.value
                                        .elementAt(0)
                                        .name!
                                    : widget.hintText,
                              style: widget.builder.menuNotifier.value.length <= 0
                                  ? CustomTextStyles.regularMediumFontGothamTextFieldGreyCalendar
                                  : CustomTextStyles.regularMediumFontGothamTextField,
                              ),
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
              valueListenable: widget.bloc!.listNotifier,
              builder: (_, status, __) {
                return Container(
                  height: SizeConfig.blockSizeVertical * 40,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        // margin: EdgeInsets.symmetric(vertical: 10),
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
                          // print(officialEmailid.value.text
                          //     .toUpperCase());
                          //
                          // print(widget.masterDto!
                          //     .elementAt(index)
                          //     .name!
                          //     .toUpperCase());
                          //
                          //
                          // print( (widget.masterDto!
                          //     .elementAt(index)
                          //     .name!
                          //     .toUpperCase()
                          //     .startsWith(officialEmailid.value.text
                          //     .toUpperCase()) ||
                          //     officialEmailid.value.text == ""));

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (widget.masterDto!
                                          .elementAt(index)
                                          .name!
                                          .toUpperCase()
                                          .startsWith(officialEmailid.value.text
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
                                          .startsWith(
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
              valueListenable: widget.bloc!.listNotifier,
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
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: DVTextField(
                                isApiDropdown: true,
                                isTitleVisible: false,
                                onChangedText: widget.onChangedText,
                                onEnterPressRequired: true,
                                onFieldSubmit: (text) {
                                  if (widget.bloc!.empList.length <= 0) {
                                    MasterDataDTO masterDto = MasterDataDTO(
                                        officialEmailid.text, 0,
                                        description: "", FinalCat: "Cat D");
                                    widget.builder.onItemSelect(masterDto);
                                    Navigator.pop(context);
                                  } else {}
                                },
                                textInputType: TextInputType.text,
                                controller: officialEmailid,
                                outTextFieldDecoration: BoxDecorationStyles
                                    .outTextFieldBoxDecorationSearch,
                                inputDecoration: InputDecorationStyles
                                    .inputDecorationTextField,
                                title: "Search employer name",
                                hintText: widget.hintText,
                                errorText: "Select employer name",
                                maxLine: 1,
                                isValidatePressed: false,
                                type: Validation.isEmpty,
                                isSearchIcon: true,
                                image: DhanvarshaImages.srch,
                                onSearchPressed: () {
                                  widget.onSearchField!(officialEmailid.text);
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                MasterDataDTO masterDto = MasterDataDTO(
                                    officialEmailid.text, 0,
                                    description: "", FinalCat: "");
                                widget.builder.onItemSelect(masterDto);
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.buttonRed,
                                ),
                                margin: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 10),
                                child: Text(
                                  "ADD NEW",
                                  style: CustomTextStyles.boldMediumrWhiteFont,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      if (status == ListListner.INITIAL)
                        Expanded(
                            child: Center(
                          child: Text(
                            "Please search the employer name",
                            style: CustomTextStyles.boldMediumFont,
                          ),
                        ))
                      else if (status == ListListner.INPROGRESS)
                        Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (status == ListListner.SUCCESSFUL)
                        Expanded(
                            child: ListView.builder(
                          itemCount: widget.bloc!.empList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.bloc != null &&
                                        widget.bloc!.empList
                                            .elementAt(index)
                                            .name!
                                            .toUpperCase()
                                            .startsWith(officialEmailid
                                                .value.text
                                                .toUpperCase())
                                    ? GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          print(index);
                                          widget.builder.onItemSelect(widget
                                              .bloc!.empList!
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                widget.bloc!.empList!
                                                    .elementAt(index)
                                                    .companyName!,
                                                style: CustomTextStyles
                                                    .regularMediumFontGotham,
                                              )),
                                              (widget.builder.menuNotifier.value
                                                              .length >
                                                          0 &&
                                                      widget.bloc!.empList!
                                                              .elementAt(index)
                                                              .id ==
                                                          widget
                                                              .builder
                                                              .menuNotifier
                                                              .value
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
                                    : Container()
                              ],
                            );
                          },
                        ))
                      else if (ListListner.ERROR == status)
                        Expanded(
                            child: Container(
                          child: Center(
                            child: Text(
                              "Something went wrong",
                              style: CustomTextStyles.boldMediumRedFont,
                            ),
                          ),
                        ))
                      else if (status == ListListner.EMPTY)
                        Expanded(
                            child: Center(
                          child: GestureDetector(
                            onTap: () {
                              MasterDataDTO masterDto = MasterDataDTO(
                                  officialEmailid.text, 0,
                                  description: "", FinalCat: "Cat D");
                              widget.builder.onItemSelect(masterDto);
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: Text(
                                "No Data Available",
                                style: CustomTextStyles.boldMediumRedFont,
                              ),
                            ),
                          ),
                        ))
                    ],
                  ),
                );
              });
        });
  }
}
