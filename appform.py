#!/usr/bin/env python

from urlparse import parse_qs
from cgi import escape

import re
import os
import sqlite3
import urllib


def index(environ, start_response):
  html = ''
  with open('userform.html', 'r') as f:
    html = f.read()
  response_body = html

  response_headers = [
    ('Content-Type', 'text/html')
  ]

  start_response('200 OK', response_headers)
  return [response_body]


def comment(environ, start_response):
  html = """
  <!DOCTYPE html>
  <html>
    <head>
      <title>Hey man! What's up? Wants some comment?</title>
    </head>
    <body>
      color picker:
      <input type="color">
    </body>
  </html>
  """
  response_body = html

  response_headers = [
    ('Content-Type', 'text/html')
  ]

  start_response('200 OK', response_headers)
  return [response_body]


def notfound(environ, start_response):
  response_headers = [
    ('Content-Type', 'text/plain')
  ]

  start_response('404 NOT FOUND', response_headers)
  return [b'NOT FOUND']


def app_static(environ, start_response):
  path_info = environ['PATH_INFO']
  file_path = path_info[1:]
  response_body = b'NOT FOUND'
  content_type = 'application/octet-stream'
  response_headers = [
      ('Content-Type', content_type)
  ]

  if os.path.exists(file_path):
    file_content = ''
    with open(file_path, 'r') as f:
      file_content = f.read()
    response_body = file_content

    if file_path.endswith('.css'):
      content_type = 'text/css'
    elif file_path.endswith('.js'):
      content_type = 'text/javascript'

    response_headers = [
      ('Content-Type', content_type)
    ]
    
    start_response('200 OK', response_headers)
    return [response_body]

  start_response('404 NOT FOUND', response_headers)
  return [response_body]


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

  response_headers = [
    ('Content-Type', 'text/xml')
  ]
  start_response('200 OK', response_headers)
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

  response_headers = [
    ('Content-Type', 'text/xml')
  ]
  start_response('200 OK', response_headers)
  return [cities_string.encode()]


url_dispatches = [
  (r'/static/.*', app_static),
  (r'^/$', index),
  (r'/comment', comment),
  (r'/get_regions', get_regions),
  (r'/get_cities', get_cities)
]


def app(environ, start_response):
  response_body_iterable = ''
  path_info = environ['PATH_INFO']

  print 'path_info=[' + path_info + ']'
  print 'query_string=[' + environ['QUERY_STRING'] + ']'

  for url_dispatch in url_dispatches:
    pattern = url_dispatch[0]
    func = url_dispatch[1]

    match = re.match(pattern, path_info)
    if match:
      response_body_iterable = func(environ, start_response)

  if len(response_body_iterable) == 0:
    response_body_iterable = notfound(environ, start_response)

  return response_body_iterable


if __name__ == '__main__':
  if os.path.exists('appform.db'):
    print 'appform.db already exists'
  else:
    print 'creating sqlite db...'
    
    sqlite_script = open('create_db.sql', 'r').read()

    connector = sqlite3.connect('appform.db')
    cursor = connector.cursor()

    cursor.executescript(sqlite_script)
    connector.commit()

    cursor.close()
    connector.close()

    print 'appform.db was created succesfully'

