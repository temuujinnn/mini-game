import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyInput extends StatefulWidget {
  const MyInput({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onSaved,
    this.onFieldTap,
    this.focusNode,
    this.autofocus = false,
    this.enabled,
    this.readOnly = false,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.minLenght,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.initialValue,
  });
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String?)? onSaved;
  final void Function()? onFieldTap;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool? enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final int? minLenght;
  final TextCapitalization textCapitalization;
  final String? initialValue;

  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder(),
        ),
        inputFormatters: const [],
        textCapitalization: widget.textCapitalization,
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        onEditingComplete: widget.onEditingComplete,
        onSaved: widget.onSaved,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        validator: widget.validator,
        initialValue: widget.initialValue,
      ),
    );
  }
}
