class CheckImageUrl{

  static bool checkHttp(String image){
    if(image.contains("https")||image.contains("http")){
      return true;
    }
    else{
      return false;
    }
  }

  static bool checkExtensions(String image){
    if(image.toLowerCase().contains(".png")||image.toLowerCase().contains(".jpeg")||image.toLowerCase().contains(".jpg")){
      return true;
    }
    else if(image.toLowerCase().contains(".tiff")||image.toLowerCase().contains(".raw")||image.toLowerCase().contains(".webp")){
      return true;
    }
    if(image.toLowerCase().contains(".svg")||image.toLowerCase().contains(".eps")||image.toLowerCase().contains(".gif")){
      return true;
    }
    if(image.toLowerCase().contains("heif")||image.toLowerCase().contains("heic")||image.toLowerCase().contains("mpeg")){
      return true;
    }
    else{
      return false;
    }
  }
}