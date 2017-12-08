function getobj(id){
  return document.getElementById(id);
}

function changesrc(tdid,prex,tid,num,url,name){
      getobj(tdid).className='PTitle';
      getobj(prex+'_'+tid+"_content").style.display="block"
      if(url && name)getobj(name).src = url;
      for(var i=1;i<=num;i++){
        if(i!=tid){
          try{
            getobj(prex+'_'+i).className='PTitleL';
            getobj(prex+'_'+i+"_content").style.display="none"
          }catch(err){
          continue;
          }
        }
     }
}

function selectStyleForTheme(name){
  var date=new Date();//今天的日期
  date.setTime(date.getTime()+365*24*60*60*1000*10000);//一万年后的日期
  var cssCookieName = "theme"; 
  document.cookie= cssCookieName + "="+name + ";path=/;" + "expires="+date.toGMTString();//设置一万年后过期的cookies(名称为css)
  swapStyleSheet("theme2",contextPath+"/static/css/style-" + name + ".css")
}

function   removeStyleSheet( id) {
  var existing = document.getElementById(id);
  if (existing) existing.parentNode.removeChild(existing);
}
    
   function  swapStyleSheet(id, url) {
          var doc = document;
          removeStyleSheet(id);
          var ss = doc.createElement("link");
          ss.setAttribute("rel", "stylesheet");
          ss.setAttribute("type", "text/css");
          ss.setAttribute("id", id);
          ss.setAttribute("href", url);
          doc.getElementsByTagName("head")[0].appendChild(ss);
  }

 function   trim(str){return   str.replace(/^\s+|\s+$/,   '')}
