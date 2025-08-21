// lib/models/compat.dart
//
// Aliases de compatibilité pour l’ancien code.
// Ils permettent de traiter DbSession/DbPause comme Session/Pause
// sans toucher au reste du projet.

import 'session.dart';
import 'pause.dart';

typedef DbSession = Session;
typedef DbPause = Pause;
