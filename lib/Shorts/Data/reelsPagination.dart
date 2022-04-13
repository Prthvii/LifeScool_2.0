import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Shorts/Data/addToCache.dart';
import 'package:lifescool/Shorts/Data/listReels.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


var arrReels = [];
var arrList = [];

Future paginateReels(currentIndex)async{

  var totalIndex = await getSharedPrefrence(TOTALREELS);
  var lastAddedIndex = await getSharedPrefrence(LASTADEED);


  if(int.parse(currentIndex)<int.parse(totalIndex)){
    if(int.parse(currentIndex)<int.parse(lastAddedIndex)){
      print("fetchhh reeels");



     return "1".toString();

    }else{
      var add = await getPaginationReels(currentIndex);
    }
  }

}



Future<dynamic> getPaginationReels(page) async {
  arrReels.clear();
  arrList.clear();
  var rsp = await reelsListApi(page);

  print(rsp);

  // arrProdList = data;
  //
  if (rsp != 0 ) {

    arrReels = rsp['attributes']['shortslist'];

    for (var i = 0; i < arrReels.length; i++) {
      if(arrReels[i]['video_url_mp4_low']!=""){
        var file = await DefaultCacheManager().getSingleFile(arrReels[i]['video_url_mp4_low']);
        var image = await DefaultCacheManager().getSingleFile(arrReels[i]['thumbnail_url']);

        print("fetechingggg");
        print(arrReels[i]['id']);


          arrList.add(
              {

                "id": arrReels[i]["id"],
                "uid": arrReels[i]["uid"],
                "title": arrReels[i]["title"],
                "desc":arrReels[i]["desc"],
                "like": arrReels[i]["like"],
                "targetType":arrReels[i]["targetType"],
                "targetId": arrReels[i]["targetId"],
                "targetUid": arrReels[i]["targetUid"],
                "targetBtnName": arrReels[i]["targetBtnName"],
                "targetJtwContent": arrReels[i]["targetJtwContent"],
                "video_source": arrReels[i]["video_source"],
                "video_url": file.path,
                "author_id":arrReels[i]["author_id"],
                "author_img":arrReels[i]["author_img"],
                "thumbnail_url": image.path,
                "videoDuration":arrReels[i]["videoDuration"],
                "isLiked": arrReels[i]["isLiked"],
                "isSave": false,
                "page": rsp['attributes']['page'].toString(),




              }
          );



        var add = addCache(arrReels[i]['id'],arrReels[i]['uid'],arrReels[i]['title'],arrReels[i]['desc'],arrReels[i]['like'],arrReels[i]['targetType'],arrReels[i]['targetId'],arrReels[i]['targetUid'],arrReels[i]['targetBtnName'],arrReels[i]['targetJtwContent'],arrReels[i]['video_source'],file.path,arrReels[i]['author_id'],arrReels[i]['author_img'],image.path,arrReels[i]['videoDuration'],arrReels[i]['isLiked'], rsp['attributes']['page'].toString(),false);
      }



    }
    // setState(() {
    //   isLoading = false;
    // });
    return arrList;
  }
}
