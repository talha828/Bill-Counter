class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image,required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Submits text books donation',
      image: 'assets/img/quality.jpg',
      discription: "Collect the donation form with required information and submits it. "
  ),
  UnbordingContent(
      title: 'Doorstep from pickup',
      image: 'assets/img/quality.jpg',
      discription: "You schedule a slot for pickup and provide your pickup address. "
          " we will arrange pickup for you from your doorstep "
  ),
  UnbordingContent(
      title: 'Earn badges as your reward',
      image: 'assets/img/quality.jpg',
      discription: "since you donate your textbooks you will get badges when you reach"
          " certain levels "
  ),
];
