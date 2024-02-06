// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String TaskTitleValueKey = 'taskTitle';
const String TaskDetailsValueKey = 'taskDetails';

final Map<String, TextEditingController> _AddTaskViewTextEditingControllers =
    {};

final Map<String, FocusNode> _AddTaskViewFocusNodes = {};

final Map<String, String? Function(String?)?> _AddTaskViewTextValidations = {
  TaskTitleValueKey: null,
  TaskDetailsValueKey: null,
};

mixin $AddTaskView {
  TextEditingController get taskTitleController =>
      _getFormTextEditingController(TaskTitleValueKey);
  TextEditingController get taskDetailsController =>
      _getFormTextEditingController(TaskDetailsValueKey);

  FocusNode get taskTitleFocusNode => _getFormFocusNode(TaskTitleValueKey);
  FocusNode get taskDetailsFocusNode => _getFormFocusNode(TaskDetailsValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_AddTaskViewTextEditingControllers.containsKey(key)) {
      return _AddTaskViewTextEditingControllers[key]!;
    }

    _AddTaskViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AddTaskViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AddTaskViewFocusNodes.containsKey(key)) {
      return _AddTaskViewFocusNodes[key]!;
    }
    _AddTaskViewFocusNodes[key] = FocusNode();
    return _AddTaskViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    taskTitleController.addListener(() => _updateFormData(model));
    taskDetailsController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    taskTitleController.addListener(() => _updateFormData(model));
    taskDetailsController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          TaskTitleValueKey: taskTitleController.text,
          TaskDetailsValueKey: taskDetailsController.text,
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

    for (var controller in _AddTaskViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AddTaskViewFocusNodes.values) {
      focusNode.dispose();
    }

    _AddTaskViewTextEditingControllers.clear();
    _AddTaskViewFocusNodes.clear();
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

  String? get taskTitleValue => this.formValueMap[TaskTitleValueKey] as String?;
  String? get taskDetailsValue =>
      this.formValueMap[TaskDetailsValueKey] as String?;

  set taskTitleValue(String? value) {
    this.setData(
      this.formValueMap..addAll({TaskTitleValueKey: value}),
    );

    if (_AddTaskViewTextEditingControllers.containsKey(TaskTitleValueKey)) {
      _AddTaskViewTextEditingControllers[TaskTitleValueKey]?.text = value ?? '';
    }
  }

  set taskDetailsValue(String? value) {
    this.setData(
      this.formValueMap..addAll({TaskDetailsValueKey: value}),
    );

    if (_AddTaskViewTextEditingControllers.containsKey(TaskDetailsValueKey)) {
      _AddTaskViewTextEditingControllers[TaskDetailsValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasTaskTitle =>
      this.formValueMap.containsKey(TaskTitleValueKey) &&
      (taskTitleValue?.isNotEmpty ?? false);
  bool get hasTaskDetails =>
      this.formValueMap.containsKey(TaskDetailsValueKey) &&
      (taskDetailsValue?.isNotEmpty ?? false);

  bool get hasTaskTitleValidationMessage =>
      this.fieldsValidationMessages[TaskTitleValueKey]?.isNotEmpty ?? false;
  bool get hasTaskDetailsValidationMessage =>
      this.fieldsValidationMessages[TaskDetailsValueKey]?.isNotEmpty ?? false;

  String? get taskTitleValidationMessage =>
      this.fieldsValidationMessages[TaskTitleValueKey];
  String? get taskDetailsValidationMessage =>
      this.fieldsValidationMessages[TaskDetailsValueKey];
}

extension Methods on FormStateHelper {
  setTaskTitleValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TaskTitleValueKey] = validationMessage;
  setTaskDetailsValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TaskDetailsValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    taskTitleValue = '';
    taskDetailsValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      TaskTitleValueKey: getValidationMessage(TaskTitleValueKey),
      TaskDetailsValueKey: getValidationMessage(TaskDetailsValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _AddTaskViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _AddTaskViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      TaskTitleValueKey: getValidationMessage(TaskTitleValueKey),
      TaskDetailsValueKey: getValidationMessage(TaskDetailsValueKey),
    });
