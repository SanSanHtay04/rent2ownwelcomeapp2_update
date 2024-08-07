import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClearableTextFormField extends StatefulWidget {
  const ClearableTextFormField({
    super.key,
    this.controller,
    this.decoration,
    this.label,
    this.hideLabel= false,
    this.labelText,
    this.errorText,
    this.initialValue,
    this.prefixIcon,
    this.onChanged,
    this.onSaved,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.inputFormatters,
    this.validator,
    this.autovalidateMode,
    this.minLines,
    this.maxLines,
    this.expands = false,
    this.required = false,
    this.readOnly = false,
    this.onTap,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final InputDecoration? decoration;
  final Widget? label;
  final bool hideLabel;
  final String? labelText;
  final String? errorText;
  final String? initialValue;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final int? minLines;
  final int? maxLines;
  final bool expands;
  final bool required;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  State<ClearableTextFormField> createState() => _ClearableTextFormFieldState();
}

class _ClearableTextFormFieldState extends State<ClearableTextFormField> {
  late final _controller = widget.controller ?? TextEditingController();
  bool _clearable = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      _controller.text = widget.initialValue!;
    }

    _controller.addListener(() {
      setState(() {
        _clearable = _controller.text.isNotEmpty;
      });
      widget.onChanged?.call(_controller.text);
    });
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      // _controller.text = widget.initialValue ?? '';
      if (widget.initialValue != null &&
          // widget.initialValue!.isNotEmpty &&
          widget.initialValue != _controller.text) {
        _controller.text = widget.initialValue!;
      }
      _errorText = widget.errorText;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final decoration = widget.decoration ?? const InputDecoration();
    return TextFormField(
      controller: _controller,
      readOnly: widget.readOnly,
      maxLength: widget.maxLength,
      textAlign: widget.textAlign,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      autovalidateMode: widget.autovalidateMode,
      enabled: widget.enabled,
      validator: (text) {
        if (widget.required && (text == null || text.isEmpty)) {
          return "${widget.labelText} is required.";
        }
        return widget.validator?.call(text);
      },
      onTap: widget.onTap,
      onSaved: widget.onSaved,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      expands: widget.expands,
      decoration: decoration.copyWith(
        label:  widget.hideLabel? null: Text.rich(
          TextSpan(text: widget.labelText, children: [
            if (widget.required)
              const TextSpan(
                style: TextStyle(color: Colors.red),
                text: ' *'
              ),
          ]),
        ),
        hintText: '${widget.labelText}',
        counterText: '',
        prefixIcon: widget.prefixIcon,
        errorText: _errorText,
        suffixIcon: _clearable
            ? IconButton(
                onPressed: () {
                  _controller.text = '';
                },
                icon: const Icon(Icons.clear_rounded),
              )
            : null,
      ),
    );
  }
}
