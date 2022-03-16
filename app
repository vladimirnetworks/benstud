<!doctype html><html>
  <head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
     canvas {border:1px solid}
     </style>
  </head>
  <body>

<div id="canvases" style="width:100%;border:1px solid black">
</div>

<textarea id="txt" style="width:100%;height:500px;direction:rtl">عنوان یک
متن۱

عنوان دو
متن۲</textarea>

<button id="add">
  add
</button>
<script>

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
        ctx.font = w * 0.06 + 'px Arial';
        ctx.textAlign = 'left';
        
        var ypos = beginY+txt_height(ctx, txt) + w * d1;
        ctx.fillText(txt, w - w * d1 - ctx.measureText(txt).width, ypos);

        ctx.font = w * d2 + 'px Arial';

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

         w = 400;
         d0 = 0.01;
         d1 = 0.03;
         d2 = 0.04;

        ctx.globalAlpha = 0.7;
        ctx.fillStyle = "#FFFFFF";
        ctx.roundRect(w*d0, w*d0, 400-(w*d0)*2, 400-(w*d0)*2, 20).fill(); 
        ctx.fillStyle = "#000000";
        ctx.globalAlpha = 1;

         maxw = w - +w * (d1 * 6);

         var yposs = 0;
         
         

      



       txts.forEach(function (fall) {
       console.log(fall);
                 yposs = maketxt(ctx,fall.title,fall.text,yposs);
       });

        return x;
      }
</script>
<script>



function gen() {

const regexpSize = /^(.*)\n(.*)(\n\n|$)/gm;
const match = $("#txt").val().match(regexpSize);
console.log(match);

}

adsc


$("#add").click(function() {

var ffla = faal([
  
  {"title":Math.random()+"","text":Math.random()+""},{"title":Math.random()+"","text":Math.random()+""},{"title":Math.random()+"","text":Math.random()+""}
  
  ]);
  
  ffla.attr("data-length","14.5");
  
  $('#canvases').append(ffla);
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
 cmdx += " aaa.mp4 -y";
console.log(cmdx);
//"[0:v][1:v]overlay=0:0" \
//aaa.mp4 -y';
  $("canvas").each(function(itm) {
  console.log($(this)[0].toDataURL());

  var dt = $(this)[0].toDataURL();
$.ajax({

  type: "POST",
                        url: "gen/"+itm,
                        data: dt,
                        success:function() {
                             cmd("ls -l");   
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
