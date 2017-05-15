#!/usr/bin/env python

from urlparse import parse_qs

import re
import os
import sqlite3
import urllib

SQLITE_DB_PATH = 'appform.db'
MIN_COMMENTS_NUMBER_BY_REGION = 5


def readfile(filepath):
  file_content = 'Error when reading from file: \'' + filepath + '\''
  with open(filepath, 'r') as f:
    file_content = f.read()
  return file_content


def get_response_headers(content_type):
  return [('Content-Type', content_type)]


def index(environ, start_response):
  response_body = readfile('static/html/index.html')
  start_response('200 OK', get_response_headers('text/html'))
  return [response_body.encode()]


def comment(environ, start_response):
  response_body = readfile('static/html/userform.html')
  start_response('200 OK', get_response_headers('text/html'))
  return [response_body.encode()]


def not_found(environ, start_response):
  response_body = readfile('static/html/not-found.html')
  start_response('404 NOT FOUND', get_response_headers('text/html'))
  return [response_body.encode()]


def static(environ, start_response):
  path_info = environ['PATH_INFO']
  file_path = path_info[1:]
  if not os.path.exists(file_path):
    return not_found(environ, start_response)

  if file_path.endswith('.css'):
    content_type = 'text/css'
  elif file_path.endswith('.js'):
    content_type = 'text/javascript'
  elif file_path.endswith('.html'):
    content_type = 'text/html'
  elif file_path.endswith('.jpg'):
    content_type = 'image/jpeg'
  elif file_path.endswith('.ico'):
    content_type = 'image/x-icon'

  response_body = readfile(file_path)
  if not content_type in ['image/jpeg', 'image/x-icon']:
    response_body = response_body.encode()

  start_response('200 OK', get_response_headers(content_type))
  return [response_body]


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
    sql_statements=[("""SELECT region FROM regions""", )]
  )
  regions = db_responses[0]
  regions_xml = build_xml('regions', 'region', regions)
  start_response('200 OK', get_response_headers('text/xml'))
  return [regions_xml.encode('utf-8')]


def get_cities(environ, start_response):
  query_string = urllib.unquote(environ['QUERY_STRING']);
  matched = re.match(r'q=(.*)', query_string)
  selected_region = (matched.group(1).decode(), )

  sql_command = """
    SELECT city 
      FROM cities 
     WHERE regionid = 
           (SELECT regionid 
              FROM regions 
             WHERE region = ?)"""

  db_responses = db_request(
    sql_statements=[(sql_command, selected_region)]
  )
  cities = db_responses[0]
  cities_xml = build_xml('cities', 'city', cities)
  start_response('200 OK', get_response_headers('text/xml'))
  return [cities_xml.encode()]


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


def delete_comments(environ, start_response):
  query_string = urllib.unquote(environ['QUERY_STRING'])
  parsed_query = parse_qs(query_string)

  sql_commands = []
  for rowid in parsed_query['rowid']:
    sql_query = """UPDATE persons SET comment=\'\' WHERE personid=?"""
    sql_params = (rowid, )
    sql_commands.append((sql_query, sql_params))

  db_request(sql_statements=sql_commands, commit_required=True)

  start_response('200 OK', get_response_headers('text/html'))
  return [b'']


def regions_table(db_response):
  stat_table = '<br><table class="regions">'

  stat_table += '<caption>'
  stat_table += 'Regions with amount of comments more than {}'.format(MIN_COMMENTS_NUMBER_BY_REGION)
  stat_table += '</caption>'

  stat_table += '<thead>'
  stat_table += '<tr>'
  stat_table += '<th class="row-id">#</th>'
  stat_table += '<th class="row-region">Region</th>'
  stat_table += '<th class="row-comments-number">Comments number</th>'
  stat_table += '</tr>'
  stat_table += '</thead>'
  stat_table += '<tbody>'

  line_number = 0
  for region_info in db_response:
    line_number += 1
    region = region_info[0]
    comments_number = region_info[1]
    stat_table += '<tr>'
    stat_table += '<td>' + str(line_number) + '</td>'
    stat_table += '<td><a href="stat?region={}">'.format(region) + region + '</a></td>'
    stat_table += '<td>' + str(comments_number) + '</td>'
    stat_table += '</tr>'
  stat_table += '</tbody></table>'
  return stat_table  


