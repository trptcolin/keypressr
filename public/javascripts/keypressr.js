var active = false;

function checkForm() {
  var finished = false;
  
  var correct_start = "<span class='correct'>";
  var correct_end = "</span><span class='incorrect'>";
  
  var end_location = 0;
  var given_position = 0;
  
  var text_received = $("#response-text").val();
  text_received = text_received.replace(/[ \t]+(\r\n|[\r\n])/g, "$1");
  
  var example_text = $("#example-text").val();
	example_text = example_text.replace(/[ \t]+(\r\n|[\r\n])/g, "$1");

  
  var shortest = ((example_text.length < text_received.length) ? example_text : text_received);
  
  for(i = 0; i < shortest.length; i++){
      if(example_text[i] == text_received[given_position]){ end_location += 1; }
      else{ break; }
      given_position += 1;    
  }
  
  if(end_location > 0) {
    example_text_first = example_text.slice(0, end_location);
    
    if(end_location < example_text.length){
      example_text_last = example_text.slice(end_location, example_text.length);
    }
    else{ 
      example_text_last = ""; 
    }    
  }else{
    example_text_first = "";
    example_text_last = example_text;
  }
  
  example_text_first = example_text_first.replace(/</g, "&lt;").replace(/>/g, "&gt;");
  example_text_last = example_text_last.replace(/</g, "&lt;").replace(/>/g, "&gt;");
  
  example_text = correct_start + example_text_first + correct_end + example_text_last + "</span>";

  $("#test-text").html(example_text);  
  $("#test-text").scrollTo(".incorrect", {offset: -50});
  
  if(active && example_text_last.match(/^\s*$/)){
  	active = false;
    var str = $("form").serialize();
    $.post("/main/check", str, function(data){
        $("#results").html(data);          
    });
    $("#time-elapsed").stopTime("test_done");
    $("#time-elapsed").html("");
  }
  else{
    // $("#results").html("");
		// active = true;
    
  }
}

$(document).ready(function(){

  $( "form" )[ 0 ].reset();
  
  $("textarea#response-text").keyup(checkForm);
  checkForm();

  $("#test-text").bind("contextmenu",function(e){ return false; });
  
  $("#time-elapsed").everyTime(1000, 'test_done', function(i) {
  	active = true;
  	
    var seconds = "" + (i % 60);      
    var temp = (i-seconds) / 60;
    var minutes = "" + (temp % 60);
    var hours = "" + (((temp-minutes) / 60) % 60)
        
    if(seconds.length < 2){
      seconds = "0" + seconds;
    }
  
    if(hours != "0"){
      hours += ":"
      if(minutes.length < 2 ){
        minutes = "0" + minutes;
      }
    }else{
      hours = ""
    }
  
    $(this).html(hours + minutes + ":" +seconds);
  });

});
