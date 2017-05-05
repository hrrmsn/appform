var checkboxes = document.querySelectorAll('input');

var checkedCounter = 0;
var selectedRowsLabel = document.querySelector('label');

var len = checkboxes.length;

function selectedRowsString(checked) {
  if (checked === 0) {
    return '';
  } else if (checked === 1) {
    return '1 row is marked to delete';
  } 
  return checked + ' rows are marked to delete';
}

for (var i = 0, len = checkboxes.length; i < len; i++) {
  var checkbox = checkboxes[i];
  checkbox.addEventListener('change', function(e) {
    if (e.target.checked) { 
      checkedCounter++;
    } else {
      checkedCounter--;
    }
    selectedRowsLabel.textContent = selectedRowsString(checkedCounter);
  });
}


var selectAllCommentsButton = document.getElementById('select-all');
selectAllCommentsButton.addEventListener('click', function(e) {
  for (var i = 0, len = checkboxes.length; i < len; i++) {
    var checkbox = checkboxes[i];
    checkbox.checked = true;
  }
  checkedCounter = checkboxes.length;
  selectedRowsLabel.textContent = selectedRowsString(checkedCounter);
});


var unselectAllCommentsButton = document.getElementById('unselect-all');
unselectAllCommentsButton.addEventListener('click', function(e) {
  for (var i = 0, len = checkboxes.length; i < len; i++) {
    var checkbox = checkboxes[i];
    checkbox.checked = false;
  }
  checkedCounter = 0;
  selectedRowsLabel.textContent = '';
});


function extractRowid(rowid_string) {
  var re = /rowid-(\d+)/;
  var matches = rowid_string.match(re);
  return matches[1];
}

function getCheckboxIndexes(checkbox) {
  var checkboxCell = checkbox.parentElement;
  var checkboxCellIndex = checkboxCell.cellIndex;
  var checkboxRowIndex = checkboxCell.closest('tr').rowIndex;
  return {
    column: checkboxCellIndex,
    row: checkboxRowIndex
  }
}

function getCommentIndexes(checkbox) {
  var checkboxIndexes = getCheckboxIndexes(checkbox);
  return {
    column: checkboxIndexes['column'] - 1,
    row: checkboxIndexes['row']
  }
}


var people = document.getElementById('people');

function sendAjaxRequest(rowids, commentIndexes) {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      for (var i = 0, len = commentIndexes.length; i < len; i++) {
        var row = commentIndexes[i]['row'];
        var column = commentIndexes[i]['column'];
        people.rows[row].cells[column].innerHTML = '';
      }
    }
  };
  xhttp.open('GET', 'delete_comments?' + rowids, true);
  xhttp.send();
}


var deleteAllSelectedCommentsButton = document.getElementById('delete-comments');
deleteAllSelectedCommentsButton.addEventListener('click', function(e) {
  if (checkedCounter === 0) {
    alert('Nothing is marked to delete. Please select comments that you would want to remove.');
    return;
  } else if (confirm('Are you sure that you want to delete selected comments?') === false) {
    checkedCounter = 0;
    selectedRowsLabel.textContent = '';
    return;
  }
  var rowids = '';
  var commentIndexes = [];
  for (var i = 0, len = checkboxes.length; i < len; i++) {
    var checkbox = checkboxes[i];
    if (checkbox.checked === false) {
      continue;
    }
    checkbox.checked = false;
    var rowid = extractRowid(checkbox.name);
    rowids += 'rowid=' + rowid;
    if (i < len - 1) {
      rowids += '&';
    }
    commentIndexes.push(getCommentIndexes(checkbox));
  }

  sendAjaxRequest(rowids, commentIndexes);

  alert('Comments were deleted.');

  checkedCounter = 0;
  selectedRowsLabel.textContent = '';
});