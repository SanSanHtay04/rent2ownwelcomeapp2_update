import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_number/phone_number.dart';
import 'clearable_text_form_field.dart';

class PhoneTextFormField extends StatefulWidget {
  const PhoneTextFormField({
    super.key,
    required this.labelText,
    this.initialValue = '',
    this.prefixIcon,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.required = false,
  });

  final String labelText;
  final String? initialValue;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final bool required;

  @override
  State<PhoneTextFormField> createState() => _PhoneTextFormFieldState();
}

class _PhoneTextFormFieldState extends State<PhoneTextFormField> {
  bool _validPhoneNumber = true;
  late final _phoneUtil = PhoneNumberUtil();

  Future<void> _validatePhoneNumber(String text) async {
    final validPhone = await _phoneUtil.validate(text, regionCode: 'MM');
    setState(() {
      _validPhoneNumber = validPhone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClearableTextFormField(
      keyboardType: TextInputType.phone,
      labelText: widget.labelText,
      initialValue: widget.initialValue,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      maxLength: 11,
      prefixIcon: widget.prefixIcon ?? const Icon(Icons.phone_rounded),
      hideLabel : true,
      decoration: const InputDecoration(
        counterText: '',
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (text) {

        if (widget.required && !_validPhoneNumber ) {
          return 'Invalid Phone Number';
        }
        return widget.validator?.call(text);
      },
      required: widget.required,
      onSaved: widget.onSaved,
      onChanged: (text) async {
        try {
          await _validatePhoneNumber(text);
        } catch (_) {
        } finally {
          widget.onChanged?.call(text);
        }
      },
    );
  }
}
