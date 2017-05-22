#!/usr/bin/env python

from tools import get_response_headers
from tools import db_request
from tools import readfile
from tools import get_single_value


# Helper functions are here.

def wrap_none(variable):
  return variable if variable else ''


def tuple_to_map(person_data):
  person, index = {}, 0
  for key in ['personid', 'firstname', 'lastname', 'middlename', 'regionid', 'cityid', 'phone', 'email', 'comment']:
    person[key] = wrap_none(person_data[index])
    index += 1
  return person


def users_table_body(persons_data):
  table_body = '<tbody>'
  line_number = 1

  for person_data in persons_data:
    person = tuple_to_map(person_data)

    db_responses = db_request(
      sql_statements=[
        ("""SELECT region FROM regions WHERE regionid = ?""", (person['regionid'], )),
        ("""SELECT city FROM cities WHERE cityid = ?""", (person['cityid'], ))
      ]
    )
    region = get_single_value(db_responses[0]) if len(db_responses) > 0 else ''
    city = get_single_value(db_responses[1]) if len(db_responses) > 1 else ''

    person['region'], person['city'] = region, city
    person['line'] = str(line_number)
    line_number += 1

    table_body += '<tr>'
    for column in ['line', 'firstname', 'lastname', 'middlename', 'region', 'city', 'phone', 'email']:
      table_body += '<td>{}</td>'.format(person[column])

    if person['comment']:
      table_body += '<td>{}</td>'.format(person['comment'])
      table_body += '<td><input type="checkbox" name="rowid-{}"></td>'.format(person['personid'])
    else:
      table_body += '<td><i>N/A</i></td>'
      table_body += '<td><input type="checkbox" name="rowid-{}" disabled></td>'.format(person['personid'])

    table_body += '</tr>'

  table_body += '</tbody>'
  return table_body 


# URL-dispatching function.

def view(environ, start_response):
  db_responses = db_request(
    sql_statements=[("""SELECT * FROM persons""", )]
  )

  persons_data = db_responses[0]
  if not persons_data:
    response_body = readfile('static/html/no-data-view.html')
    start_response('200 OK', get_response_headers('text/html'))
    return [response_body.encode()]

  response_body = readfile('static/html/view.html')
  html_data = {
    'tbody': users_table_body(persons_data), 
    'script': '<script src="static/js/view.js"></script>'
  }
  response_body = response_body.format(**html_data)

  start_response('200 OK', get_response_headers('text/html'))
  return [response_body.encode()]