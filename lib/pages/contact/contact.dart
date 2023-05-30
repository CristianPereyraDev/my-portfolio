import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_portfolio/components/dialogs.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;

  void _handleSubmit() async {
    if (_fbkey.currentState!.saveAndValidate()) {
      setState(() {
        _isLoading = true;
      });

      FirebaseFirestore.instance
          .collection('messages')
          .add(
            {
              'name': _fbkey.currentState!.value['name'],
              'email': _fbkey.currentState!.value['email'],
              'details': _fbkey.currentState!.value['details'],
            },
          )
          .then(
            (value) => {
              setState(() {
                _isLoading = false;
              }),
              _fbkey.currentState!.reset(),
              showCustomDialog(
                context,
                'Sucess',
                const Text('Your message was registered'),
              )
            },
          )
          .onError(
            (error, stackTrace) => {
              setState(() {
                _isLoading = false;
              }),
              showCustomDialog(
                context,
                'Error',
                Column(
                  children: [
                    const Text('Your message could not be registered.'),
                    RichText(
                      text: TextSpan(
                          text: 'Please contact me by ',
                          style: DefaultTextStyle.of(context).style,
                          children: const [
                            TextSpan(
                              text: 'cristian.pereyra.dev@gmail.com',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  ],
                ),
              )
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.35,
      heightFactor: .9,
      child: Column(
        children: [
          const Text(
            'Tell me what you need',
            textScaleFactor: 2.0,
          ),
          Expanded(
            child: FormBuilder(
              key: _fbkey,
              child: ListView(
                children: <Widget>[
                  FormBuilderTextField(
                    name: "name",
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.min(3),
                      FormBuilderValidators.required()
                    ]),
                    decoration: const InputDecoration(labelText: 'Your name'),
                  ),
                  FormBuilderTextField(
                    name: "email",
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.email(),
                      FormBuilderValidators.required()
                    ]),
                    decoration:
                        const InputDecoration(labelText: 'Contact email'),
                  ),
                  FormBuilderTextField(
                    name: 'details',
                    maxLines: 5,
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    decoration: const InputDecoration(labelText: 'Message'),
                  ),
                  const SizedBox(height: 16),
                  // Submit button
                  ElevatedButton.icon(
                    icon: _isLoading
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.add),
                    label: Text(_isLoading ? 'Submit' : ''),
                    onPressed: () => _isLoading ? null : _handleSubmit(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
