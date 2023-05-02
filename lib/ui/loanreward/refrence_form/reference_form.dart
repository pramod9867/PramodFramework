import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/formatters/uppercaseformatter.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RefrenceForm extends StatefulWidget {
  final String initialName;
  final int id;
  final int index;
  final String emailId;
  final String mobileNumber;
  final VoidCallback? deletItem;
  const RefrenceForm(
      {Key? key,
      this.initialName = "",
      this.emailId = "",
      this.mobileNumber = "",
      this.id = 0,
      this.index = 0,
      this.deletItem})
      : super(key: key);

  @override
  RefrenceFormState createState() => RefrenceFormState();
}

class RefrenceFormState extends State<RefrenceForm> {
  late TextEditingController fullNameController;
  late TextEditingController emailIdController;
  late TextEditingController mobileNumberController;

  bool isValidatePressed = false;

  MasterDataDTO get favouriteFoodModel => _favouriteFoodModel;

  set favouriteFoodModel(MasterDataDTO value) {
    _favouriteFoodModel = value;
  }

  late MasterBloc? masterBloc;
  late MasterDataDTO _favouriteFoodModel;

  late List<DropdownMenuItem<MasterDataDTO>> _favouriteFoodModelDropdownList;
  List<DropdownMenuItem<MasterDataDTO>> _buildFavouriteFoodModelDropdown(
      List favouriteFoodModelList) {
    List<DropdownMenuItem<MasterDataDTO>> items = [];
    for (MasterDataDTO favouriteFoodModel in favouriteFoodModelList) {
      items.add(DropdownMenuItem(
        value: favouriteFoodModel,
        child: Text(
          favouriteFoodModel.name!,
          style: CustomTextStyles.regularMediumFont,
        ),
      ));
    }
    return items;
  }

  bool isSwitchPressed = false;
  bool isCurrentSwitchPressed = false;
  onChangeFavouriteFoodModelDropdown(MasterDataDTO? favouriteFoodModel) {
    setState(() {
      _favouriteFoodModel = favouriteFoodModel!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameController = TextEditingController(text: widget.initialName);

    emailIdController = TextEditingController(text: widget.emailId);

    mobileNumberController = TextEditingController(text: widget.mobileNumber);

    masterBloc = BlocProvider.getBloc<MasterBloc>();

    int index = MasterDocumentId.builder.getRelationshipIndex(widget.id! ?? 0);

    print("Index is" + index.toString());

    print("MOde Of Salary" + index.toString());
    if (index == 0) {
      _favouriteFoodModel = masterBloc!.masterSuperDTO!.relationType![0];
    } else {
      _favouriteFoodModel = masterBloc!.masterSuperDTO!.relationType![index];
    }
    print("Relation Ship Type");
    print(masterBloc?.masterSuperDTO.relationType);
    _favouriteFoodModelDropdownList = _buildFavouriteFoodModelDropdown(
        masterBloc?.masterSuperDTO.relationType ?? []);
  }

  bool onSubmitPressed() {
    setState(() {
      isValidatePressed = true;
    });


    if (CustomValidator(fullNameController.value.text)
            .validate(Validation.isEmpty) &&
        CustomValidator(mobileNumberController.value.text)
            .validate(Validation.mobileNumber)) {

      return true;
    } else {
      SuccessfulResponse.showScaffoldMessage(
          AppConstants.fillAllDetails, context);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Reference ${widget.index + 1} ",
                  style: CustomTextStyles.boldMediumFont,
                ),
              ),
              widget.index >= 2
                  ? GestureDetector(
                      onTap: widget.deletItem,
                      child: Image.asset(DhanvarshaImages.garbeicon),
                    )
                  : Container(),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: DVTextField(
              textInputType: TextInputType.text,
              controller: fullNameController,
              outTextFieldDecoration:
                  BoxDecorationStyles.outButtonOfBoxGreyCorner,
              inputDecoration: InputDecorationStyles.inputDecorationTextField,
              title: "Full Name",
              textInpuFormatter: [
                UpperCaseTextFormatter(),
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z_ ]"))
              ],
              hintText: "Enter Full Name (as on PAN)",
              errorText: "Please Enter First Name",
              maxLine: 1,
              isValidatePressed: isValidatePressed,
            ),
          ),
          Visibility(
            visible: false,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: DVTextField(
                textInputType: TextInputType.text,
                controller: emailIdController,
                outTextFieldDecoration:
                    BoxDecorationStyles.outButtonOfBoxGreyCorner,
                inputDecoration: InputDecorationStyles.inputDecorationTextField,
                title: "Email Id",
                hintText: "Email Id",
                type: Validation.isEmail,
                errorText: "Please Enter email id",
                maxLine: 1,
                isValidatePressed: false,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: DVTextField(
              textInputType: TextInputType.number,
              controller: mobileNumberController,
              outTextFieldDecoration:
                  BoxDecorationStyles.outButtonOfBoxGreyCorner,
              inputDecoration: InputDecorationStyles.inputDecorationTextField,
              title: "Enter Mobile Number",
              textInpuFormatter: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              hintText: "Enter mobile no",
              is91: true,
              isFlag: true,
              errorText: "Please Enter Mobile Number",
              maxLine: 1,
              isValidatePressed: isValidatePressed,
              type: Validation.mobileNumber,
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: CustomDropdown(
                dropdownMenuItemList: _favouriteFoodModelDropdownList,
                onChanged: onChangeFavouriteFoodModelDropdown,
                value: _favouriteFoodModel,
                isEnabled: true,
                title: "Relation with customer",
                isTitleVisible: true,
              )),
        ],
      ),
    );
  }
}
