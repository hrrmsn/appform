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
  html = ''
  with open('userform.html', 'r') as f:
    html = f.read()
  response_body = html
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
    return [response_body]

  return notfound(environ, start_response)


def get_regions(environ, start_response):
  connector = sqlite3.connect('appform.db')
  cursor = connector.cursor()

  regions = cursor.execute('SELECT region FROM regions');

  regions_string = '<regions>'
  for region in regions:
    regions_string += '<region>' + region[0] + '</region>'
  regions_string += '</regions>'

  cursor.close()
  connector.close()

  start_response('200 OK', get_response_headers('text/xml'))
  return [regions_string.encode()]


def get_cities(environ, start_response):
  query_string = urllib.unquote(environ['QUERY_STRING']);
  matched = re.match(r'q=(.*)', query_string)
  selected_region = (matched.group(1).decode(), )

  conn = sqlite3.connect('appform.db')
  c = conn.cursor()

  cities = c.execute('SELECT city FROM cities WHERE regionid = (SELECT regionid FROM regions WHERE region = ?)', 
    selected_region)

  cities_string = '<cities>'
  for city in cities:
    cities_string += '<city>' + city[0] + '</city>'
  cities_string += '</cities>'

  c.close()
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
  if os.path.exists('appform.db'): return

  print 'creating sqlite db...'

  sqlite_script = open('create_db.sql', 'r').read()
  conn = sqlite3.connect('appform.db')
  c = conn.cursor()
  
  c.executescript(sqlite_script)
  conn.commit()

  c.close()
  conn.close()

  print 'appform.db was created succesfully'  


def handle_post(environ):
  length = int(environ.get('CONTENT_LENGTH', '0'))
  if length != 0:
    posted_data = environ['wsgi.input'].read(length)

  parsed_data = parse_qs(posted_data, keep_blank_values=True)

  conn = sqlite3.connect('appform.db')
  c = conn.cursor()

  regionids = c.execute('SELECT regionid FROM regions WHERE region = \'{}\''.format(parsed_data['region'].pop()))
  regionid = ''
  for regid in regionids:
    regionid = regid[0]

  cityids = c.execute('SELECT cityid FROM cities WHERE city = \'{}\''.format(parsed_data['city'].pop()))
  cityid = ''
  for townid in cityids:
    cityid = townid[0]

  c.execute("""INSERT INTO persons(firstname, lastname, middlename, regionid, cityid, phone, email, comment) 
    VALUES(\'{firstName}\', \'{lastName}\', \'{middleName}\', {regionId}, {cityId}, \'{phone}\', \'{email}\', 
    \'{comment}\')""".format(
      firstName=parsed_data['firstName'].pop(), 
      lastName=parsed_data['lastName'].pop(), 
      middleName=parsed_data['middleName'].pop(),
      regionId=regionid,
      cityId=cityid,
      phone=parsed_data['phone'].pop(),
      email=parsed_data['email'].pop(),
      comment=parsed_data['comment'].pop()))

  conn.commit()

  c.close()
  conn.close()


def app(environ, start_response):
  global check_db_existence

  if not check_db_existence:
    check_db()
    check_db_existence = True

  if environ['REQUEST_METHOD'].upper() == 'POST':
    handle_post(environ)

  response_body_iterable = ''

  for url_dispatch in url_dispatches:
    pattern = url_dispatch[0]
    func = url_dispatch[1]

    if re.match(pattern, environ['PATH_INFO']):
      return func(environ, start_response)

  return notfound(environ, start_response)

