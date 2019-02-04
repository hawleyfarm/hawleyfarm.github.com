// Header logo animation

var s = Snap('#altg-logo');
var g = s.group();

var bracket = s.select("#bracket1");
var bracket2 = s.select("#bracket2");

function translateMe(element, position, time) {
  element.animate({transform: 't'+position+''}, time);
}

function openBrackets() {
  translateMe(bracket, "-10", 300);
  translateMe(bracket2, "10",  300);
}

function closeBrackets() {
  translateMe(bracket, "0", 300);
  translateMe(bracket2, "0",  300);
}

s.hover(openBrackets, closeBrackets);


$liveView = $(".live-view");

function ohNo(){
  console.log("ohno");
  $(".ohno").fadeIn(300, function(){ $(this).show();});
}

function showLoading($parent){
  $($parent).find(".loading").fadeIn(500, function(){ $(this).show(); $($parent).find(".inner").addClass("on-loading"); });
}

function hideLoading($parent, $time){
  $($parent).find(".loading").fadeOut($time, function(){ $(this).hide(); $($parent).find(".on-loading").removeClass("on-loading"); });
}

function openLiveView($e){
  $url = $e.data("url");
  $liveView.find("input").val($url);
  $liveView.find(".external-url").attr("href",$url);
  $liveView.find("iframe").attr("src", $url);
  $liveView.fadeIn(300, function(){ $(this).removeClass("hidden").show().addClass("active"); });
  hideLoading($liveView, 2500)
}

function closeLiveView(){
  console.log("called");
  $(".live-view.active").fadeOut(300, function(){
     $(this).hide();
     resetLiveView();
   });
}

function resetLiveView() {
  showLoading($liveView);
  $liveView.removeClass("active");
}

$maxBirds = 20;
$birdsDuration = 10;
$birdsMinDuration = 5;
$birdsMaxDuration = 15;

function createBirds($num){
  //console.log("Creating birds..");
  if(countBirds() < $maxBirds) {
  for (var i = 0; i < $num; i++) {
    $bird = $('<div class="bird-container"> <div class="bird"></div></div>');
    $top = Math.floor((Math.random() * 60) + 1);
    $animDelay = Math.random() * (1 - -1) + -1;
    $bird.css("top", $top+"%").css("-webkit-animation-delay", $animDelay+"s").css("animation-delay", $animDelay+"s");;
    $(".birds").append($bird); 
  }
  updateBirdsInfo()
  }
}

function updateBirdsInfo(){
  $(".birdsTotal").text(countBirds());
  $(".birdsSpeed").text($birdsDuration);

}

function countBirds(){
  return $(".bird").length
}
function killBird($bird){
  console.log("shot");
  $bird.find(".bird").remove();
  $bird.append('<img src="https://res.cloudinary.com/gonzalobonini/image/upload/v1545383682/portfolio/explosion.gif" alt="">');
  $bird.fadeOut(300, function(){$($bird).remove(); });
  updateBirdsInfo();
}

function birdChangeSpeed($val) {
  $newDuration = $birdsDuration + $val;
  $birdsDuration = clamp($birdsMinDuration, $birdsMaxDuration, $newDuration);
  $(".bird-container").css("animation-duration", $birdsDuration+"s").css("@-webkit-animation-duration", $birdsDuration+"s");
  updateBirdsInfo();
}

function clamp(minValue, maxValue, value) {
  return Math.max(minValue, Math.min(maxValue, value));
}

$(function() {

  if($(".index-hero").length && $(window).width() > 960) {
    console.log("is index");
    var wWidth = $(window).width();
    var wHeight = $(window).height();
    var navHeight = $(".main-nav").height();
    var heroHeight = wHeight - navHeight;
    $(".index-hero").height(heroHeight);
    createBirds(5);
  }

  if(localStorage.getItem('lightsOn')  == 1) {
      $("body").addClass("light");
  }



  $(".switch-lights").click(function(event){
    event.preventDefault();
    var lightsState = (localStorage.getItem('lightsOn') == 1) ? 0 : 1;
    localStorage.setItem('lightsOn', lightsState);
    $("body").toggleClass("light");
  });

  $(".birds-add").click(function(event){
    event.preventDefault();
    createBirds(1);
  });

  $(".birds-kill").on("click", function(event){
    event.preventDefault();
    killBird($(".bird-container").first().remove());
  });

  $(".bird-container").click(function(event){
    killBird($(this));
  });

  $(".birds-faster").click(function(event){
    event.preventDefault();
    birdChangeSpeed(-1);
  });

  $(".birds-slower").click(function(event){
    event.preventDefault();
    birdChangeSpeed(1);
  });

  $('body').removeClass('fade-out');

  $( ".framework" ).hover(
  function() {
      $( this ).parent().find(".framework-caption").text( $( this ).data("caption") );
    }, function() {
      $( this ).parent().find(".framework-caption").text( "" );
    }
  );

  $(".remove-me .close-project").click(function(){
      $(this).parents(".remove-me").fadeOut(300, function(){
         $(this).remove();
         if( !$(".project-list-item").length ) {
           ohNo();
         }
       });
  });

  $("body").click(function(){
      closeLiveView();
    });

    $(".live-view").click(function(e){
      e.stopPropagation();
    });


    $(".live-view .close-project").click(function(){
      console.log("close from bar");
      closeLiveView();
    });


  $(".open-liveview").click(function(event){
      event.preventDefault();
      openLiveView($(this));

   });

   $('.live-view.active iframe').on('load', () => {
     hideLoading(".live-view");
   });

   $(".scroll").click(function(event){
		event.preventDefault();
		$('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
	});

  // Contact form

  $( ".name-input" ).keyup(function() {
    $(".the-name").text($(this).val())
  });

});
