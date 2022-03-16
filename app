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

const regexpSize = /^(.*)\n(.*)(\n\n|$)/gm;
const match = $("#txt").val().match(regexpSize);
console.log(match);


adsc

function add() {

mainwidth = 480;

var x = $('<canvas width="'+mainwidth+'" height="'+mainwidth+'"></canvas>');

x.attr("data-length","50");
var ctx = x[0].getContext("2d");
ctx.beginPath();
ctx.arc(100, 75, 50, 0, 2 * Math.PI);
ctx.stroke();

$("#canvases").append(x);
}
$("#add").click(function() {
  add()
});




function run() {
var cmdx = 'ffmpeg ';


var from = 0;
var to = 0;
var tot = 0;
var fcomplx  = "[1:v]loop=-1:10000:0[cov0];[cov0]scale="+mainwidth+":-1[cover];[0:v][cover]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:shortest=1[mainlayer];" ;
 $("canvas").each(function(itm) {
    var layerlength = parseInt($(this).attr("data-length"));
    
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
