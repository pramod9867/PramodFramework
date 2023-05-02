import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

/*import 'package:dhanvarshab2c/bloc/getNearestBranchbloc.dart';
import 'package:dhanvarshab2c/constants/AppConstants.dart';
import 'package:dhanvarshab2c/constants/colors.dart';
import 'package:dhanvarshab2c/constants/index.dart';
import 'package:dhanvarshab2c/interfaces/app_interface.dart';
import 'package:dhanvarshab2c/model/messages/request_messages.dart';
import 'package:dhanvarshab2c/model/request/GetNearestBranchDto.dart';
import 'package:dhanvarshab2c/model/response/NearestBranchResponse.dart';
import 'package:dhanvarshab2c/model/response/engine_register_res.dart';
import 'package:dhanvarshab2c/model/successfulresponsedto.dart';
import 'package:dhanvarshab2c/ui/BaseView.dart';
import 'package:dhanvarshab2c/ui/BaseView1.dart';
import 'package:dhanvarshab2c/ui/goldloan/salaried/branchDataNameId.dart';
import 'package:dhanvarshab2c/ui/goldloan/salaried/documents_list_page.dart';
import 'package:dhanvarshab2c/utils/boxdecoration.dart';
import 'package:dhanvarshab2c/utils/buttonstyles.dart';
import 'package:dhanvarshab2c/utils/customtextstyles.dart';
import 'package:dhanvarshab2c/utils/customvalidator.dart';
import 'package:dhanvarshab2c/utils/dialog/dialogutils.dart';
import 'package:dhanvarshab2c/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarshab2c/utils/inputdecorations.dart';
import 'package:dhanvarshab2c/utils/size_config.dart';
import 'package:dhanvarshab2c/widgets/Buttons/custombutton.dart';
import 'package:dhanvarshab2c/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarshab2c/widgets/custom_textfield/dvtextfield.dart';*/
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/model/response/listofnearestbranchdto.dart';
import 'package:dhanvarsha/model/response/nearestbranchdetailsresponse.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/goldloan/animator/AppAnimation.dart';
import 'package:dhanvarsha/ui/goldloan/appointmentsumm/AppointmentSumm.dart';
import 'package:dhanvarsha/ui/goldloan/branchoption/NearestBranchResponse.dart';
import 'package:dhanvarsha/ui/goldloan/kycdocuments/KycDocuments.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/buttonstyles.dart';
import 'package:dhanvarsha/utils/commautils/common_age_validator.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/utils/size_config.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'dart:ui' as ui;
/*import 'package:location/location.dart';
import 'package:maps_launcher/maps_launcher.dart';*/
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class BranchOptionPage extends StatefulWidget {
  final List<NearestBrachDetailsResponseDTO>? nearestBranchDetails;
  final String? branchName;

  const BranchOptionPage({Key? key, this.nearestBranchDetails, this.branchName})
      : super(key: key);

  @override
  _BranchOptionPageState createState() => _BranchOptionPageState();
}

class _BranchOptionPageState extends State<BranchOptionPage> {
  BitmapDescriptor? pinLocationIcon;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  double zoomVal = 5.0;
  String location = 'Null, Press Button';

  TextEditingController searchBranchEditingController =
      new TextEditingController();
  var isValidatePressed = false;
  int _selectedBranchIndex = -1;
  BitmapDescriptor? icMapMarker;
  GlobalKey previewBranch = GlobalKey();
  List<GlobalKey> listOfRepaintBoundryKeys = [];

  List<NearestBrachDetailsResponseDTO> _searchResult = [];
  GlobalKey<_BranchOptionPageState> _scrollViewKey = GlobalKey();
  int count = 0;

  //LocationData? _currentPosition;
  //GoogleMapController? _controllerMap;
  //Location locationCurrent = Location();
  //LatLng _initialcameraposition = LatLng(0.5937, 0.9629);

