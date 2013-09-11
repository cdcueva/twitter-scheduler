function polling(jid, status, jqXHR, complete) {
  if (complete) {
    return true
  }
  else {
    $.get('/status/' + jid, function(response){
      if (response === 'true') complete = response;
      setTimeout(polling, 1000, jid, status, jqXHR, complete)
    })
  }
};



function getJobId(event){
  event.preventDefault();
  var url = $(this).attr("action")
  var data = $(this).serialize()
  $.post(url, data, polling)
}

$(document).ready(function() {
  $("#tweet").submit(getJobId)

});


