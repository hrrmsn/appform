#!/usr/bin/env python

from urlparse import parse_qs

import re
import os
import sqlite3
import urllib


def get_response_headers(content_type):
  return [('Content-Type', content_type)]


def index(environ, start_response):
  response_body = """<!DOCTYPE html><html><body>Please type <a href="/comment">/comment</a> in the address bar to fill 
    an application form.</body></html>"""
  start_response('200 OK', get_response_headers('text/html'))
  return [response_body.encode()]


def comment(environ, start_response):
  response_body = 'Error when reading userform.html.'
  with open('userform.html', 'r') as f:
    response_body = f.read()
  start_response('200 OK', get_response_headers('text/html'))
  return [response_body.encode()]


def notfound(environ, start_response):
  response_body = """<!DOCTYPE html><html><body><p>Sorry, we have no idea what you're looking for.</p><p>Maybe you 
    would want to fill our awesome form. (Please follow <a href="/comment">this link</a>.)</p></body></html>"""
  start_response('404 NOT FOUND', get_response_headers('text/html'))
  return [response_body.encode()]


def app_static(environ, start_response):
  path_info = environ['PATH_INFO']
  file_path = path_info[1:]
  
  if os.path.exists(file_path):
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

  return notfound(environ, start_response)


def get_regions(environ, start_response):
  conn = sqlite3.connect('appform.db')
  cur = conn.cursor()

  regions = cur.execute('SELECT region FROM regions');

  regions_string = '<regions>'
  for region in regions:
    regions_string += '<region>' + region[0] + '</region>'
  regions_string += '</regions>'

  cur.close()
  conn.close()

  start_response('200 OK', get_response_headers('text/xml'))
  return [regions_string.encode()]


def get_cities(environ, start_response):
  query_string = urllib.unquote(environ['QUERY_STRING']);
  matched = re.match(r'q=(.*)', query_string)
  selected_region = (matched.group(1).decode(), )

  conn = sqlite3.connect('appform.db')
  cur = conn.cursor()

  cities = cur.execute('SELECT city FROM cities WHERE regionid = (SELECT regionid FROM regions WHERE region = ?)', 
    selected_region)

  cities_string = '<cities>'
  for city in cities:
    cities_string += '<city>' + city[0] + '</city>'
  cities_string += '</cities>'

  cur.close()
  conn.close()

  start_response('200 OK', get_response_headers('text/xml'))
  return [cities_string.encode()]


def post(environ, start_response):
  response_body = """<!DOCTYPE><html><body><p>Thank you for submitted form!</p><p>You can follow 
    <a href="/comment">this link</a> to fill yet another form.</body></html>"""
  start_response('200 OK', get_response_headers('text/html'))
  return [response_body.encode()]  


url_dispatches = [
  (r'/static/.*', app_static),
  (r'^/$', index),
  (r'/comment', comment),
  (r'/get_regions', get_regions),
  (r'/get_cities', get_cities),
  (r'/post', post)
]


check_db_existence = False

def check_db():
  if os.path.exists('appform.db'): 
    return

  print 'creating sqlite db...'

  sqlite_script = ''
  with open('create_db.sql', 'r') as f:
    sqlite_script = f.read()

  conn = sqlite3.connect('appform.db')
  cur = conn.cursor()
  
  cur.executescript(sqlite_script)
  conn.commit()

  cur.close()
  conn.close()

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


def handle_post(environ):
  length = int(environ.get('CONTENT_LENGTH', '0'))
  posted_data = ''
  if length != 0:
    posted_data = environ['wsgi.input'].read(length)

  parsed_data = parse_qs(posted_data, keep_blank_values=True)

  conn = sqlite3.connect('appform.db')
  cur = conn.cursor()

  regionids = cur.execute('SELECT regionid FROM regions WHERE region = \'{}\''.format(parsed_data['region'].pop()))
  regionid = ''
  for regid in regionids:
    regionid = regid[0]

  cityids = cur.execute('SELECT cityid FROM cities WHERE city = \'{}\''.format(parsed_data['city'].pop()))
  cityid = ''
  for townid in cityids:
    cityid = townid[0]

  parsed_data['regionid'] = [regionid]
  parsed_data['cityid'] = [cityid]    
  sql_insert, userdata = build_sql_insert(parsed_data)

  cur.execute(sql_insert, userdata)

  conn.commit()

  cur.close()
  conn.close()


def app(environ, start_response):
  global check_db_existence

  if not check_db_existence:
    check_db()
    check_db_existence = True

  if environ['REQUEST_METHOD'].upper() == 'POST':
    handle_post(environ)

  for url_dispatch in url_dispatches:
    pattern = url_dispatch[0]
    func = url_dispatch[1]

    if re.match(pattern, environ['PATH_INFO']):
      return func(environ, start_response)

  return notfound(environ, start_response)

