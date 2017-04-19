#!/usr/bin/env python

from urlparse import parse_qs
from cgi import escape

import re
import os
import sqlite3


def index(environ, start_response):
  pass


def comment(environ, start_response):
  html = """
  <!DOCTYPE html>
  <html>
    <head>
      <title>Hey man! What's up?</title>
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
  return ['NOT FOUND']


url_dispatches = [
  (r'/comment', comment)
]


def app(environ, start_response):
  response_body_iterable = ''
  path_info = environ['PATH_INFO']

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

    print 'db was created succesfully'

