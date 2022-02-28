

 catsName(data){
  var name = data=="MIIMAGE"?"Image":
  data=="MIPDF"?"Pdf":
  data=="MITEXT"?"Text":
  data=="MIVIDEO"?"Video":"Unknown";
  return name;
}