#!/usr/bin/env python

from urlparse import parse_qs

import re
import os
import sqlite3
import urllib

SQLITE_DB_PATH = 'appform.db'


def readfile(filepath):
  file_content = 'Error when reading from file: \'' + filepath + '\''
  with open(filepath, 'r') as f:
    file_content = f.read()
  return file_content


def get_response_headers(content_type):
  return [('Content-Type', content_type)]


def index(environ, start_response):
  response_body = """<!DOCTYPE html><html><body>Please type <a href="/comment">/comment</a> in the address bar to fill 
    an application form.</body></html>"""
  start_response('200 OK', get_response_headers('text/html'))
  return [response_body.encode()]


def comment(environ, start_response):
  response_body = readfile('userform.html')
  start_response('200 OK', get_response_headers('text/html'))
  return [response_body.encode()]


def not_found(environ, start_response):
  response_body = readfile('not-found.html')
  start_response('404 NOT FOUND', get_response_headers('text/html'))
  return [response_body.encode()]


def app_static(environ, start_response):
  path_info = environ['PATH_INFO']
  file_path = path_info[1:]
  if not os.path.exists(file_path):
    return not_found(environ, start_response)
  
  file_content = ''
  with open(file_path, 'r') as f:
    file_content = f.read()
  response_body = file_content

  if file_path.endswith('.css'):
    content_type = 'text/css'
  elif file_path.endswith('.js'):
    content_type = 'text/javascript'

  start_response('200 OK', get_response_headers(content_type))
  return [response_body.encode()]


def db_request(sql_statements=[], sql_scripts=[], commit_required=False):
  conn = sqlite3.connect(SQLITE_DB_PATH)
  cur = conn.cursor()

  db_responses = []
  for sql_statement in sql_statements:
    sql_instruction = sql_statement[0]
    parameters = sql_statement[1] if len(sql_statement) > 1 else ()

    db_response = cur.execute(sql_instruction, parameters)
    db_responses.append(db_response.fetchall())

  for sql_script in sql_scripts:
    cur.executescript(sql_script)

  if commit_required:
    conn.commit()

  cur.close()
  conn.close()
  return db_responses


def build_xml(main_tag, element_tag, list_of_tuples):
  xml = '<' + main_tag + '>'
  for tup in list_of_tuples:
    xml += '<' + element_tag + '>' + tup[0] + '</' + element_tag + '>'
  xml += '</' + main_tag + '>'
  return xml


def get_regions(environ, start_response):
  db_responses = db_request(
    sql_statements=[('SELECT region FROM regions', )]
  )
  regions = db_responses[0]
  regions_xml = build_xml('regions', 'region', regions)
  start_response('200 OK', get_response_headers('text/xml'))
  return [regions_xml.encode()]


def get_cities(environ, start_response):
  query_string = urllib.unquote(environ['QUERY_STRING']);
  matched = re.match(r'q=(.*)', query_string)
  selected_region = (matched.group(1).decode(), )

  db_responses = db_request(
    sql_statements=[("""SELECT city FROM cities WHERE regionid = (
      SELECT regionid FROM regions WHERE region = ?)""", selected_region)]
  )
  cities = db_responses[0]
  cities_xml = build_xml('cities', 'city', cities)
  start_response('200 OK', get_response_headers('text/xml'))
  return [cities_xml.encode()]


def post(environ, start_response):
  response_body = readfile('post.html')
  start_response('200 OK', get_response_headers('text/html'))
  return [response_body.encode()]


def wrap_none(variable):
  return variable if variable else ''


def tuple_to_map(person_data):
  person, index = {}, 0
  for key in ['personid', 'firstname', 'lastname', 'middlename', 'regionid', 'cityid', 'phone', 'email', 'comment']:
    person[key] = wrap_none(person_data[index])
    index += 1
  return person


