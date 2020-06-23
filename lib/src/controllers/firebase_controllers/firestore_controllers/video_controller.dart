import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronaapp/src/utils/constants.dart';

// This class(Controller) for all videos operations  >>>
class VideoController {
  static VideoController _instance;
  CollectionReference _videosReference;

  VideoController._() {
    _videosReference =
        Firestore.instance.collection(Constants.FIREBASE_COLLECTIONS_VIDEOS);
  }

  static VideoController get instance {
    if (_instance != null) return _instance;
    return _instance = VideoController._();
  }

  // ||... This method to get all questions ...||
  Stream<QuerySnapshot> getVideos() {
    return _videosReference.snapshots();
  }
}
