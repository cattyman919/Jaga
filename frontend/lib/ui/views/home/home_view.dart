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
        builder: (context, viewModel, child) => Scaffold(
              body: getViewForIndex(viewModel.currentIndex, viewModel),
              bottomNavigationBar: NavigationBar(
                  indicatorColor: Colors.amber,
                  onDestinationSelected: viewModel.setIndex,
                  selectedIndex: viewModel.currentIndex,
                  backgroundColor: Colors.grey[800],
                  destinations: const [
                    NavigationDestination(
                      label: "Home",
                      selectedIcon: Icon(Icons.home),
                      icon: Icon(Icons.home_outlined),
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
            ));
  }

  Widget getViewForIndex(int index, HomeViewModel viewModel) {
    switch (index) {
      case 0:
        return HomeDestination(viewModel);
      case 1:
        return Text("Profile");
      default:
        return Text("Nothing");
    }
  }

  Widget HomeDestination(HomeViewModel viewModel) {
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
}
