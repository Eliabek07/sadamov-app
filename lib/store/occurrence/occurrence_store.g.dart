// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occurrence_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OccurrenceStore on _OccurrenceStore, Store {
  Computed<String>? _$plateNumberComputed;

  @override
  String get plateNumber =>
      (_$plateNumberComputed ??= Computed<String>(() => super.plateNumber,
              name: '_OccurrenceStore.plateNumber'))
          .value;
  Computed<List<Uint8List>>? _$photosComputed;

  @override
  List<Uint8List> get photos =>
      (_$photosComputed ??= Computed<List<Uint8List>>(() => super.photos,
              name: '_OccurrenceStore.photos'))
          .value;
  Computed<String>? _$responsibleNameComputed;

  @override
  String get responsibleName => (_$responsibleNameComputed ??= Computed<String>(
          () => super.responsibleName,
          name: '_OccurrenceStore.responsibleName'))
      .value;
  Computed<Uint8List?>? _$signatureComputed;

  @override
  Uint8List? get signature =>
      (_$signatureComputed ??= Computed<Uint8List?>(() => super.signature,
              name: '_OccurrenceStore.signature'))
          .value;
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_OccurrenceStore.isLoading'))
          .value;
  Computed<String?>? _$errorMessageComputed;

  @override
  String? get errorMessage =>
      (_$errorMessageComputed ??= Computed<String?>(() => super.errorMessage,
              name: '_OccurrenceStore.errorMessage'))
          .value;
  Computed<bool>? _$isPlateValidComputed;

  @override
  bool get isPlateValid =>
      (_$isPlateValidComputed ??= Computed<bool>(() => super.isPlateValid,
              name: '_OccurrenceStore.isPlateValid'))
          .value;
  Computed<bool>? _$hasMinimumPhotosComputed;

  @override
  bool get hasMinimumPhotos => (_$hasMinimumPhotosComputed ??= Computed<bool>(
          () => super.hasMinimumPhotos,
          name: '_OccurrenceStore.hasMinimumPhotos'))
      .value;
  Computed<bool>? _$canProceedToNextStepComputed;

  @override
  bool get canProceedToNextStep => (_$canProceedToNextStepComputed ??=
          Computed<bool>(() => super.canProceedToNextStep,
              name: '_OccurrenceStore.canProceedToNextStep'))
      .value;
  Computed<bool>? _$canFinalizeComputed;

  @override
  bool get canFinalize =>
      (_$canFinalizeComputed ??= Computed<bool>(() => super.canFinalize,
              name: '_OccurrenceStore.canFinalize'))
          .value;

  late final _$_plateNumberAtom =
      Atom(name: '_OccurrenceStore._plateNumber', context: context);

  @override
  String get _plateNumber {
    _$_plateNumberAtom.reportRead();
    return super._plateNumber;
  }

  @override
  set _plateNumber(String value) {
    _$_plateNumberAtom.reportWrite(value, super._plateNumber, () {
      super._plateNumber = value;
    });
  }

  late final _$_photosAtom =
      Atom(name: '_OccurrenceStore._photos', context: context);

  @override
  ObservableList<Uint8List> get _photos {
    _$_photosAtom.reportRead();
    return super._photos;
  }

  @override
  set _photos(ObservableList<Uint8List> value) {
    _$_photosAtom.reportWrite(value, super._photos, () {
      super._photos = value;
    });
  }

  late final _$_responsibleNameAtom =
      Atom(name: '_OccurrenceStore._responsibleName', context: context);

  @override
  String get _responsibleName {
    _$_responsibleNameAtom.reportRead();
    return super._responsibleName;
  }

  @override
  set _responsibleName(String value) {
    _$_responsibleNameAtom.reportWrite(value, super._responsibleName, () {
      super._responsibleName = value;
    });
  }

  late final _$_signatureAtom =
      Atom(name: '_OccurrenceStore._signature', context: context);

  @override
  Uint8List? get _signature {
    _$_signatureAtom.reportRead();
    return super._signature;
  }

  @override
  set _signature(Uint8List? value) {
    _$_signatureAtom.reportWrite(value, super._signature, () {
      super._signature = value;
    });
  }

  late final _$_isLoadingAtom =
      Atom(name: '_OccurrenceStore._isLoading', context: context);

  @override
  bool get _isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_OccurrenceStore._errorMessage', context: context);

  @override
  String? get _errorMessage {
    _$_errorMessageAtom.reportRead();
    return super._errorMessage;
  }

  @override
  set _errorMessage(String? value) {
    _$_errorMessageAtom.reportWrite(value, super._errorMessage, () {
      super._errorMessage = value;
    });
  }

  late final _$saveOccurrenceAsyncAction =
      AsyncAction('_OccurrenceStore.saveOccurrence', context: context);

  @override
  Future<void> saveOccurrence() {
    return _$saveOccurrenceAsyncAction.run(() => super.saveOccurrence());
  }

  late final _$_OccurrenceStoreActionController =
      ActionController(name: '_OccurrenceStore', context: context);

  @override
  void setPlateNumber(String value) {
    final _$actionInfo = _$_OccurrenceStoreActionController.startAction(
        name: '_OccurrenceStore.setPlateNumber');
    try {
      return super.setPlateNumber(value);
    } finally {
      _$_OccurrenceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addPhoto(Uint8List photoBytes) {
    final _$actionInfo = _$_OccurrenceStoreActionController.startAction(
        name: '_OccurrenceStore.addPhoto');
    try {
      return super.addPhoto(photoBytes);
    } finally {
      _$_OccurrenceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removePhoto(int index) {
    final _$actionInfo = _$_OccurrenceStoreActionController.startAction(
        name: '_OccurrenceStore.removePhoto');
    try {
      return super.removePhoto(index);
    } finally {
      _$_OccurrenceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setResponsibleName(String value) {
    final _$actionInfo = _$_OccurrenceStoreActionController.startAction(
        name: '_OccurrenceStore.setResponsibleName');
    try {
      return super.setResponsibleName(value);
    } finally {
      _$_OccurrenceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSignature(Uint8List signatureBytes) {
    final _$actionInfo = _$_OccurrenceStoreActionController.startAction(
        name: '_OccurrenceStore.setSignature');
    try {
      return super.setSignature(signatureBytes);
    } finally {
      _$_OccurrenceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_OccurrenceStoreActionController.startAction(
        name: '_OccurrenceStore.reset');
    try {
      return super.reset();
    } finally {
      _$_OccurrenceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
plateNumber: ${plateNumber},
photos: ${photos},
responsibleName: ${responsibleName},
signature: ${signature},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
isPlateValid: ${isPlateValid},
hasMinimumPhotos: ${hasMinimumPhotos},
canProceedToNextStep: ${canProceedToNextStep},
canFinalize: ${canFinalize}
    ''';
  }
}
