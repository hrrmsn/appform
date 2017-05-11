// Variable declarations are here.
var numberOfCommentsToDelete = 0;

var checkboxes = document.querySelectorAll('input');
var selectedCommentsLabel = document.querySelector('label');

var people = document.getElementById('people');
var selectAllCommentsButton = document.getElementById('select-all');
var unselectAllCommentsButton = document.getElementById('unselect-all');
var deleteAllSelectedCommentsButton = document.getElementById('delete-comments');


// Function declarations are here.
function selectedCommentsString(selectedCommentsNumber) {
  if (selectedCommentsNumber === 0) {
    return '';
  } else if (selectedCommentsNumber === 1) {
    return '1 row is marked to delete';
  } 
  return selectedCommentsNumber + ' rows are marked to delete';
}

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

function sendAjaxRequest(rowids, checkboxesToDisable) {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      for (var i = 0, len = checkboxesToDisable.length; i < len; i++) {
        var checkboxToDisable = checkboxesToDisable[i];
        checkboxToDisable.disabled = true;

        var commentIndexes = getCommentIndexes(checkboxToDisable);
        var row = commentIndexes['row'];
        var column = commentIndexes['column'];
        people.rows[row].cells[column].innerHTML = '<i>N/A</i>';
      }
    }
  };
  xhttp.open('GET', 'delete_comments?' + rowids, true);
  xhttp.send();
}

function extractRowidsAndCheckboxesToDisable(checkboxes) {
  var rowids = '';
  var checkboxesToDisable = [];
  for (var i = 0, len = checkboxes.length; i < len; i++) {
    var checkbox = checkboxes[i];
    if (checkbox.checked === false) {
      continue;
    }
    rowids += 'rowid=' + extractRowid(checkbox.name);
    if (i < len - 1) {
      rowids += '&';
    }
    checkboxesToDisable.push(checkbox);
  }
  return {
    rowids: rowids,
    checkboxesToDisable: checkboxesToDisable
  }  
}

function selectAllComments() {
  numberOfCommentsToDelete = checkboxes.length;
  var selectedCheckboxesNumber = allCheckboxesToNewState('checked');
  selectedCommentsLabel.textContent = selectedCommentsString(selectedCheckboxesNumber);
}

function unselectAllComments() {
  numberOfCommentsToDelete = 0;
  selectedCommentsLabel.textContent = '';
  allCheckboxesToNewState('unchecked');
}

function allCheckboxesToNewState(newState) {
  var enabledCheckboxesNumber = 0;
  for (var i = 0, len = checkboxes.length; i < len; i++) {
    var checkbox = checkboxes[i];
    if (checkbox.disabled) {
      continue;
    }
    enabledCheckboxesNumber++;
    checkbox.checked = (newState === 'checked');
  }
  return enabledCheckboxesNumber;
}


// Add event listeners here.
for (var i = 0, len = checkboxes.length; i < len; i++) {
  var checkbox = checkboxes[i];
  checkbox.addEventListener('change', function(e) {
    if (e.target.checked) { 
      numberOfCommentsToDelete++;
    } else {
      numberOfCommentsToDelete--;
    }
    selectedCommentsLabel.textContent = selectedCommentsString(numberOfCommentsToDelete);
  });
}

selectAllCommentsButton.addEventListener('click', function(e) {
  selectAllComments();
});

unselectAllCommentsButton.addEventListener('click', function(e) {
  unselectAllComments();
});

deleteAllSelectedCommentsButton.addEventListener('click', function(e) {
  if (numberOfCommentsToDelete === 0) {
    alert('Nothing is marked to delete. Please select comments that you would want to remove.');
    return;
  } else if (confirm('Are you sure that you want to delete selected comments?') === false) {
    unselectAllComments();
    return;
  }
  var extracted = extractRowidsAndCheckboxesToDisable(checkboxes);
  sendAjaxRequest(extracted['rowids'], extracted['checkboxesToDisable']);
  unselectAllComments();
  alert('Comments were deleted.');
});