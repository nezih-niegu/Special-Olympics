import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../providers/auth_provider.dart';

class EditUserPasswordScreen extends StatefulWidget{
    static const routeName = '/edit-user-password';

    @override
    _EditUserPasswordScreenState createState(){
        return _EditUserPasswordScreenState();
    }
}

class _EditUserPasswordScreenState extends State<EditUserPasswordScreen>{
    final _updateUserPasswordForm = GlobalKey<FormState>();
    final _newPasswordFocusNode = FocusNode();
    final _newPasswordConfirmationFocusNode = FocusNode();
    var _userUpdatePasswordRequest = UserUpdatePasswordRequest(
        password: '',
        newPassword: '',
        newPasswordConfirmation: ''
    );

    @override
    void dispose(){
        _newPasswordFocusNode.dispose();
        _newPasswordConfirmationFocusNode.dispose();
        super.dispose();
    }

    Future<void> updateUserPassword() async{
        if(!_updateUserPasswordForm.currentState.validate()){
            return;
        }

        _updateUserPasswordForm.currentState.save();

        try{
            await Provider.of<UserProvider>(
                context,
                listen: false
            ).updatePassword(Provider.of<AuthProvider>(
                context,
                listen: false
            ).token, _userUpdatePasswordRequest);

            Navigator.of(context).pop();
        }catch(error){
            await showDialog(
                context: context,
                builder: (context){
                    return AlertDialog(
                        title: Text(
                            'Error',
                            style: TextStyle(color: Colors.black)
                        ),
                        content: Text(error.toString()),
                        actions: [
                            FlatButton(
                                child: Text('Ok'),
                                onPressed: (){
                                    Navigator.of(context).pop();
                                }
                            )
                        ]
                    );
                }
            );
        }
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                title: Text('Cambiar contraseña'),
                actions: [
                    IconButton(
                        icon: Icon(Icons.save),
                        onPressed: updateUserPassword
                    )
                ]
            ),
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: _updateUserPasswordForm,
                    child: SingleChildScrollView(child: Column(children: [
                        TextFormField(
                            initialValue: _userUpdatePasswordRequest.password,
                            decoration: InputDecoration(labelText: 'Contraseña actual'),
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_newPasswordFocusNode);
                            },
                            validator: (password){
                                if(password.isEmpty){
                                    return 'La contraseña actual es requerida';
                                }

                                return null;
                            },
                            onSaved: (password){
                                _userUpdatePasswordRequest.password = password;
                            }
                        ),
                        TextFormField(
                            initialValue: _userUpdatePasswordRequest.newPassword,
                            decoration: InputDecoration(labelText: 'Nueva contraseña'),
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            focusNode: _newPasswordFocusNode,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_newPasswordConfirmationFocusNode);
                            },
                            validator: (newPassword){
                                if(newPassword.isEmpty){
                                    return 'La nueva contraseña es requerida';
                                }

                                return null;
                            },
                            onSaved: (newPassword){
                                _userUpdatePasswordRequest.newPassword = newPassword;
                            }
                        ),
                        TextFormField(
                            initialValue: _userUpdatePasswordRequest.newPasswordConfirmation,
                            decoration: InputDecoration(labelText: 'Confirmación de nueva contraseña'),
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            focusNode: _newPasswordConfirmationFocusNode,
                            onFieldSubmitted: (_){
                                updateUserPassword();
                            },
                            validator: (newPasswordConfirmation){
                                if(newPasswordConfirmation.isEmpty){
                                    return 'La confirmación de la nueva contraseña es requerida';
                                }

                                return null;
                            },
                            onSaved: (newPasswordConfirmation){
                                _userUpdatePasswordRequest.newPasswordConfirmation = newPasswordConfirmation;
                            }
                        )
                    ]))
                )
            )
        );
    }
}