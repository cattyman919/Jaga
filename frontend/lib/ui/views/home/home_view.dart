import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(
    BuildContext context,
  ) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onViewModelReady: (viewModel) => viewModel.init(),
        builder: (context, viewModel, child) => WillPopScope(
              onWillPop: viewModel.onBackPressed,
              child: Scaffold(
                body: PageView(
                  controller: viewModel.pageViewController,
                  children: viewModel.isBusy
                      ? [
                          Container(
                            alignment: Alignment.center,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 64,
                                    height: 64,
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                      strokeWidth: 3,
                                    )),
                                Padding(
                                    child: Text("Connecting to user"),
                                    padding: EdgeInsets.only(top: 20)),
                              ],
                            ),
                          )
                        ]
                      : [
                          homeDestination(viewModel),
                          bluetoothDestination(viewModel),
                          profileDestination(viewModel),
                          Text("Nothing")
                        ],
                  onPageChanged: (value) {
                    viewModel.setIndex(value);
                    viewModel.onPageChanged(value);
                  },
                ),
                bottomNavigationBar: viewModel.isBusy
                    ? SizedBox.shrink()
                    : NavigationBar(
                        indicatorColor: Colors.amber,
                        onDestinationSelected: (value) {
                          viewModel.setIndex(value);
                          viewModel.onPageChanged(value);
                          viewModel.pageViewController.animateToPage(value,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeInOut);
                        },
                        selectedIndex: viewModel.currentIndex,
                        destinations: const [
                            NavigationDestination(
                              label: "Home",
                              selectedIcon: Icon(Icons.home),
                              icon: Icon(Icons.home_outlined),
                            ),
                            NavigationDestination(
                              label: "ESP32",
                              icon: Icon(Icons.bluetooth),
                            ),
                            NavigationDestination(
                              label: "Profile",
                              icon: Icon(Icons.account_circle),
                            ),
                            NavigationDestination(
                              label: "Notification",
                              icon:
                                  Badge(child: Icon(Icons.notifications_sharp)),
                            ),
                          ]),
              ),
            ));
  }

  Widget homeDestination(HomeViewModel viewModel) {
    return ListView.builder(
        itemCount: viewModel.carModelServices.length,
        itemBuilder: (context, index) {
          final carModel = viewModel.carModelServices[index];
          return Card(
            elevation: 2.0, // Adds a subtle shadow.
            margin: EdgeInsets.all(8.0), // Spacing around the card.

            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0), // Padding inside the container.

              child: Column(
                  mainAxisSize: MainAxisSize
                      .min, // Use the minimum space that the child widgets need.
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Center the text horizontally.
                  children: [
                    Image.network(
                      viewModel.vehicleModels[0]
                          .image_path, // Replace with your car image URL.
                      width:
                          100, // Width of the image, you might want to adjust this.
                      height: 60, // Height of the image.
                      fit: BoxFit
                          .cover, // Fill the box without distorting the image.
                    ),
                    SizedBox(height: 10), // Spacing between image and text.
                    Text(
                      carModel.carName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black, // Text color.
                        fontWeight: FontWeight.bold, // Font weight.
                        fontSize: 24.0, // Font size.
                      ),
                    ),
                    Text(
                      'Next Service in the next ${carModel.kmDistance} Km',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600], // Subtitle text color.
                        fontSize: 18.0, // Subtitle font size.
                      ),
                    ),
                  ]),
            ),
          );
        });
  }

  Widget bluetoothDestination(HomeViewModel viewModel) {
    // return const Text("Bluetooth");
    return viewModel.busy(viewModel.scanningBluetooth)
        ? Container(
            alignment: Alignment.center,
            child: Text("Scanning for devices"),
          )
        : Container(
            padding: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Text("Bluetooth Devices",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ListView.builder(
                    itemCount: viewModel.deviceList.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final device = viewModel.deviceList[index];

                      return ListTile(
                          leading: Icon(Icons.bluetooth, color: Colors.blue),
                          title: Text(
                            device.device.name ?? 'null',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            device.device.type.stringValue,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          trailing: ElevatedButton(
                              onPressed: () => {},
                              child: Text('Connect'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              )));
                    }),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        onPressed: viewModel.bluetoothScan,
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.amber)),
                        child: const Text(
                          'Scan Bluetooth Devices',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          );
  }

  Widget profileDestination(HomeViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              viewModel.user.username!,
              textAlign: TextAlign.center,
            ),
            Text(
              viewModel.user.fullName ?? "null",
              textAlign: TextAlign.center,
            ),
            Text(
              viewModel.user.email!,
              textAlign: TextAlign.center,
            ),
            FractionallySizedBox(
              widthFactor: 0.4,
              child: ElevatedButton(
                  onPressed: viewModel.logOutUser,
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 212, 50, 39))),
                  child: !viewModel.isBusy
                      ? const Text(
                          'Log out',
                          style: TextStyle(color: Colors.white),
                        )
                      : const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ))),
            ),
          ]),
    );
  }
}
