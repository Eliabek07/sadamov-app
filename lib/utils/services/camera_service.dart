import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:sadamov/model/exception/business_exception.dart';
import 'package:sadamov/utils/secure_logger.dart';

/// Serviço responsável por gerenciar captura de fotos
/// Solicita permissões e captura imagens da câmera do dispositivo
class CameraService {
  final ImagePicker _imagePicker = ImagePicker();

  /// Captura uma foto usando a câmera do dispositivo
  /// Solicita permissão de câmera se necessário
  /// Retorna os bytes da imagem ou null se o usuário cancelar
  Future<Uint8List?> capturePhoto() async {
    try {
      final status = await Permission.camera.request();
      if (status != PermissionStatus.granted) {
        throw BusinessException(
          'Permissão de câmera negada. Por favor, habilite nas configurações.',
        );
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image == null) return null;

      final file = File(image.path);
      final bytes = await file.readAsBytes();
      
      SecureLogger.debug('Foto capturada: ${bytes.length} bytes');
      return bytes;
    } catch (e) {
      SecureLogger.error('Erro ao capturar foto: ', e);
      rethrow;
    }
  }

  /// Verifica se a permissão de câmera foi concedida
  /// Retorna true se a permissão está ativa, false caso contrário
  Future<bool> checkCameraPermission() async {
    final status = await Permission.camera.status;
    return status == PermissionStatus.granted;
  }
}

