import 'package:flutter_modular/flutter_modular.dart';
import 'package:sadamov/store/occurrence/occurrence_store.dart';
import 'package:sadamov/model/repository/occurrence_repository.dart';
import 'package:sadamov/utils/services/camera_service.dart';
import 'package:sadamov/model/client/occurrence/occurrence_client.dart';
import 'package:sadamov/view/pages/checklist/checklist_page.dart';
import 'package:sadamov/view/pages/occurrence/occurrence_page.dart';
import 'package:sadamov/view/pages/review/review_page.dart';
import 'package:sadamov/view/pages/success/success_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    // Stores
    i.addSingleton<OccurrenceStore>(OccurrenceStore.new);
    
    // Repositories
    i.addSingleton<OccurrenceRepository>(OccurrenceRepository.new);
    
    // Services
    i.addSingleton<CameraService>(CameraService.new);
    
    // Clients
    i.addSingleton<OccurrenceClient>(OccurrenceClient.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const ChecklistPage());
    r.child('/occurrence', child: (_) => const OccurrencePage());
    r.child('/review', child: (_) => const ReviewPage());
    r.child(
      '/success',
      child: (context) {
        final args = Modular.args.data as Map<String, dynamic>?;
        return SuccessPage(occurrence: args);
      },
    );
  }
}

