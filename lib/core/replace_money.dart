repla(String value) {
  value = value.replaceAll(r'.', "").replaceAll(r',', '.');
  return value;
}
replaData(String value){
  value = value.replaceAll(r'/', "");
  return value;
}