import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/firebase.dart';
import '../data/edit_profile_state.dart';
import '../data/profile_controller.dart';
import '../../auth/data/models/user_model.dart' as user_model;

final getUserDataStream = FutureProvider.autoDispose.family<DocumentSnapshot,String>(
        (ref,userId) => usersRef.doc(userId).get()
);

final editProfileProvider = StateNotifierProvider.family<EditProfileController,
    EditProfileState,user_model.User>(
        (ref,user){
      return EditProfileController(
          user: user
      );
    }
);