  @override
  void initState() {
    getIcons();
    //print("Nearest branch details");

    /*for (int i = 0;
    i < widget.nearestBranchDetails!.branchDetailsData!.length;
    i++) {
      listOfRepaintBoundryKeys.add(GlobalKey());
    }*/

    searchBranchEditingController.addListener(searchListner);
    //print(widget.nearestBranchDetails);
    super.initState();
  }

  searchListner() async {
    // //_searchResult.clear();
    // if (searchBranchEditingController.text.isEmpty) {
    //   setState(() {});
    //   return;
    // }
    // print("Text is");
    // print(searchBranchEditingController.text);

    setState(() {});
    widget.nearestBranchDetails!.forEach((branch) {
      if (branch.branchName!
              .toLowerCase()
              .contains(searchBranchEditingController.text.toLowerCase()) ||
          branch.addressLine1!
              .toLowerCase()
              .contains(searchBranchEditingController.text.toLowerCase()))
        _searchResult.add(branch);
    });
  }

  getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 3.2), DhanvarshaImages.downImage);

    setState(() {
      this.icMapMarker = icon;
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void dispose() {
    searchBranchEditingController.removeListener(searchListner);
    // TODO: implement dispose
    super.dispose();
  }


  double? meanLat = 0;
  double? meanLong = 0;

  @override
  Widget build(BuildContext context) {
    _markers.clear();

    for (int i = 0; i < widget.nearestBranchDetails!.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(
            widget.nearestBranchDetails!.elementAt(i).branchName.toString()),
        position: LatLng(
            double.parse(widget.nearestBranchDetails!.elementAt(i)!.latitude!),
            double.parse(
                widget.nearestBranchDetails!.elementAt(i)!.longitude!)),
        infoWindow: InfoWindow(
            title: widget.nearestBranchDetails!.elementAt(i).branchName),
        icon: icMapMarker!,
      ));

      meanLat =meanLat! + double.parse(widget.nearestBranchDetails!.elementAt(i).latitude!);

      meanLong =meanLong! + double.parse(widget.nearestBranchDetails!.elementAt(i).longitude!);

    }


    if(widget.nearestBranchDetails!.length>0){
      meanLat=meanLat!/widget.nearestBranchDetails!.length;
      meanLong=meanLong!/widget.nearestBranchDetails!.length;
    }
//    _markers.add(Marker(
//      markerId: const MarkerId('newyork1'),
//      position: const LatLng(40.742451, -74.005959),
//      infoWindow: const InfoWindow(title: 'Los Tacos'),
//      icon: icIcon,
//    ));
//
//    _markers.add(Marker(
//      markerId: const MarkerId('newyork2'),
//      position: const LatLng(40.729640, -73.983510),
//      infoWindow: const InfoWindow(title: 'Tree Bistro'),
//      icon: icIcon,
//    ));
//
//    _markers.add(Marker(
//      markerId: const MarkerId('newyork3'),
//      position: const LatLng(40.719109, -74.000183),
//      infoWindow: const InfoWindow(title: 'Le Coucou'),
//      icon: icIcon,
//    ));

//    _branches.add(Branch(
//        "Andheri East",
//        "Open",
//        "1.4 KMs",
//        "1st Floor,DJ House,Building No 4,Wilson Compound,Old Nagras Road,Mumbai",
//        "40.729640",
//        "-73.983510"));
//    _branches.add(Branch(
//        "Andheri West",
//        "Open",
//        "2.4 KMs",
//        "1st Floor,DJ House,Building No 4,Wilson Compound,Old Nagras Road,Mumbai",
//        "40.742451",
//        "-74.005959"));
//
//    _branches.add(Branch(
//        "Andheri West 1",
//        "Open",
//        "2.4 KMs",
//        "1st Floor,DJ House,Building No 4,Wilson Compound,Old Nagras Road,Mumbai",
//        "40.719109",
//        "-74.000183"));

    return BaseView(
        context: context,
        type: false,
        isStepShown: false,
        isheaderShown: false,
        body: Container(
          key: _scrollViewKey,
          //color: AppColors.g,
          height: (SizeConfig.screenHeight) - 30,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Stack(
                    children: [
                      _buildGoogleMap(context),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Image.asset(
                            DhanvarshaImages.bck,
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                        child: DVTextField(
                          textInputType: TextInputType.text,
                          controller: searchBranchEditingController,
                          outTextFieldDecoration:
                              BoxDecorationStyles.outTextFieldBoxDecoration,
                          inputDecoration:
                              InputDecorationStyles.inputDecorationTextField,
                          title: "Search by Branch Name or Address",
                          isSearchIcon: true,
                          image: DhanvarshaImages.srch,
                          hintText: "Search by Branch Name or Address",
                          errorText: "Please enter valid mobile number",
                          maxLine: 1,
                          isValidatePressed: isValidatePressed,
                          type: Validation.mobileNumber,
                          isTitleVisible: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    height: (SizeConfig.screenHeight) / 2,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.grey.shade300),
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(20),
                            right: Radius.circular(20))),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            /*widget.nearestBranchDetails!.branchDetailsData!
                                .length
                                .toString() +*/
                            "${widget.nearestBranchDetails!.length} Branches near you",
                            style: CustomTextStyles.boldLargeFonts
                                .copyWith(color: AppColors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        _getBranchVrLv()
                      ],
                    )),
              ),
            ],
          ),
        ));
  }

  Widget _buildGoogleMap(BuildContext context) {
//    var icIcon = icMapMarker ??
//        BitmapDescriptor.defaultMarkerWithHue(
//          BitmapDescriptor.hueViolet,
//        );

//    _markers.add(Marker(
//      markerId: MarkerId('newyork1'),
//      position: LatLng(double.parse(widget.nearestBranchDetails!.branchDetailsData!.elementAt(index).Latitude!),
//        double.parse(widget.nearestBranchDetails!.branchDetailsData!.elementAt(index)!.Longitude!)),
//      infoWindow:  InfoWindow(title: widget.nearestBranchDetails!.branchDetailsData!.elementAt(index)!.branchName),
//      icon: icIcon,
//    ));

    return GoogleMap(
      mapType: MapType.normal,

      myLocationEnabled: true,
      mapToolbarEnabled: false,
      cameraTargetBounds: CameraTargetBounds.unbounded,
      initialCameraPosition:
          CameraPosition(target:  LatLng(meanLat!, meanLong!), zoom: 10),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: _markers,
    );
  }

  Widget _getBranchVrLv() {
    return Expanded(
        child: new ListView.builder(
      itemCount: widget.nearestBranchDetails!.length,
      //itemCount: widget.nearestBranchDetails!.branchDetailsData!.length,
      //itemCount: 0,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        // print("BRanch Name is");
        // print(searchBranchEditingController.text);
        // print(widget.nearestBranchDetails!.branchDetailsData!
        //     .elementAt(index)
        //     .branchName);

        // return _getItemBranchOption(widget.nearestBranchDetails!, index);
        return (widget.nearestBranchDetails!
                    .elementAt(index)
                    .branchName!
                    .toUpperCase()!
                    .contains(
                        searchBranchEditingController.text.toUpperCase()) ||
                searchBranchEditingController.text == "" ||
                widget.nearestBranchDetails!
                    .elementAt(index)
                    .addressLine1!
                    .toUpperCase()!
                    .contains(searchBranchEditingController.text.toUpperCase()))
            ? _getItemBranchOption(widget.nearestBranchDetails!, index)
            : Container();
      },
    ));
  }

  Widget _getItemBranchOption(
      List<NearestBrachDetailsResponseDTO> branches, int index) {
    count = count + 1;
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //       builder: (_) => AppAnimation(
        //           gifPath: "assets/images/glappreceived.gif",
        //           navigation: () {
        //             Navigator.pushReplacement(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => AppointmentSumm(),
        //               ),
        //             );
        //           })),
        // );
        Navigator.pop(
            context, jsonEncode(widget.nearestBranchDetails!.elementAt(index)));
//        Navigator.of(this.context).pop();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RepaintBoundary(
              //key: listOfRepaintBoundryKeys.elementAt(index),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        branches!.elementAt(index)!.branchName!,
                        //branches[index].name ?? "",
                        style: CustomTextStyles.boldMedium1Font
                            .copyWith(color: AppColors.black),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Open till 6pm ",
                            style: CustomTextStyles.boldsmalleFonts
                                .copyWith(color: AppColors.green),
                          ),
                          Text(
                            CommonAgeValidator.KmsToMeterst(
                                    branches!.elementAt(index)!.distance!) +
                                " KMs",
                            style: CustomTextStyles.boldsmalleFonts
                                .copyWith(color: AppColors.black),
                          ),
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 if (widget.branchName ==
//                                     branches.branchDetailsData!
//                                         .elementAt(index)!
//                                         .branchName!) {
//                                   _selectedBranchIndex = index;
//                                 } else {
//                                   _selectedBranchIndex = -1;
//                                 }
//                                 // if (_selectedBranchIndex == index) {
//                                 //
//                                 //   _selectedBranchIndex = -1;
//                                 // } else {
//                                 //   _selectedBranchIndex = index;
//                                 // }
//                               });
//
//                               //BranchNameIdData.branchName=branches.branchDetailsData!.elementAt(index)!.branchName!;
//                               //BranchNameIdData.Id=int.parse(branches.branchDetailsData!.elementAt(index)!.id.toString());
//
// //                          branches.branchDetailsData!.elementAt(index)!.branchName!
// //                          Navigator.pop(context,'Yep !!');
//                               //Navigator.of(this.context).pop(branches.branchDetailsData!.elementAt(index)!.branchName!);
//                             },
//                             child: Image.asset(
//                               //_selectedBranchIndex == index
//
//                               widget.branchName ==
//                                       branches.branchDetailsData!
//                                           .elementAt(index)
//                                           .branchName
//                                   ? dhanvarshaImages.icSelectTickGreen
//                                   : dhanvarshaImages.icUnselectTickWhite,
//                               fit: BoxFit.contain,
//                               height: 20,
//                               width: 20,
//                             ),
//                           ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  branches!.elementAt(index)!.addressLine1!,
                  style: CustomTextStyles.regularSmallGreyFont,
                ),
              ]),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /* GestureDetector(
                  onTap: () {
                    launch("tel://9922636855");
                  },
                  child: Image.asset(
                    dhanvarshaImages.icCall,
                    fit: BoxFit.contain,
                    height: 30,
                    width: 30,
                  ),
                ),*/

                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            //saveScreen(index);
                            // MapsLauncher.launchQuery(widget
                            //     .nearestBranchDetails!
                            //     .elementAt(index)!
                            //     .addressLine1!);
