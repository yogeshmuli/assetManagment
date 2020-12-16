import 'package:assetManagment/components/customInputs.dart';
import 'package:assetManagment/components/loadingIndicator.dart';
import 'package:assetManagment/components/primaryCustomWidthButton.dart';

import 'package:assetManagment/providers/assetsProvider.dart';
import 'package:assetManagment/services/responseHandler.dart';

import 'package:intl/intl.dart';
import 'package:assetManagment/models/assets.dart';
import 'package:assetManagment/pages/pageMixin.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class AssetsDetails extends StatefulWidget {
  final AssetsModel asset;
  final String title;
  AssetsDetails({Key key, this.asset, this.title}) : super(key: key);

  @override
  _AssetsDetailsState createState() => _AssetsDetailsState();
}

class _AssetsDetailsState extends State<AssetsDetails> with PageMixin {
  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _assetStatusController =
      TextEditingController(text: "Not allocated");
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _serialNoController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _macAddressController = TextEditingController();
  TextEditingController _operatingSystemController = TextEditingController();
  TextEditingController _purchasedFromController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  TextEditingController _purchasedOnController = TextEditingController();
  TextEditingController _assetTypeController = TextEditingController();
  DateTime _date;

  @override
  void initState() {
    super.initState();
    AssetsModel asset = widget.asset;
    if (asset != null) {
      _assetStatusController.text = asset.assetStatus;
      _companyNameController.text = asset.companyName;
      _serialNoController.text = asset.serialNo;
      _colorController.text = asset.color;
      _macAddressController.text = asset.macAddress;
      _priceController.text = asset.price.toString();
      _purchasedFromController.text = asset.purchasedFrom;
      _operatingSystemController.text = asset.operatingSystem;
      _notesController.text = asset.notes;
      _date = asset.purchasedOn;
      _assetTypeController.text = asset.assetType;
    }
  }

  Future<void> openDatePicker(BuildContext context) async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (date != null) {
      this.setState(() {
        _date = date;
      });
    }
  }

  onSubmit(BuildContext currenContext) async {
    if (_formKey.currentState.validate()) {
      AssetsModel assetsModel = AssetsModel(
          assetType: _assetTypeController.text,
          assetStatus: _assetStatusController.text,
          macAddress: _macAddressController.text,
          price: double.parse(_priceController.text),
          purchasedFrom: _purchasedFromController.text,
          operatingSystem: _operatingSystemController.text,
          companyName: _companyNameController.text,
          color: _colorController.text,
          notes: _notesController.text,
          serialNo: _serialNoController.text,
          purchasedOn: _date);
      try {
        if (widget.asset != null) {
          assetsModel.id = widget.asset.id;
          await Provider.of<AssetsProvider>(context, listen: false)
              .editAssets(assetsModel);
          Navigator.of(context).pop('edited');
        } else {
          await Provider.of<AssetsProvider>(context, listen: false)
              .createAssets(assetsModel);
          Navigator.of(context).pop('added');
        }
      } on UnauthorisedException catch (uae) {
        this.onUnauthorisedError(context: context, e: uae);
      } catch (e) {
        this.onNetworkError(scafoldKey: this._scafoldKey, e: e);
      }
    }
  }

  reset() {
    // this._assetTypeIdController.clear();
    // this._assetStatusController.clear();
    // this._companyNameController.clear();
    // this._serialNoController.clear();
    // this._colorController.clear();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = Provider.of<AssetsProvider>(context).loading;
    return Scaffold(
        key: this._scafoldKey,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: loading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: LoadingIndicator(
                      color: Theme.of(context).primaryColor,
                      loadingMessage: "...Adding Asset",
                    ),
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          CustomInput(
                            icon: Icon(
                              Icons.computer,
                              color: Colors.green,
                            ),
                            placeholder: "Asset Type",
                            controller: _assetTypeController,
                          ),
                          CustomInput(
                            icon: Icon(
                              Icons.web_asset,
                              color: Colors.orange,
                            ),
                            placeholder: "Company name",
                            controller: _companyNameController,
                          ),
                          CustomInput(
                            icon: Icon(
                              Icons.confirmation_number,
                              color: Colors.yellow,
                            ),
                            placeholder: "Serial No",
                            controller: _serialNoController,
                          ),
                          CustomInput(
                              icon: Icon(
                                Icons.colorize,
                                color: Colors.green,
                              ),
                              placeholder: "Color",
                              controller: _colorController),
                          CustomInput(
                              icon: Icon(
                                Icons.web_asset,
                                color: Colors.green,
                              ),
                              placeholder: "Mac Address",
                              controller: _macAddressController),
                          CustomInput(
                              icon: Icon(
                                Icons.computer,
                                color: Colors.blue,
                              ),
                              placeholder: "Operating System",
                              controller: _operatingSystemController),
                          CustomInput(
                              icon: Icon(
                                Icons.location_city,
                                color: Colors.green,
                              ),
                              placeholder: "Purchased From",
                              controller: _purchasedFromController),
                          CustomInput(
                              icon: Icon(
                                Icons.attach_money,
                                color: Colors.red,
                              ),
                              placeholder: "Price",
                              type: TextInputType.number,
                              controller: _priceController),
                          CustomInput(
                              icon: Icon(
                                Icons.calendar_today,
                                color: Colors.yellow,
                              ),
                              readonly: true,
                              onTap: () {
                                openDatePicker(context);
                              },
                              placeholder: this._date != null
                                  ? DateFormat.yMMMd().format(this._date)
                                  : "Purchased on",
                              controller: _purchasedOnController),
                          CustomInput(
                              icon: Icon(
                                Icons.note_add,
                                color: Colors.blueGrey,
                              ),
                              placeholder: "Notes",
                              controller: _notesController),
                          Builder(
                            builder: (currentContext) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                PrimaryCustomWidthButton(
                                  width: 130,
                                  color: Colors.white,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  title: "Add Asset",
                                  icon: Icon(Icons.add, color: Colors.white),
                                  onPress: () {
                                    return this.onSubmit(currentContext);
                                  },
                                ),
                                PrimaryCustomWidthButton(
                                  width: 100,
                                  color: Colors.white,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  title: "Clear",
                                  icon: Icon(Icons.clear, color: Colors.white),
                                  onPress: () {
                                    return this.reset();
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}
