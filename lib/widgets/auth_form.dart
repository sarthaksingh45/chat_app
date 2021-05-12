import 'dart:io';

import 'package:chat_app/widgets/image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function submitFn;
  final bool _isLoading;

  AuthForm(this.submitFn, this._isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isLogin = true;
  final _formkey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userUserName = '';
  String _userPassword = '';
  File _image;

  void submitImage(File image) {
    setState(() {
      _image = image;
    });
  }

  void trySubmit() {
    final isValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_image == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please add an image!'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (isValid) {
      _formkey.currentState.save();
    }
    widget.submitFn(
        _userEmail, _userUserName, _userPassword, _image, _isLogin, context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (!_isLogin) ImagePickerWid(submitImage),
                    TextFormField(
                      key: ValueKey('Email'),
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a Valid Email.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('userName'),
                        decoration: InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Please enter a Valid Username.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userUserName = value;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('Pass'),
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Please enter a Valid Password.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPassword = value;
                      },
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    widget._isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: trySubmit,
                            child: _isLogin ? Text('Login') : Text('SignUP'),
                          ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: _isLogin
                          ? Text('SignUp Instead')
                          : Text(
                              'Login instead',
                              textAlign: TextAlign.center,
                            ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
