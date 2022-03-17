<!doctype html><html>
  <head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
     canvas {border:1px solid;max-width:50px;}
     </style>
  
  
  
  <style>

        
        @font-face {
            font-family: "mainfont";
            src: url("irans.ttf") format("truetype");
        }
        
        body {
            font-family: mainfont;
        }
        

    </style>
    
  
  
  </head>
  
  
  
  <body style="direction:rtl">

<div>.</div>
<div id="canvases" style="width:100%;border:1px solid black;overflow:auto;height:50px">
</div>



<textarea id="title" style="width:100%;height:50px;direction:rtl">متن یک
متن دو</textarea>


<textarea id="txt" style="width:100%;height:250px;direction:rtl">عنوان یک
متن۱

عنوان دو
متن۲

عنوان سه
متن۳

عنوان چهار
متن۴

عنوان پنج
متن۵</textarea>




<input id="music" value="music.mp3"/>

<input id="musicstart" value="00:00:05"/>

<br>
<button id="gen">
  gen
</button>
<script>
 w = 1080;
CanvasRenderingContext2D.prototype.roundRect = function (x, y, w, h, r) {
  if (w < 2 * r) r = w / 2;
  if (h < 2 * r) r = h / 2;
  this.beginPath();
  this.moveTo(x+r, y);
  this.arcTo(x+w, y,   x+w, y+h, r);
  this.arcTo(x+w, y+h, x,   y+h, r);
  this.arcTo(x,   y+h, x,   y,   r);
  this.arcTo(x,   y,   x+w, y,   r);
  this.closePath();
  return this;
}


 function txt_height(ctx, txt) {
        let metrics = ctx.measureText(txt);
        let fontHeight =
          metrics.fontBoundingBoxAscent + metrics.fontBoundingBoxDescent;
        return (actualHeight =
          metrics.actualBoundingBoxAscent + metrics.actualBoundingBoxDescent);
      }

      function maketxt(ctx,txt,cap,beginY=0) {
        ctx.font = w * 0.06 + 'px mainfont';
        ctx.textAlign = 'left';
        
        var ypos = beginY+txt_height(ctx, txt) + w * d1;
        ctx.fillText(txt, w - w * d1 - ctx.measureText(txt).width, ypos);

        ctx.font = w * d2 + 'px mainfont';

        ypos += txt_height(ctx, txt) + w * d1
        linebreak(
          cap,
          maxw,
          ctx
        ).forEach(function (line) {
          ctx.textAlign = 'left';
          ctx.fillText(
            line,
            w - w * d1 - ctx.measureText(line).width,
            ypos
          );
          ypos += txt_height(ctx, line)+w*0.02;
        });

        return ypos;
      }

      linebreak = function (txt, maxwidthx, ctx) {
        var splited = txt.split(' ');

        var lines = [];

        var thisline = '';
        splited.forEach(function (itm) {
          var widthx = ctx.measureText(thisline).width;

          if (widthx < maxwidthx) {
            thisline = thisline + ' ' + itm;
          } else {
            thisline = thisline + ' ' + itm;
            lines.push(thisline.trim());
            thisline = '';
          }
        });

        lines.push(thisline.trim());
        return lines;
      };

      function faal(txts) {
        var x = $(
          '<canvas width="400" height="400" style="direction:rtl"></canvas>'
        );
        var ctx = x[0].getContext('2d');

        
         
         x[0].width = w;
         x[0].height = w;
         
         d0 = 0.01;
         d1 = 0.03;
         d2 = 0.04;

        ctx.globalAlpha = 0.7;
        ctx.fillStyle = "#FFFFFF";
        ctx.roundRect(w*d0, w*d0, w-(w*d0)*2, w-(w*d0)*2, 20).fill(); 
        ctx.fillStyle = "#000000";
        ctx.globalAlpha = 1;

         maxw = w - +w * (d1 * 6);

         var yposs = 0;
         
         

      


setTimeout(()=>{

       txts.forEach(function (fall) {
       
                 yposs = maketxt(ctx,fall.title,fall.text,yposs);
       });

},100);


        return x;
      }
      
      
      
 
 function makecover() {

        var x = $('<canvas width="100" height="100" style="direction:rtl"></canvas>');
 var ctx = x[0].getContext('2d');
setTimeout(()=>{
         
          ctx.textAlign = "left";



         x[0].width = w;
         x[0].height = w;
         

         
         
        ctx.font = w * 0.15 + 'px mainfont';
        var txt = $("#title").val();


        ctx.globalAlpha = 0.7;
        ctx.fillStyle = "#FFFF00";
        var th = 0;
      
        txt.split("\n").forEach(function(l) {        
          l = l.trim();
          th += txt_height(ctx, l)+w*0.05;
        });
  
      
      //  var txtheight = txt_height(ctx, txt);


        var ypos = w-th;

     
        ctx.fillRect(0, ypos-txt_height(ctx, "ش")-w*0.025, w,th+w*0.025); 

        ctx.fillStyle = "#000000";
        ctx.globalAlpha = 1;

ctx.strokeStyle = '#FFFFFF';
ctx.lineWidth = w*0.05;

        txt.split("\n").forEach(function(l) {
          
          l = l.trim();
          
          ctx.strokeText(l, (w+ctx.measureText(l).width)/2, ypos );
           ctx.fillText(l, (w+ctx.measureText(l).width)/2, ypos );
          
          ypos += txt_height(ctx, l)+w*0.05;
         

        });
     },100);  



       return x;
      }     
