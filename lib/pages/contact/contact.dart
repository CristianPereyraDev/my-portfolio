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
              'category': _fbkey.currentState!.value['category']
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
                'Mensaje registrado correctamente',
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
                'Hubo un error al registrar el mensaje',
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
            'Contact Form',
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
                    decoration: const InputDecoration(labelText: 'contactName'),
                  ),
                  FormBuilderTextField(
                    name: "email",
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.email(),
                      FormBuilderValidators.required()
                    ]),
                    decoration:
                        const InputDecoration(labelText: 'contactEmail'),
                  ),
                  FormBuilderFilterChip(
                    decoration: const InputDecoration(
                        labelText: 'contactQuery',
                        labelStyle: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.normal)),
                    name: "category",
                    options: const [
                      FormBuilderChipOption<String>(
                        value: "web",
                        child: Text('web'),
                      ),
                    ],
                  ),
                  FormBuilderTextField(
                    name: 'details',
                    maxLines: 5,
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    decoration:
                        const InputDecoration(labelText: 'contactMessage'),
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
