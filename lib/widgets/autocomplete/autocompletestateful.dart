// import 'package:dhanvarsha/constants/colors.dart';
// import 'package:dhanvarsha/utils/boxdecoration.dart';
// import 'package:dhanvarsha/utils/index.dart';
// import 'package:dhanvarsha/utils/inputdecorations.dart';
// import 'package:dhanvarsha/widgets/custom_textfield/dvtextfieldwithfocusnode.dart';
// import 'package:flutter/material.dart';
//
// class MyWidget<T> extends StatefulWidget {
//   final AutocompleteOptionsBuilder<T> optionsBuilder;
//   final AutocompleteOptionToString<T> optionsToString;
//   final double scalingFactor;
//   final String error;
//   final bool isValidatePressed;
//
//   final String textFieldTitle;
//
//   final String hintText;
//
//   const MyWidget(
//       {Key? key,
//       required this.optionsBuilder,
//       required this.optionsToString,
//       this.scalingFactor = 0,
//       this.error = "",
//       required this.isValidatePressed,
//       this.textFieldTitle = "",
//       this.hintText = ""})
//       : super(key: key);
//   @override
//   _MyWidgetState<T> createState() => _MyWidgetState<T>();
// }
//
// class _MyWidgetState<T> extends State<MyWidget<T>> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Autocomplete(
//       key: widget.key,
//       displayStringForOption: widget.optionsToString,
//       optionsBuilder: widget.optionsBuilder,
//       fieldViewBuilder: (BuildContext context,
//           TextEditingController fieldTextEditingController,
//           FocusNode fieldFocusNode,
//           VoidCallback onFieldSubmitted) {
//         return DVTextFieldFocusNode(
//             errorText: widget.error,
//             hintText: widget.hintText,
//             isValidatePressed: widget.isValidatePressed,
//             title: widget.textFieldTitle,
//             focusNode: fieldFocusNode,
//             outTextFieldDecoration:
//                 BoxDecorationStyles.outTextFieldBoxDecoration,
//             inputDecoration: InputDecorationStyles.inputDecorationTextField,
//             controller: fieldTextEditingController);
//       },
//       optionsViewBuilder: (BuildContext context,
//           AutocompleteOnSelected<T> onSelected, Iterable<T> options) {
//         return Align(
//           alignment: Alignment.topLeft,
//           child: Material(
//             color: AppColors.white,
//             elevation: 5,
//             child: Container(
//               width: SizeConfig.screenWidth - widget.scalingFactor,
//               margin: EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                   border: Border.all(
//                 width: 1,
//                 color: AppColors.white,
//               )),
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 itemCount: options.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final T option = options.elementAt(index);
//                   return GestureDetector(
//                     onTap: () {
//                       onSelected(option);
//                       // _key.currentState?.widget.controller.text = option.name;
//                       //
//                       // print(_key.currentState?.widget.controller.text);
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(vertical: 5),
//                       child: Text("Text",
//                           style: CustomTextStyles.regularMediumFont),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