//                    _gotoLocation(
//                      double.parse(branches.branchDetailsData!.elementAt(index)!.Latitude!),
//                      double.parse(branches.branchDetailsData!.elementAt(index)!.Longitude!),
//                    );
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5, 3, 20, 0),
                            child: Image.asset(
                              DhanvarshaImages.cl,
                              fit: BoxFit.fill,
                              height: 30,
                              width: 30,
                            ),
                          )),
                      GestureDetector(
                        onTap: () {
                          // MapsLauncher.createCoordinatesUrl(latitude, longitude)
                          // MapsLauncher.launchQuery(branches.branchDetailsData!
                          //     .elementAt(index)!
                          //     .branchAddress!);

                          MapsLauncher.launchCoordinates(
                              double.parse(
                                  branches!.elementAt(index)!.longitude!),
                              double.parse(
                                  branches!.elementAt(index)!.latitude!));
//                    _gotoLocation(
//                      double.parse(branches.branchDetailsData!.elementAt(index)!.Latitude!),
//                      double.parse(branches.branchDetailsData!.elementAt(index)!.Longitude!),
//                    );
                        },
                        child: Image.asset(
                          DhanvarshaImages.lc,
                          fit: BoxFit.fill,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Share.share("Branch Name: " +
                          widget.nearestBranchDetails!
                              .elementAt(index)!
                              .branchName! +
                          "\n" +
                          "\n" +
                          "Branch Address: " +
                          widget.nearestBranchDetails!
                              .elementAt(index)!
                              .addressLine1! +
                          "\n" +
                          "\n" +
                          "Location: " +
                          "https://www.google.com/maps?q=" +
                          widget.nearestBranchDetails!
                              .elementAt(index)!
                              .latitude!! +
                          "," +
                          widget.nearestBranchDetails!
                              .elementAt(index)
                              .longitude!);
                    },
                    child: Container(
                      height: SizeConfig.screenHeight * 0.05,
                      width: SizeConfig.screenWidth * 0.25,
                      decoration: ButtonStyles.redButtonWithCircularBorder,
                      margin: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          "SHARE",
                          style: CustomTextStyles.buttonTextStyle,
                        ),
                      ),
                    ),

                    /*Image.asset(
                      widget.branchName==branches.branchDetailsData!.elementAt(index).branchName?
                      DhanvarshaImages.card:DhanvarshaImages.card,
                      fit: BoxFit.cover,
                      height: 20,
                      width: 20,
                    )*/
                  ),
                ],
              ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }

  Widget _getRepaintBoundry() {
    return RepaintBoundary(
      key: previewBranch,
      child: Container(
        child: Text("Hello world"),
      ),
    );
  }

  // _openMap() async {
  //   const url = 'https://www.google.com/maps/search/?api=1&query=52.32,4.917';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(meanLat!, meanLong!),
      zoom: 5,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }

