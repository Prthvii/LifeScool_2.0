import 'dart:convert';

import 'package:lifescool/Helper/sharedPref.dart';


var cacheItemsNew=[];


Future addCache(id,uid,title,desc,like,targetType,targetId,targetUid,targetBtnName,targetJtwContent,video_source,video_url,author_id,author_img,thumbnail_url,videoDuration,isLiked,page,isSaved) async {




  cacheItemsNew.clear();
  var cart = await getSharedPrefrence(REELS);

  if(cart!=null){



    var decodedMap = json.decode(cart);
    for (var i = 0; i < decodedMap.length; i++) {
      var map = decodedMap[i];


          cacheItemsNew.add(
              {

                "id": map["id"],
                "uid": map["uid"],
                "title": map["title"],
                "desc":map["desc"],
                "like": map["like"],
                "targetType":map["targetType"],
                "targetId": map["targetId"],
                "targetUid": map["targetUid"],
                "targetBtnName": map["targetBtnName"],
                "targetJtwContent": map["targetJtwContent"],
                "video_source": map["video_source"],
                "video_url": map['video_url'],
                "author_id":map["author_id"],
                "author_img":map["author_img"],
                "thumbnail_url": map["thumbnail_url"],
                "videoDuration":map["videoDuration"],
                "isLiked": map["isLiked"],
                "isSave": map["isSave"],
                "page": map["page"],




              }
              );

    }
    cacheItemsNew.add(
        {

          "id":id,
          "uid": uid,
          "title": title,
          "desc":desc,
          "like": like,
          "targetType":targetType,
          "targetId": targetId,
          "targetUid": targetUid,
          "targetBtnName": targetBtnName,
          "targetJtwContent": targetJtwContent,
          "video_source":video_source,
          "video_url": video_url,
          "author_id":author_id,
          "author_img":author_img,
          "thumbnail_url": thumbnail_url,
          "videoDuration":videoDuration,
          "isLiked": isLiked,
          "isSave": isSaved,

          "page": page,





        }
    );
    String encodedMap = json.encode(cacheItemsNew);
    print("encodedMap");
    print(encodedMap);
    var add = await setSharedPrefrence(REELS,encodedMap);
  }
  else{
    cacheItemsNew.add(
        {

          "id":id,
          "uid": uid,
          "title": title,
          "desc":desc,
          "like": like,
          "targetType":targetType,
          "targetId": targetId,
          "targetUid": targetUid,
          "targetBtnName": targetBtnName,
          "targetJtwContent": targetJtwContent,
          "video_source":video_source,
          "video_url":  video_url,
          "author_id":author_id,
          "author_img":author_img,
          "thumbnail_url": thumbnail_url,
          "videoDuration":videoDuration,
          "isLiked": isLiked,
          "isSave": isSaved,

          "page": page,




        }
    );

    String encodedMap = json.encode(cacheItemsNew);
    print("encodedMap");
    print(encodedMap);
    var add = await setSharedPrefrence(REELS,encodedMap);
  }

  var lst = await setSharedPrefrence(LASTADEED,page);
  return 1;


}


Future updateCache(id,type,value) async {




  cacheItemsNew.clear();
  var cart = await getSharedPrefrence(REELS);

  if(cart!=null){



    var decodedMap = json.decode(cart);
    for (var i = 0; i < decodedMap.length; i++) {
      var map = decodedMap[i];


      if(map["id"]==id){

        print("ithaaan");
        print(map["desc"]);
        cacheItemsNew.add(
            {

              "id": map["id"],
              "uid": map["uid"],
              "title": map["title"],
              "desc":map["desc"],
              "like": map["like"],
              "targetType":map["targetType"],
              "targetId": map["targetId"],
              "targetUid": map["targetUid"],
              "targetBtnName": map["targetBtnName"],
              "targetJtwContent": map["targetJtwContent"],
              "video_source": map["video_source"],
              "video_url": map['video_url'],
              "author_id":map["author_id"],
              "author_img":map["author_img"],
              "thumbnail_url": map["thumbnail_url"],
              "videoDuration":map["videoDuration"],
              "isLiked":type=="LIKE"? value:map["isLiked"],
              "isSave":type=="SAVE"? value:map["isSave"],
              "page": map["page"],




            }
        );
      }else{
        cacheItemsNew.add(
            {

              "id": map["id"],
              "uid": map["uid"],
              "title": map["title"],
              "desc":map["desc"],
              "like": map["like"],
              "targetType":map["targetType"],
              "targetId": map["targetId"],
              "targetUid": map["targetUid"],
              "targetBtnName": map["targetBtnName"],
              "targetJtwContent": map["targetJtwContent"],
              "video_source": map["video_source"],
              "video_url": map['video_url'],
              "author_id":map["author_id"],
              "author_img":map["author_img"],
              "thumbnail_url": map["thumbnail_url"],
              "videoDuration":map["videoDuration"],
              "isLiked": map["isLiked"],
              "isSave": map["isSave"],
              "page": map["page"],




            }
        );
      }



    }
    // cacheItemsNew.add(
    //     {
    //
    //       "id":id,
    //       "uid": uid,
    //       "title": title,
    //       "desc":desc,
    //       "like": like,
    //       "targetType":targetType,
    //       "targetId": targetId,
    //       "targetUid": targetUid,
    //       "targetBtnName": targetBtnName,
    //       "targetJtwContent": targetJtwContent,
    //       "video_source":video_source,
    //       "video_url": video_url,
    //       "author_id":author_id,
    //       "author_img":author_img,
    //       "thumbnail_url": thumbnail_url,
    //       "videoDuration":videoDuration,
    //       "isLiked": isLiked,
    //       "isSave": isSaved,
    //
    //       "page": page,
    //
    //
    //
    //
    //
    //     }
    // );
    String encodedMap = json.encode(cacheItemsNew);
    print("encodedMap");
    print(encodedMap);
    var add = await setSharedPrefrence(REELS,encodedMap);
  }



  return 1;


}

Future getFromCache()async{
  var cart = await getSharedPrefrence(REELS);
  var decodedMap = json.decode(cart);

  return decodedMap;
}


