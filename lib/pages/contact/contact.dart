import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_portfolio/components/dialogs.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

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
    final breakpoints = ResponsiveBreakpoints.of(context);
    final textInputStyle = Theme.of(context).textTheme.bodySmall;
    final labelStyle = Theme.of(context).textTheme.labelMedium;
    final floatingLabelStyle = Theme.of(context)
        .textTheme
        .labelMedium
        ?.copyWith(color: Theme.of(context).colorScheme.secondary);
    final emailContactLabelStyle = Theme.of(context).textTheme.bodySmall;
    final emailContactStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        );

    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: breakpoints.largerThan(TABLET) ? 600 : 400,
          maxHeight: 500.0
        ),
        child: Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'How can I help you?',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                  textScaler: const TextScaler.linear(1.0),
                ),
                Expanded(
                  child: FormBuilder(
                    key: _fbkey,
                    child: ListView(
                      children: <Widget>[
                        FormBuilderTextField(
                          name: "name",
                          style: textInputStyle,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.min(3),
                            FormBuilderValidators.required()
                          ]),
                          decoration: InputDecoration(
                            labelText: 'Your name',
                            labelStyle: labelStyle,
                            floatingLabelStyle: floatingLabelStyle,
                          ),
                        ),
                        FormBuilderTextField(
                          name: "email",
                          style: textInputStyle,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.email(),
                            FormBuilderValidators.required()
                          ]),
                          decoration: InputDecoration(
                            labelText: 'Contact email',
                            labelStyle: labelStyle,
                            floatingLabelStyle: floatingLabelStyle,
                          ),
                        ),
                        FormBuilderTextField(
                          name: 'details',
                          style: textInputStyle,
                          maxLines: 5,
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required()]),
                          decoration: InputDecoration(
                            labelText: 'Message',
                            labelStyle: labelStyle,
                            floatingLabelStyle: floatingLabelStyle,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                // Submit button
                ElevatedButton(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Text(_isLoading ? '' : 'Submit'),
                  onPressed: () => _isLoading ? null : _handleSubmit(),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Or send me an email to: ",
                      style: emailContactLabelStyle,
                    ),
                    Text(
                      "cristian.pereyra.dev@gmail.com",
                      style: emailContactStyle,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
