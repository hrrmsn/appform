// Variable declarations are here.
var validityMessages = {
  'first_name': 'First name should not be empty.',
  'last_name': 'Last name should not be empty.',
  'message': 'Comment should not be empty.'
}

var firstNameInput = document.getElementById('first_name');
var lastNameInput = document.getElementById('last_name');
var commentTextArea = document.getElementById('message');

var regions = document.getElementById('regions');

var regionInput = document.getElementById('reg');
var citiesInput = document.getElementById('city_id');


// Function declarations are here.
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

function populateDatalistByXML(datalist, xmlData) {
  for (var i = 0, len = xmlData.length; i < len; i++) {
    var optionElement = document.createElement('option');
    var optionValue = xmlData[i].childNodes[0].nodeValue;
    optionElement.setAttribute('value', optionValue);
    datalist.appendChild(optionElement);
  }
}


// Add event listeners here.
addEventListenerToInput(firstNameInput);
addEventListenerToInput(lastNameInput);
addEventListenerToInput(commentTextArea);

window.addEventListener('load', function() {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var regionsXML = this.responseXML.getElementsByTagName('region');
      populateDatalistByXML(regions, regionsXML);
    }
  };
  xhttp.open('GET', 'get_regions', true);
  xhttp.send();
});

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
      populateDatalistByXML(cities, citiesXML);
    }
  };
  xhttp.open('GET', 'get_cities?q=' + selectedRegion, true);
  xhttp.send();
});

citiesInput.addEventListener('mousedown', function(e) {
  e.target.value = '';
});
