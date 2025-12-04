import 'package:mobx/mobx.dart';
import 'dart:typed_data';
import 'package:sadamov/model/data/occurrence/occurrence_model.dart';
import 'package:sadamov/model/repository/occurrence_repository.dart';
import 'package:sadamov/utils/secure_logger.dart';

part 'occurrence_store.g.dart';

class OccurrenceStore = _OccurrenceStore with _$OccurrenceStore;

abstract class _OccurrenceStore with Store {
  final OccurrenceRepository _repository = OccurrenceRepository();

  // Observables
  @observable
  String _plateNumber = '';

  @observable
  ObservableList<Uint8List> _photos = ObservableList<Uint8List>();

  @observable
  String _responsibleName = '';

  @observable
  Uint8List? _signature;

  @observable
  bool _isLoading = false;

  @observable
  String? _errorMessage;

  // Getters
  @computed
  String get plateNumber => _plateNumber;

  @computed
  List<Uint8List> get photos => _photos.toList();

  @computed
  String get responsibleName => _responsibleName;

  @computed
  Uint8List? get signature => _signature;

  @computed
  bool get isLoading => _isLoading;

  @computed
  String? get errorMessage => _errorMessage;

  @computed
  bool get isPlateValid {
    if (_plateNumber.isEmpty) return false;
    final cleaned = _plateNumber.replaceAll(RegExp(r'[-\s]'), '').toUpperCase();
    final oldPattern = RegExp(r'^[A-Z]{3}[0-9]{4}$');
    final newPattern = RegExp(r'^[A-Z]{3}[0-9][A-Z0-9][0-9]{2}$');
    return oldPattern.hasMatch(cleaned) || newPattern.hasMatch(cleaned);
  }

  @computed
  bool get hasMinimumPhotos => _photos.length >= 1;

  @computed
  bool get canProceedToNextStep => isPlateValid && hasMinimumPhotos;

  @computed
  bool get canFinalize => 
      _responsibleName.isNotEmpty && 
      _signature != null && 
      _signature!.isNotEmpty;

  // Actions
  @action
  void setPlateNumber(String value) {
    _plateNumber = value;
  }

  @action
  void addPhoto(Uint8List photoBytes) {
    _photos.add(photoBytes);
  }

  @action
  void removePhoto(int index) {
    if (index >= 0 && index < _photos.length) {
      _photos.removeAt(index);
    }
  }

  @action
  void setResponsibleName(String value) {
    _responsibleName = value;
  }

  @action
  void setSignature(Uint8List signatureBytes) {
    _signature = signatureBytes;
  }

  @action
  Future<void> saveOccurrence() async {
    _isLoading = true;
    _errorMessage = null;

    try {
      final occurrence = OccurrenceModel(
        plate: _plateNumber,
        photos: _photos.toList(),
        responsibleName: _responsibleName,
        signature: _signature,
        createdAt: DateTime.now(),
        isSynced: false,
      );

      await _repository.saveOccurrence(occurrence);
      SecureLogger.debug('✅ Ocorrência salva com sucesso');
    } catch (e) {
      SecureLogger.error('❌ Erro ao salvar ocorrência: ', e);
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  @action
  void reset() {
    _plateNumber = '';
    _photos.clear();
    _responsibleName = '';
    _signature = null;
    _errorMessage = null;
  }
}

