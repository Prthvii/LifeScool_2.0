

 catsName(data){
  var name = data=="MIIMAGE"?"Image":
  data=="MIPDF"?"Pdf":
  data=="MITEXT"?"Text":
  data=="MIVIDEO"?"Video":"Unknown";
  return name;
}



 viewCatName(data){
  var name = data=="MIIMAGE"?"View Image":
  data=="MIPDF"?"View Pdf":
  data=="MITEXT"?"View Text":
  data=="MIVIDEO"?"View Video": data=="GROUPLIVE"?"Join Live":"Unknown";
  return name;
 }