//  getLoc() async{
//    bool _serviceEnabled;
//    PermissionStatus _permissionGranted;
//
//    _serviceEnabled = await locationCurrent.serviceEnabled();
//    if (!_serviceEnabled) {
//      _serviceEnabled = await locationCurrent.requestService();
//      if (!_serviceEnabled) {
//        return;
//      }
//    }
//
//    _permissionGranted = await locationCurrent.hasPermission();
//    if (_permissionGranted == PermissionStatus.DENIED) {
//      _permissionGranted = await locationCurrent.requestPermission();
//      if (_permissionGranted != PermissionStatus.GRANTED) {
//        return;
//      }
//    }
//
//    _currentPosition = await locationCurrent.getLocation();
//    _initialcameraposition = LatLng(_currentPosition!.latitude,_currentPosition!.longitude);
//    locationCurrent.onLocationChanged().listen((LocationData currentLocation) {
//      print("${currentLocation.longitude} : ${currentLocation.longitude}");
//      setState(() {
//        _currentPosition = currentLocation;
//        _initialcameraposition = LatLng(_currentPosition!.latitude,_currentPosition!.longitude);
//
//      });
//    });
//  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), DhanvarshaImages.card);
  }

  saveScreen(int index) async {
    try {
      RenderRepaintBoundary? boundary = listOfRepaintBoundryKeys
          .elementAt(index)
          .currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      var image = await boundary!.toImage();
      var byteData = await image.toByteData(format: ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      final directory = (await getExternalStorageDirectory())!.path;
      File imgFile = new File('$directory/screenshot.png');
      print("image path " + imgFile.path);
      imgFile.writeAsBytes(pngBytes);
      Share.shareFiles(
        [imgFile.absolute.path],
        subject: 'Screenshot + Share',
      );
    } catch (err) {
      throw "Image can't be share";
    }
  }

  onSearched(String text) {
    // widget.nearestBranchDetails!.nearestBranchDetailsDTO!.forEach((branch) {
    //   if (branch.branchName!
    //       .toLowerCase()
    //       .contains(searchBranchEditingController.text.toLowerCase()) ||
    //       branch.branchName!
    //           .toLowerCase()
    //           .contains(searchBranchEditingController.text.toLowerCase()) ||
    //       branch.Pincode!.contains(searchBranchEditingController.text))
    //     _searchResult.add(branch);
    //   setState(() {});
    // });
  }
}

class Branch {
  String? name;
  String? status;
  String? distance;
  String? address;
  String? lat;
  String? long;

  Branch(
      this.name, this.status, this.distance, this.address, this.lat, this.long);
}
