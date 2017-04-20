var validityMessages = {
  'first_name': 'First name should not be empty.',
  'last_name': 'Last name should not be empty.',
  'message': 'Comment should not be empty.'
}

function addEventListenerToInput(inputElement) {
  inputElement.addEventListener('invalid', function(e){
    if (!e.target.validity.valid) {
      e.target.setCustomValidity(validityMessages[inputElement.id]);
    }
  });

  inputElement.addEventListener('input', function(e){
    e.target.setCustomValidity('');
  });
}

var firstNameInput = document.getElementById('first_name');
var lastNameInput = document.getElementById('last_name');
var commentTextArea = document.getElementById('message');

addEventListenerToInput(firstNameInput);
addEventListenerToInput(lastNameInput);
addEventListenerToInput(commentTextArea);


// playing with AJAX
window.addEventListener('load', function() {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      alert(this.responseText);
    }
  };
  xhttp.open('GET', 'my_text_file.txt', true);
  xhttp.send();
});
