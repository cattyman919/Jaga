import 'package:flutter/material.dart';
import 'package:frontend/models/vehicleModel.model.dart';
import 'package:frontend/ui/common/app_colors.dart';
import 'package:frontend/ui/common/ui_helpers.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'new_car_dialog_model.dart';

const double _graphicSize = 60;

class NewCarDialog extends StackedView<NewCarDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const NewCarDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NewCarDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                viewModel.isBusy
                    ? loadingSpinner()
                    : Center(
                        child: Column(children: [
                          Image.network(
                            viewModel.selectedVehicleModel
                                .image_path, // Replace with your car image URL.
                            width:
                                200, // Width of the image, you might want to adjust this.
                            height: 100, // Height of the image.
                            fit: BoxFit
                                .cover, // Fill the box without distorting the image.
                          ),
                          verticalSpaceMedium,
                          DropdownMenu<String>(
                            controller: viewModel.vehicleModelOptions,
                            onSelected: viewModel.setVehicleModel,
                            initialSelection:
                                viewModel.vehicleModels[0].model_name,
                            textStyle: const TextStyle(color: Colors.white),
                            menuStyle: MenuStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.grey[900]!),
                            ),
                            inputDecorationTheme: const InputDecorationTheme(
                              filled: true,
                              floatingLabelStyle:
                                  TextStyle(color: Colors.white),
                              border: InputBorder.none,
                              fillColor: Color.fromARGB(255, 50, 45, 45),
                            ),
                            dropdownMenuEntries: viewModel.vehicleModels
                                .map<DropdownMenuEntry<String>>((e) {
                              return DropdownMenuEntry<String>(
                                  value: e.model_name,
                                  label: e.model_name,
                                  style: MenuItemButton.styleFrom(
                                    backgroundColor: Colors.grey[900],
                                    foregroundColor: Colors.white,
                                  ));
                            }).toList(),
                          ),
                        ]),
                      ),
                verticalSpaceMedium,
                const Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                verticalSpaceSmall,
                TextFormField(
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: viewModel.dateTimeController,
                  decoration: const InputDecoration(
                      disabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                ),
                verticalSpaceSmall,
                ElevatedButton(
                    onPressed: () {
                      _selectDate(context, viewModel);
                    },
                    child: const Text('Select Date')),
              ],
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () {
                viewModel.submitCreateNewCars(request.data);
                completer(DialogResponse(confirmed: true));
              },
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _selectDate(
      BuildContext context, NewCarDialogModel viewModel) async {
    viewModel.dateTimeController.text =
        DateFormat.yMd().format(viewModel.selectedDate);

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: viewModel.selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (picked != null) {
      viewModel.selectedDate = picked;
      viewModel.dateTimeController.text =
          DateFormat.yMd().format(viewModel.selectedDate);
    }
  }

  Widget loadingSpinner() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsetsDirectional.only(top: 30),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 64,
                height: 64,
                child: CircularProgressIndicator(
                  color: Colors.grey,
                  strokeWidth: 3,
                )),
            Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Fetching data...",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                )),
          ],
        ));
  }

  @override
  void onViewModelReady(NewCarDialogModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  NewCarDialogModel viewModelBuilder(BuildContext context) =>
      NewCarDialogModel();
}
