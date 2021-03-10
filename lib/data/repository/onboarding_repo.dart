
import 'package:sixvalley_ui_kit/data/model/response/onboarding_model.dart';

final String description='Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.';
class OnBoardingRepo{

  List<OnboardingModel> getOnBoardingList() {
    List<OnboardingModel> onboarding = [
      OnboardingModel('assets/images/onboarding_image_one.png','BUY',description),
      OnboardingModel('assets/images/onboarding_image_two.png','Check Out',description),
      OnboardingModel('assets/images/onboarding_image_three.png','Fast Delivery',description),
    ];
    return onboarding;
  }
}