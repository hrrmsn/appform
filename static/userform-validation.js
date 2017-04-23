// validate required inputs
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


// load regions and corresponding cities by ajax
var regionDatalist = document.getElementById('regions');

window.addEventListener('load', function() {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var regionsXML = this.responseXML.getElementsByTagName('region');
      for (var i = 0; i < regionsXML.length; i++) {
        var optionElement = document.createElement('option');
        var region = regionsXML[i].childNodes[0].nodeValue;
        optionElement.setAttribute('value', region);
        regionDatalist.appendChild(optionElement);
      }
    }
  };
  xhttp.open('GET', 'get_regions', true);
  xhttp.send();
});

var regionInput = document.getElementById('reg');

regionInput.addEventListener('mousedown', function(e) {
  e.target.value = '';
});

regionInput.addEventListener('change', function(e) {
  var selectedRegion = e.target.value;
  if (selectedRegion == '') return;

  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var cities = document.getElementById('cities');
      while (cities.firstChild) {
        cities.removeChild(cities.firstChild);
      }

      var citiesXML = this.responseXML.getElementsByTagName('city');
      for (var i = 0; i < citiesXML.length; i++) {
        var optionElement = document.createElement('option');
        var city = citiesXML[i].childNodes[0].nodeValue;
        optionElement.setAttribute('value', city);
        cities.appendChild(optionElement);
      }
    }
  };
  xhttp.open('GET', 'get_cities?q=' + selectedRegion, true);
  xhttp.send();
});

var citiesInput = document.getElementById('city_id');

citiesInput.addEventListener('mousedown', function(e) {
  e.target.value = '';
});

