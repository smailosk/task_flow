// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String ProjectNameValueKey = 'projectName';
const String ProjectColorValueKey = 'projectColor';

final Map<String, TextEditingController> _AddProjectViewTextEditingControllers =
    {};

final Map<String, FocusNode> _AddProjectViewFocusNodes = {};

final Map<String, String? Function(String?)?> _AddProjectViewTextValidations = {
  ProjectNameValueKey: null,
  ProjectColorValueKey: null,
};

mixin $AddProjectView {
  TextEditingController get projectNameController =>
      _getFormTextEditingController(ProjectNameValueKey);
  TextEditingController get projectColorController =>
      _getFormTextEditingController(ProjectColorValueKey);

  FocusNode get projectNameFocusNode => _getFormFocusNode(ProjectNameValueKey);
  FocusNode get projectColorFocusNode =>
      _getFormFocusNode(ProjectColorValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_AddProjectViewTextEditingControllers.containsKey(key)) {
      return _AddProjectViewTextEditingControllers[key]!;
    }

    _AddProjectViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AddProjectViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AddProjectViewFocusNodes.containsKey(key)) {
      return _AddProjectViewFocusNodes[key]!;
    }
    _AddProjectViewFocusNodes[key] = FocusNode();
    return _AddProjectViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    projectNameController.addListener(() => _updateFormData(model));
    projectColorController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    projectNameController.addListener(() => _updateFormData(model));
    projectColorController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          ProjectNameValueKey: projectNameController.text,
          ProjectColorValueKey: projectColorController.text,
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

    for (var controller in _AddProjectViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AddProjectViewFocusNodes.values) {
      focusNode.dispose();
    }

    _AddProjectViewTextEditingControllers.clear();
    _AddProjectViewFocusNodes.clear();
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

  String? get projectNameValue =>
      this.formValueMap[ProjectNameValueKey] as String?;
  String? get projectColorValue =>
      this.formValueMap[ProjectColorValueKey] as String?;

  set projectNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ProjectNameValueKey: value}),
    );

    if (_AddProjectViewTextEditingControllers.containsKey(
        ProjectNameValueKey)) {
      _AddProjectViewTextEditingControllers[ProjectNameValueKey]?.text =
          value ?? '';
    }
  }

  set projectColorValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ProjectColorValueKey: value}),
    );

    if (_AddProjectViewTextEditingControllers.containsKey(
        ProjectColorValueKey)) {
      _AddProjectViewTextEditingControllers[ProjectColorValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasProjectName =>
      this.formValueMap.containsKey(ProjectNameValueKey) &&
      (projectNameValue?.isNotEmpty ?? false);
  bool get hasProjectColor =>
      this.formValueMap.containsKey(ProjectColorValueKey) &&
      (projectColorValue?.isNotEmpty ?? false);

  bool get hasProjectNameValidationMessage =>
      this.fieldsValidationMessages[ProjectNameValueKey]?.isNotEmpty ?? false;
  bool get hasProjectColorValidationMessage =>
      this.fieldsValidationMessages[ProjectColorValueKey]?.isNotEmpty ?? false;

  String? get projectNameValidationMessage =>
      this.fieldsValidationMessages[ProjectNameValueKey];
  String? get projectColorValidationMessage =>
      this.fieldsValidationMessages[ProjectColorValueKey];
}

extension Methods on FormStateHelper {
  setProjectNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ProjectNameValueKey] = validationMessage;
  setProjectColorValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ProjectColorValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    projectNameValue = '';
    projectColorValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      ProjectNameValueKey: getValidationMessage(ProjectNameValueKey),
      ProjectColorValueKey: getValidationMessage(ProjectColorValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _AddProjectViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _AddProjectViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      ProjectNameValueKey: getValidationMessage(ProjectNameValueKey),
      ProjectColorValueKey: getValidationMessage(ProjectColorValueKey),
    });
