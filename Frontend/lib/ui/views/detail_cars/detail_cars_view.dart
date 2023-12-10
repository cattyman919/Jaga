import 'package:flutter/material.dart';
import 'package:frontend/models/service.model.dart';
import 'package:frontend/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'detail_cars_viewmodel.dart';

class DetailCarsView extends StackedView<DetailCarsViewModel> {
  final int idVehicle;

  const DetailCarsView({Key? key, required this.idVehicle}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DetailCarsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            viewModel.isBusy
                ? loadingSpinner()
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          viewModel.vehicle.vehicleModel
                              .image_path, // Replace with your car image URL.
                          width:
                              200, // Width of the image, you might want to adjust this.
                          height: 100, // Height of the image.
                          fit: BoxFit
                              .cover, // Fill the box without distorting the image.
                        ),
                        Text(
                          viewModel.vehicle.vehicleModel.model_name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black, // Text color.
                            fontWeight: FontWeight.bold, // Font weight.
                            fontSize: 24.0, // Font size.
                          ),
                        )
                      ],
                    ),
                  ),
            verticalSpaceMedium,
            Text(
              "Overdue Services",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            overdueServices(viewModel),
            verticalSpaceMedium,
            Text("Upcoming Services",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Expanded(child: upcomingServices(viewModel))
            // Expanded(child: overdueServices(viewModel))
          ],
        ),
      ),
    );
  }

  Widget overdueServices(DetailCarsViewModel viewModel) {
    List<ServiceItem?> overdueServices =
        viewModel.services.where((e) => e.type == ServiceType.overdue).toList();
    if (overdueServices.isEmpty) {
      return Center(
        child: Text("There is no overdue services"),
      );
    }
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: overdueServices.length,
        itemBuilder: (context, index) {
          final overdue = overdueServices[index];
          return Card(
            elevation: 2.0, // Adds a subtle shadow.
            margin: const EdgeInsets.symmetric(
                vertical: 10), // Spacing around the card.

            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0), // Padding inside the container.

                child: ListTile(
                  title: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Use the minimum space that the child widgets need.
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Center the text horizontally.
                      children: [
                        // Spacing between image and text.
                        Text(
                          overdue!.name,
                          style: const TextStyle(
                            color: Colors.black, // Text color.
                            fontWeight: FontWeight.bold, // Font weight.
                            fontSize: 24.0, // Font size.
                          ),
                        ),
                        verticalSpaceSmall,
                        Text(
                          overdue.nextServiceAt,
                          style: TextStyle(
                            color: Colors.grey[600], // Subtitle text color.
                          ),
                        ),
                      ]),
                )),
          );
        });
  }

  Widget upcomingServices(DetailCarsViewModel viewModel) {
    List<ServiceItem?> upcomingServices = viewModel.services
        .where((e) => e.type == ServiceType.upcoming)
        .toList();
    if (upcomingServices.isEmpty) {
      return Center(
        child: Text("There is no overdue services"),
      );
    }
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: upcomingServices.length,
        itemBuilder: (context, index) {
          final overdue = upcomingServices[index];
          return Card(
            elevation: 2.0, // Adds a subtle shadow.
            margin: const EdgeInsets.symmetric(
                vertical: 10), // Spacing around the card.

            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0), // Padding inside the container.

                child: ListTile(
                  title: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Use the minimum space that the child widgets need.
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Center the text horizontally.
                      children: [
                        // Spacing between image and text.
                        Text(
                          overdue!.name,
                          style: const TextStyle(
                            color: Colors.black, // Text color.
                            fontWeight: FontWeight.bold, // Font weight.
                            fontSize: 24.0, // Font size.
                          ),
                        ),
                        verticalSpaceSmall,
                        Text(
                          overdue.nextServiceAt,
                          style: TextStyle(
                            color: Colors.grey[600], // Subtitle text color.
                          ),
                        ),
                      ]),
                )),
          );
        });
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
  void onViewModelReady(DetailCarsViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  DetailCarsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DetailCarsViewModel(idVehicle);
}
