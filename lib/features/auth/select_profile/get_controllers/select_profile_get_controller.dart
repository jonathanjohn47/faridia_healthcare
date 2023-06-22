import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/features/home/ui/doctor_home_page.dart';
import 'package:faridia_healthcare/features/home/ui/patient_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SelectProfileGetController extends GetxController {
  void checkIfAlreadyLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore.instance
          .collection(AppConstants.doctors)
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get()
          .then((value) {
        if (value.exists) {
          Get.offAll(() => DoctorHomePage());
        } else {
          FirebaseFirestore.instance
              .collection(AppConstants.patients)
              .doc(FirebaseAuth.instance.currentUser!.email)
              .get()
              .then((value) {
            if (value.exists) {
              Get.offAll(() => PatientHomePage());
            }
          });
        }
      });
    }
  }

  @override
  void onInit() {
    checkIfAlreadyLoggedIn();
    super.onInit();
  }

/*void createDoctor() {
    DoctorModel doctorModel = DoctorModel(
      name: 'Dr. Faridia',
      email: 'faridia@faridia.com',
      phone: "+919876543210",
      bio: "Dentist, BDS, MDS - Oral & Maxillofacial Surgery",
      fcmToken: "",
      imageLink:
          "https://th.bing.com/th/id/R.b379902c62bb9c7333c2bbf704d8104c?rik=EALI63%2bLUEhkeA&riu=http%3a%2f%2fwww.texila.us%2fblog%2fwp-content%2fuploads%2f2015%2f09%2fDoctor-Background.jpg&ehk=xT7BPf004Jh0P1KDbK%2f2xsvItxYhv%2bFqwSrNT6Qamvg%3d&risl=&pid=ImgRaw&r=0",
      about:
          "Dr. Faridia is a Dentist, BDS, MDS - Oral & Maxillofacial Surgery with 10 years of experience.",
      services:
          "Dental Implant Fixing, Dental Fillings, Dental Checkup (General), Dental Examinations, Dental Restoration, Dental prophylaxis, Dental screening and prophylaxis, Dental Sealant, Dental X-Ray, Dental Examinations, Dental prophylaxis, Dental screening and prophylaxis, Dental Sealant, Dental X-Ray",
      education:
          "BDS - Rajiv Gandhi University of Health Sciences, Bangalore, India, 2011, MDS - Oral & Maxillofacial Surgery - Rajiv Gandhi University of Health Sciences, Bangalore, India, 2015",
      experience:
          "2011 - 2015 Oral & Maxillofacial Surgeon at Dr. Faridia's Dental Clinic, 2015 - 2021 Oral & Maxillofacial Surgeon at Dr. Faridia's Dental Clinic",
      awardsAndRecognitions: "Best Dentist Award 2019",
      clinicAddress:
          "Dr. Faridia's Dental Clinic, 123, ABC Road, XYZ City, 123456",
    );

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: 'faridia@faridia.com', password: '112233')
        .then((value) {
      FirebaseFirestore.instance
          .collection(AppConstants.doctors)
          .doc('faridia@faridia.com')
          .set(doctorModel.toJson());
    });
  }*/
}