</script>
<script>



function gen() {

const regexpSize = /^(.*?)\n(.*?)(\n\n)/gms;
var x = $("#txt").val().trim();
x = x+"\n\n"
const match = x.match(regexpSize);
var c = 0;
var fal3 = [];
var allfalls = [];
match.forEach(function(i) {
c++;


var fallitem = i.trim().split("\n"); 

var ttile = fallitem[0].trim();
var ttxt = "";
fallitem.forEach(function(t,i) {
if (i > 0 ) {
ttxt += t+" ";
}
});


fal3.push({"title":ttile,"text":ttxt.trim()+""});

if (c%3>0) {

} else {

if (fal3.length > 0) { 

}
allfalls.push(fal3);
fal3 = [];


}



/*var ffla = faal([
  
  {"title":Math.random()+"","text":Math.random()+""},
  {"title":Math.random()+"","text":Math.random()+""},
  {"title":Math.random()+"","text":Math.random()+""}
  
  ]);
*/
//ffla.attr("data-length","14.5");
  
//$('#canvases').append(ffla);
  

}) ;
if (fal3.length > 0) {
allfalls.push(fal3);
}


allfalls.forEach(function(ff) {
var ffla = faal(ff);

ffla.attr("data-length","14.5");
  
$('#canvases').append(ffla);
}) ;


setTimeout(()=>{

run();

},1000);

}

adsc


$("#gen").click(function() {
$('#canvases').empty();
var zz = makecover();
  zz.attr("data-length","1");
 $('#canvases').append(zz);

gen();

  
 
  
  
});




function run() {
var cmdx = 'ffmpeg ';

mainwidth = w;
var from = 0;
var to = 0;
var tot = 0;
var fcomplx  = "[1:v]loop=-1:10000:0[cov0];[cov0]scale="+mainwidth+":-1[cover];[0:v][cover]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:shortest=1[mainlayer];" ;
 $("canvas").each(function(itm) {
    var layerlength = parseFloat($(this).attr("data-length"));
    
    tot = tot+layerlength;
    
  //  itm = itm+2;
    to = to+layerlength;
    
    if (itm === 0) {
     var mainlayer = '[mainlayer]';
    } else {
     var mainlayer = '[layer'+(itm-1)+']';
    }
    
   
    if (itm != $("canvas").length-1) {
    var layername = '[layer'+itm+'];';
    } else {
    var layername = "";
    }
    
    fcomplx += mainlayer+'['+(itm+2)+':v]overlay=0:0:enable=\'between(t,'+from+','+to+')\''+layername; 
    from = to;
    
    
    
 });
 
 
cmdx += '-t '+tot+' -f lavfi -i color=c=white:s='+mainwidth+'x'+mainwidth+' '
cmdx += '-i '+coverx+' '
cmdx += "-i "+[...Array($("canvas").length).keys()].join(".png -i ")+".png ";
cmdx += '-filter_complex "';

 
 cmdx += fcomplx+'"';
 cmdx += " -i "+$("#music").val()+" -ss "+$("#musicstart").val()+" -map 0:v -map "+($("canvas").length+2)+":a -shortest ";
 cmdx += " out.mp4 -y";
console.log(cmdx);

  $("canvas").each(function(itm) {


  var dt = $(this)[0].toDataURL();
$.ajax({

  type: "POST",
                        url: "gen/"+itm,
                        data: dt,
                        success:function() {
                              if (itm+1===$("canvas").length) {
                               cmd(cmdx);
                              }
                        }

});
  
  });
}

function cmd(cmdv) {
$.ajax({

  type: "POST",
                        url: "cmd",
                        data: cmdv,
                        success:function() {
                             
                        }

});
}

</script>
    
  </body>
</html>