def stat_all_regions(environ, start_response):
  sql_command = """
      SELECT (SELECT region 
                FROM regions 
               WHERE regions.regionid = persons.regionid) AS region_name, 
             count(comment) AS comments_number 
        FROM persons 
       WHERE comment != '' 
    GROUP BY region_name 
      HAVING comments_number > ?"""

  db_responses = db_request(
    sql_statements=[
      (sql_command, (MIN_COMMENTS_NUMBER_BY_REGION, ))
    ]
  )

  db_response = db_responses[0]
  response_body = readfile('static/html/stat-all-regions.html')
  if not db_response:
    instead_of_table = """<br><p>Sorry, there are no regions with amount of comments more than {}.</p>""".format(
      str(MIN_COMMENTS_NUMBER_BY_REGION))
    response_body = response_body.format(**{'table': instead_of_table})

    start_response('200 OK', get_response_headers('text/html'))
    return [response_body.encode()]

  response_body = response_body.format(**{'table': regions_table(db_response)})

  start_response('200 OK', get_response_headers('text/html'))
  return [response_body.encode()]


def cities_table(db_response, region):
  cities_table = '<br><table class="cities">'
  cities_table += '<caption>'
  cities_table += 'Comments by cities of ' + region
  cities_table += '</caption>'
  cities_table += '<thead>'
  cities_table += '<tr>'
  cities_table += '<th class="row-id">#</th>'
  cities_table += '<th class="row-city">City</th>'
  cities_table += '<th class="row-comments-number">Comments number</th>'
  cities_table += '</tr>'
  cities_table += '<tbody>'

  line_number = 0
  for city_info in db_response:
    city = city_info[0]
    comments_number = city_info[1]
    line_number += 1

    cities_table += '<tr>'
    cities_table += '<td>' + str(line_number) + '</td>'
    cities_table += '<td>' + city + '</td>'
    cities_table += '<td>' + str(comments_number) + '</td>'
    cities_table += '</tr>'

  cities_table += '</tbody></table>' 
  return cities_table


def stat_one_region(environ, start_response):
  query_string = urllib.unquote(environ['QUERY_STRING'])
  parsed_query = parse_qs(query_string)

  region = parsed_query['region'].pop()

  sql_command = """
      SELECT (SELECT city 
                FROM cities 
               WHERE cities.cityid = persons.cityid) AS city, 
             count(comment)
        FROM persons 
       WHERE persons.regionid = 
             (SELECT regionid 
                FROM regions 
               WHERE regions.region = ?)
         AND persons.comment != ''
    GROUP BY city"""
  params = (region, )
  db_responses = db_request(
    sql_statements=[(sql_command, params)]
  )
  db_response = db_responses[0]

  response_body = readfile('static/html/stat-one-region.html')
  if not db_response:
    title = 'No comments are found'
    table = '<br><p>Sorry, there are no comments for the cities of the specified region.</p>'
    response_body = response_body.format(**{'title': title, 'table': table})

    start_response('200 OK', get_response_headers('text/html'))
    return [response_body.encode()]

  response_body = response_body.format(
    **{'title': 'Cities of ' + region, 'table': cities_table(db_response, region)}
  )

  start_response('200 OK', get_response_headers('text/html'))
  return [response_body.encode()]


def stat(environ, start_response):
  if environ['QUERY_STRING']:
    return stat_one_region(environ, start_response)
  return stat_all_regions(environ, start_response)


url_dispatches = [
  (r'/static/.*', static),
  (r'/$', index),
  (r'/comment$', comment),
  (r'/get_regions$', get_regions),
  (r'/get_cities$', get_cities),
  (r'/view$', view),
  (r'/delete_comments$', delete_comments),
  (r'/stat$', stat)
]


checked_db_existence = False

def check_db():
  if os.path.exists('appform.db'): 
    return

  print 'creating sqlite db...'

  sqlite_script = readfile('static/sqlite/create.sql')
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
  tup = db_response[0] if len(db_response) > 0 else ('', )
  first_element = tup[0]
  return first_element


def get_area_ids(parsed_data):
  region = parsed_data['region'].pop()
  city = parsed_data['city'].pop()

  sql_commands = []
  if region:
    sql_commands.append(
      ("""SELECT regionid FROM regions WHERE region = ?""", (region, ))
    )
  if city:
    sql_commands.append(
      ("""SELECT cityid FROM cities WHERE city = ?""", (city, ))
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
