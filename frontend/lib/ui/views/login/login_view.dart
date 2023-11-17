import 'package:flutter/material.dart';
import 'package:frontend/ui/views/login/login_view.form.dart';
import 'package:frontend/ui/views/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(
    fields: [FormTextField(name: "email"), FormTextField(name: "password")])
class LoginView extends StackedView<LoginViewModel> with $LoginView {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Login",
              textAlign: TextAlign.center,
              textScaleFactor: 3,
            ),

            SizedBox(height: 24.0),

            // Email TextField
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'Email',
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            // Password TextField
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                // Perform your validation logic here
              },
              decoration: const InputDecoration(
                hintText: 'Password',
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),

            SizedBox(height: 24.0),
            // Login Button
            ElevatedButton(
              onPressed: viewModel.loginUser,
              child: const Text(
                'Log In',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(onPressed: viewModel.goToSignUp, child: Text("Sign up"))
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(LoginViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}
