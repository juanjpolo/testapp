String getImage(String? url) {
  String urlImage;
  if (url == null) {
    urlImage =
        'https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  } else {
    urlImage = 'https://cdn2.thecatapi.com/images/$url.jpg';
  }
  return urlImage;
}

int getAdaptability(int? _adaptability) {
  int adaptability;
  if (_adaptability == null) {
    adaptability = 0;
  } else {
    adaptability = _adaptability;
  }
  return adaptability;
}

String getLifeSpan(String? life) {
  String lifeSpan;
  if (life == null) {
    lifeSpan = 'No Such Info';
  } else {
    lifeSpan = life;
  }
  return lifeSpan;
}
