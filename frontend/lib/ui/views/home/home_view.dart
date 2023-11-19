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
        builder: (context, viewModel, child) => WillPopScope(
              onWillPop: viewModel.onBackPressed,
              child: Scaffold(
                body: getViewForIndex(viewModel.currentIndex, viewModel),
                bottomNavigationBar: NavigationBar(
                    indicatorColor: Colors.amber,
                    onDestinationSelected: viewModel.setIndex,
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
                        icon: Badge(child: Icon(Icons.notifications_sharp)),
                      ),
                    ]),
              ),
            ));
  }

  Widget getViewForIndex(int index, HomeViewModel viewModel) {
    switch (index) {
      case 0:
        return homeDestination(viewModel);
      case 1:
        return bluetoothDestination(viewModel);
      case 2:
        return profileDestination(viewModel);
      default:
        return const Text("Nothing");
    }
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
    viewModel.bluetoothInit();
    return const Text("Bluetooth");
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
