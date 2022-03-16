<!doctype html><html>
  <head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
     canvas {border:1px solid}
     </style>
  </head>
  <body>

<div id="canvases" style="width:100%;;border:1px solid black">
</div>

<button id="add">
  add
</button>
<script>
function add() {
var x = $('<canvas width="90" height="90"></canvas>');

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

add();add();add()


function run() {
var cmdx = 'ffmpeg ';


var from = 0;
var to = 0;
var tot = 0;
var fcomplx  = "" ;
 $("canvas").each(function(itm) {
    var layerlength = parseInt($(this).attr("data-length"));
    
    tot = tot+layerlength;
    
    
    to = to+layerlength;
    if (itm === 0) {
     var mainlayer = '[0:v]';
    } else {
     var mainlayer = '[layer'+(itm-1)+']';
    }
    
   
    if (itm != $("canvas").length-1) {
    var layername = '[layer'+itm+'];';
    } else {
    var layername = "";
    }
    
    fcomplx += mainlayer+'[1:v]overlay=0:0:enable=\'between(t,'+from+','+to+')\''+layername; 
    from = to;
    
    
    
 });
 
 
cmdx += '-t '+tot+' -f lavfi -i color=c=white:s=480x480 -pix_fmt yuv420p '
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
