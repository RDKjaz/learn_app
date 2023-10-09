import 'package:app_learn/ui/theme/app_button_style.dart';
import 'package:app_learn/ui/theme/app_colors.dart';
import 'package:app_learn/ui/widgets/auth/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Экран авторизации
class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход'),
      ),
      body: ListView(children: [_FormWidget()]),
    );
  }
}

class _FormWidget extends StatefulWidget {
  _FormWidget({super.key});

  @override
  State<_FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<_FormWidget> {
  var passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthViewModel>();
    const textStyle = TextStyle(
      fontSize: 16,
      color: Color(0xFF212529),
    );

    const textFieldInputDecoration = InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        isCollapsed: true,
        errorText: null);

    var passwordFieldInputDecoration = InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      isCollapsed: true,
      errorText: null,
      suffixIcon: IconButton(
        icon: Icon(
          passwordVisible ? Icons.visibility : Icons.visibility_off,
          color: AppColors.mainDarkBlue,
        ),
        onPressed: () {
          setState(() {
            passwordVisible = !passwordVisible;
          });
        },
      ),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const _ErrorMessageWidget(),
        const Text('Логин', style: textStyle),
        const SizedBox(height: 5),
        TextField(
          controller: model.loginTextController,
          decoration: textFieldInputDecoration,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 20),
        const Text('Пароль', style: textStyle),
        const SizedBox(height: 5),
        TextField(
          controller: model.passwordTextController,
          decoration: passwordFieldInputDecoration,
          obscureText: !passwordVisible,
          cursorColor: Colors.grey,
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _AuthButtonWidget(),
            const SizedBox(width: 30),
            // TextButton(
            //   onPressed: () {},
            //   style: AppButtonStyle.linkButton,
            //   child: const Text("Регистрация"),
            // ),
          ],
        )
      ]),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthViewModel>();
    final onPressed = model.canStartAuth ? () => model.auth(context) : null;

    final childButton = model.isAuthProgress
        ? const SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Text('Войти');

    return ElevatedButton(
      onPressed: onPressed,
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(AppColors.mainDarkBlue),
        foregroundColor: MaterialStatePropertyAll(Colors.white),
        textStyle: MaterialStatePropertyAll(
          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 15, vertical: 8)),
      ),
      child: childButton,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.watch<AuthViewModel>().errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 17,
        ),
      ),
    );
  }
}