def view(environ, start_response):
  db_responses = db_request(
    sql_statements=[('SELECT * FROM persons', )]
  )

  persons_data = db_responses[0]
  response_body = readfile('view.html')
  response_body += '<tbody>'
  line_number = 1

  for person_data in persons_data:
    person = tuple_to_map(person_data)

    db_responses = db_request(
      sql_statements=[
        ('SELECT region FROM regions WHERE regionid = ?', (person['regionid'],)),
        ('SELECT city FROM cities WHERE cityid = ?', (person['cityid'],))
      ]
    )
    region = get_single_value(db_responses[0]) if len(db_responses) > 0 else ''
    city = get_single_value(db_responses[1]) if len(db_responses) > 1 else ''

    person['region'] = region
    person['city'] = city
    person['line'] = str(line_number)
    line_number += 1

    response_body += '<tr>'
    for column in ['line', 'firstname', 'lastname', 'middlename', 'region', 'city', 'phone', 'email', 'comment']:
      response_body += '<td>' + person[column] + '</td>'
    response_body += '</tr>'

  response_body += '</tbody></table></body></html>'

  start_response('200 OK', get_response_headers('text/html'))
  return [response_body.encode()]


url_dispatches = [
  (r'/static/.*', app_static),
  (r'^/$', index),
  (r'/comment', comment),
  (r'/get_regions', get_regions),
  (r'/get_cities', get_cities),
  (r'/post', post),
  (r'/view', view)
]


checked_db_existence = False

def check_db():
  if os.path.exists('appform.db'): 
    return

  print 'creating sqlite db...'

  sqlite_script = ''
  with open('create_db.sql', 'r') as f:
    sqlite_script = f.read()

  db_request(sql_scripts=[sqlite_script], commit_required=True)

  print 'appform.db was created succesfully'  


def build_sql_insert(parsed_data):
  sql_table = 'persons(firstname, lastname'
  values = 'VALUES(?, ?'
  userdata = (parsed_data['firstname'][0], parsed_data['lastname'][0], )

  for parameter in ['middlename', 'regionid', 'cityid', 'phone', 'email', 'comment']:
    if parsed_data[parameter][0]:
      sql_table += ', ' + parameter
      values += ', ?'
      userdata += (parsed_data[parameter][0], )

  sql_table += ')'
  values += ')'  
  sql_insert = 'INSERT INTO ' + sql_table + ' ' + values
  return sql_insert, userdata


def get_single_value(db_response):
  tup = db_response[0] if len(db_response) > 0 else ('',)
  first_element = tup[0]
  return first_element


def get_area_ids(parsed_data):
  region = parsed_data['region'].pop()
  city = parsed_data['city'].pop()

  sql_commands = []
  if region:
    sql_commands.append(
      ('SELECT regionid FROM regions WHERE region = ?', (region, ))
    )
  if city:
    sql_commands.append(
      ('SELECT cityid FROM cities WHERE city = ?', (city, ))
    )

  db_responses = db_request(sql_statements=sql_commands)

  regionid = get_single_value(db_responses[0]) if len(db_responses) > 0 else ''
  cityid = get_single_value(db_responses[1]) if len(db_responses) > 1 else ''
  return regionid, cityid


def handle_post(environ):
  length = int(environ.get('CONTENT_LENGTH', '0'))
  posted_data = '' if length == 0 else environ['wsgi.input'].read(length)
  parsed_data = parse_qs(posted_data, keep_blank_values=True)

  regionid, cityid = get_area_ids(parsed_data)
  parsed_data['regionid'] = [regionid]
  parsed_data['cityid'] = [cityid]    
  sql_insert, userdata = build_sql_insert(parsed_data)

  db_request(
    sql_statements=[(sql_insert, userdata)],
    commit_required=True
  )


def app(environ, start_response):
  global checked_db_existence

  if not checked_db_existence:
    check_db()
    checked_db_existence = True

  if environ['REQUEST_METHOD'].upper() == 'POST':
    handle_post(environ)

  for url_dispatch in url_dispatches:
    pattern = url_dispatch[0]
    func = url_dispatch[1]

    if re.match(pattern, environ['PATH_INFO']):
      return func(environ, start_response)

  return not_found(environ, start_response)

