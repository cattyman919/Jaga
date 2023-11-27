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
          return ListTile(
            title: Text(carModel.carName),
            subtitle: Text(
                'Next Services in next ${carModel.kmDistance} Km or ${carModel.timeDuration} months'),
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
            const Text(
              "username",
              textAlign: TextAlign.center,
            ),
            const Text(
              "Full Name",
              textAlign: TextAlign.center,
            ),
            const Text(
              "email",
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
