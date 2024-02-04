// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String EnvironmentNameValueKey = 'environmentName';
const String EnvironmentColorValueKey = 'environmentColor';
const String EnvironmentIconValueKey = 'environmentIcon';

final Map<String, TextEditingController>
    _AddEnvironmentViewTextEditingControllers = {};

final Map<String, FocusNode> _AddEnvironmentViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _AddEnvironmentViewTextValidations = {
  EnvironmentNameValueKey: null,
  EnvironmentColorValueKey: null,
  EnvironmentIconValueKey: null,
};

mixin $AddEnvironmentView {
  TextEditingController get environmentNameController =>
      _getFormTextEditingController(EnvironmentNameValueKey);
  TextEditingController get environmentColorController =>
      _getFormTextEditingController(EnvironmentColorValueKey);
  TextEditingController get environmentIconController =>
      _getFormTextEditingController(EnvironmentIconValueKey);

  FocusNode get environmentNameFocusNode =>
      _getFormFocusNode(EnvironmentNameValueKey);
  FocusNode get environmentColorFocusNode =>
      _getFormFocusNode(EnvironmentColorValueKey);
  FocusNode get environmentIconFocusNode =>
      _getFormFocusNode(EnvironmentIconValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_AddEnvironmentViewTextEditingControllers.containsKey(key)) {
      return _AddEnvironmentViewTextEditingControllers[key]!;
    }

    _AddEnvironmentViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AddEnvironmentViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AddEnvironmentViewFocusNodes.containsKey(key)) {
      return _AddEnvironmentViewFocusNodes[key]!;
    }
    _AddEnvironmentViewFocusNodes[key] = FocusNode();
    return _AddEnvironmentViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    environmentNameController.addListener(() => _updateFormData(model));
    environmentColorController.addListener(() => _updateFormData(model));
    environmentIconController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    environmentNameController.addListener(() => _updateFormData(model));
    environmentColorController.addListener(() => _updateFormData(model));
    environmentIconController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          EnvironmentNameValueKey: environmentNameController.text,
          EnvironmentColorValueKey: environmentColorController.text,
          EnvironmentIconValueKey: environmentIconController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _AddEnvironmentViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AddEnvironmentViewFocusNodes.values) {
      focusNode.dispose();
    }

    _AddEnvironmentViewTextEditingControllers.clear();
    _AddEnvironmentViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get environmentNameValue =>
      this.formValueMap[EnvironmentNameValueKey] as String?;
  String? get environmentColorValue =>
      this.formValueMap[EnvironmentColorValueKey] as String?;
  String? get environmentIconValue =>
      this.formValueMap[EnvironmentIconValueKey] as String?;

  set environmentNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EnvironmentNameValueKey: value}),
    );

    if (_AddEnvironmentViewTextEditingControllers.containsKey(
        EnvironmentNameValueKey)) {
      _AddEnvironmentViewTextEditingControllers[EnvironmentNameValueKey]?.text =
          value ?? '';
    }
  }

  set environmentColorValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EnvironmentColorValueKey: value}),
    );

    if (_AddEnvironmentViewTextEditingControllers.containsKey(
        EnvironmentColorValueKey)) {
      _AddEnvironmentViewTextEditingControllers[EnvironmentColorValueKey]
          ?.text = value ?? '';
    }
  }

  set environmentIconValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EnvironmentIconValueKey: value}),
    );

    if (_AddEnvironmentViewTextEditingControllers.containsKey(
        EnvironmentIconValueKey)) {
      _AddEnvironmentViewTextEditingControllers[EnvironmentIconValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasEnvironmentName =>
      this.formValueMap.containsKey(EnvironmentNameValueKey) &&
      (environmentNameValue?.isNotEmpty ?? false);
  bool get hasEnvironmentColor =>
      this.formValueMap.containsKey(EnvironmentColorValueKey) &&
      (environmentColorValue?.isNotEmpty ?? false);
  bool get hasEnvironmentIcon =>
      this.formValueMap.containsKey(EnvironmentIconValueKey) &&
      (environmentIconValue?.isNotEmpty ?? false);

  bool get hasEnvironmentNameValidationMessage =>
      this.fieldsValidationMessages[EnvironmentNameValueKey]?.isNotEmpty ??
      false;
  bool get hasEnvironmentColorValidationMessage =>
      this.fieldsValidationMessages[EnvironmentColorValueKey]?.isNotEmpty ??
      false;
  bool get hasEnvironmentIconValidationMessage =>
      this.fieldsValidationMessages[EnvironmentIconValueKey]?.isNotEmpty ??
      false;

  String? get environmentNameValidationMessage =>
      this.fieldsValidationMessages[EnvironmentNameValueKey];
  String? get environmentColorValidationMessage =>
      this.fieldsValidationMessages[EnvironmentColorValueKey];
  String? get environmentIconValidationMessage =>
      this.fieldsValidationMessages[EnvironmentIconValueKey];
}

extension Methods on FormStateHelper {
  setEnvironmentNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EnvironmentNameValueKey] =
          validationMessage;
  setEnvironmentColorValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EnvironmentColorValueKey] =
          validationMessage;
  setEnvironmentIconValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EnvironmentIconValueKey] =
          validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    environmentNameValue = '';
    environmentColorValue = '';
    environmentIconValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      EnvironmentNameValueKey: getValidationMessage(EnvironmentNameValueKey),
      EnvironmentColorValueKey: getValidationMessage(EnvironmentColorValueKey),
      EnvironmentIconValueKey: getValidationMessage(EnvironmentIconValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _AddEnvironmentViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _AddEnvironmentViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      EnvironmentNameValueKey: getValidationMessage(EnvironmentNameValueKey),
      EnvironmentColorValueKey: getValidationMessage(EnvironmentColorValueKey),
      EnvironmentIconValueKey: getValidationMessage(EnvironmentIconValueKey),
    });
