import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/dialogs/custom_error_dialog.dart';

import 'user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String username,
    File image,
    String password,
    bool login,
  ) onSubmit;

  final bool isLoading;

  AuthForm(
    this.onSubmit,
    this.isLoading,
  );

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  GlobalKey<FormState> _formKey;
  FocusNode _usernameFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _confirmPasswordFocusNode;
  TextEditingController _passwordController;
  var _login = true;

  String _email = '';
  String _username = '';
  String _password = '';
  File _userImageFile;

  void _pickImage(
    File pickedImage,
  ) {
    _userImageFile = pickedImage;
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      if (!_login && _userImageFile == null) {
        showDialog(
          context: context,
          builder: (context) => CustomErrorDialog('Please provide an image!'),
        );
        return;
      }
      _formKey.currentState.save();
      widget.onSubmit(
        _email.trim(),
        _username.trim(),
        _userImageFile,
        _password.trim(),
        _login,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_login)
                    UserImagePicker(
                      _pickImage,
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      if (_login) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      } else {
                        FocusScope.of(context).requestFocus(_usernameFocusNode);
                      }
                    },
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  if (!_login)
                    TextFormField(
                      key: ValueKey('username'),
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      textInputAction: TextInputAction.next,
                      focusNode: _usernameFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a username.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    focusNode: _passwordFocusNode,
                    validator: (value) {
                      if (value.isEmpty || value.length < 8) {
                        return 'Your password must be 8 characters long.';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      if (_login) {
                        _submit();
                      } else {
                        FocusScope.of(context)
                            .requestFocus(_confirmPasswordFocusNode);
                      }
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  if (!_login)
                    TextFormField(
                      key: ValueKey('confirmPassword'),
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      focusNode: _confirmPasswordFocusNode,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match.';
                        }
                        if (value.isEmpty || value.length < 8) {
                          return 'Your password must be 8 characters long.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        _submit();
                      },
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      child: Text(
                        _login ? 'Log in' : 'Sign up',
                      ),
                      onPressed: _submit,
                      style: ButtonStyle(),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      child: Text(
                        _login
                            ? 'Create a new account'
                            : 'I already have an account',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _login = !_login;
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
