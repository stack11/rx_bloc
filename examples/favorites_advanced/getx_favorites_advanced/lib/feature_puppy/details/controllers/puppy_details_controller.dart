import 'package:collection/collection.dart';
import 'package:get/get.dart';

import 'package:favorites_advanced_base/core.dart';

import 'package:getx_favorites_advanced/base/controllers/mediator_controller.dart';

class PuppyDetailsController extends GetxController {
  PuppyDetailsController(this._puppy, this._mediatorController);
  final MediatorController _mediatorController;
  final Puppy _puppy;
  late Rx<Puppy> puppy;

  @override
  void onInit() {
    puppy = _puppy.obs;
    ever(_mediatorController.puppiesToUpdate, (_) {
      final updatedPuppy = _mediatorController.puppiesToUpdate
          .firstWhereOrNull((element) => element.id == _puppy.id);
      if(updatedPuppy != null){
        puppy(updatedPuppy);
      }
    });
    super.onInit();
  }
}
