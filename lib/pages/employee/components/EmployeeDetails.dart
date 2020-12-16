import 'package:assetManagment/components/customInputs.dart';
import 'package:assetManagment/components/loadingIndicator.dart';
import 'package:assetManagment/components/primaryCustomWidthButton.dart';

import 'package:assetManagment/helpers/validator.dart';
import 'package:assetManagment/models/employeeAssets.dart';
import 'package:assetManagment/pages/pageMixin.dart';
import 'package:assetManagment/providers/employeeProvider.dart';
import 'package:assetManagment/services/responseHandler.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class EmployeeDetails extends StatefulWidget {
  final EmployeeAssestsModel employee;
  final String title;
  EmployeeDetails({Key key, this.employee, this.title}) : super(key: key);

  @override
  _EmployeeDetailsState createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> with PageMixin {
  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    EmployeeAssestsModel employee = widget.employee;
    if (employee != null) {
      _firstNameController.text = employee.firstname;
      _lastNameController.text = employee.lastname;
      _emailController.text = employee.email;
      _addressController.text = employee.address;
      _mobileController.text = employee.mobile;
    }
  }

  onSubmit(BuildContext currenContext) async {
    if (_formKey.currentState.validate()) {
      EmployeeAssestsModel employeeAssestsModel = EmployeeAssestsModel(
          firstname: _firstNameController.text,
          lastname: _lastNameController.text,
          email: _emailController.text,
          address: _addressController.text,
          mobile: _mobileController.text);
      try {
        if (widget.employee != null) {
          employeeAssestsModel.id = widget.employee.id;
          print(employeeAssestsModel.toJson());
          await Provider.of<EmployeeProvider>(context, listen: false)
              .editEmployee(employeeAssestsModel);
          Navigator.of(context).pop("edited");
        } else {
          await Provider.of<EmployeeProvider>(context, listen: false)
              .addEmployee(employeeAssestsModel);
          Navigator.of(context).pop("added");
        }
      } on UnauthorisedException catch (uae) {
        this.onUnauthorisedError(context: context, e: uae);
      } catch (e) {
        this.onNetworkError(scafoldKey: this._scafoldKey, e: e);
      }
    }
  }

  reset() {
    this._firstNameController.clear();
    this._lastNameController.clear();
    this._emailController.clear();
    this._addressController.clear();
    this._mobileController.clear();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = Provider.of<EmployeeProvider>(context).loading;
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
                      loadingMessage: "...Adding Employee",
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
                              Icons.person,
                              color: Colors.green,
                            ),
                            placeholder: "First name",
                            validator: TextInputValidator.requiredValidator(
                                "First name is required"),
                            controller: _firstNameController,
                          ),
                          CustomInput(
                            icon: Icon(
                              Icons.person,
                              color: Colors.green,
                            ),
                            placeholder: "Last name",
                            validator: TextInputValidator.requiredValidator(
                                "Last name is required"),
                            controller: _lastNameController,
                          ),
                          CustomInput(
                            icon: Icon(
                              Icons.email,
                              color: Colors.blue,
                            ),
                            placeholder: "Email",
                            validator: TextInputValidator.emailValidator(
                                "Enter Valid Email address"),
                            controller: _emailController,
                          ),
                          CustomInput(
                            icon: Icon(
                              Icons.home,
                              color: Colors.yellow,
                            ),
                            placeholder: "Address",
                            validator: TextInputValidator.requiredValidator(
                                "Address name is required"),
                            controller: _addressController,
                          ),
                          CustomInput(
                            icon: Icon(
                              Icons.phone_android,
                              color: Colors.red,
                            ),
                            placeholder: "Mobile",
                            type: TextInputType.numberWithOptions(),
                            validator: TextInputValidator.phoneNumberValidator(
                                "Enter valid phone number"),
                            controller: _mobileController,
                          ),
                          Builder(
                            builder: (currentContext) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                PrimaryCustomWidthButton(
                                  width: 180,
                                  color: Colors.white,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  title: "Add Employee",
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
