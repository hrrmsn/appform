#!/usr/bin/env python

import re
import os

from tools import get_response_headers
from tools import readfile
from tools import db_request

from view import view
from post import handle_post
from stats import stats
from get_areas import get_regions
from get_areas import get_cities


# URL-dispatching functions are here.

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


def delete_comments(environ, start_response):
  from urllib import unquote
  from urlparse import parse_qs

  query_string = unquote(environ['QUERY_STRING'])
  parsed_query = parse_qs(query_string)

  sql_commands = []
  for rowid in parsed_query['rowid']:
    sql_query = """UPDATE persons SET comment=\'\' WHERE personid=?"""
    sql_params = (rowid, )
    sql_commands.append((sql_query, sql_params))

  db_request(sql_statements=sql_commands, commit_required=True)

  start_response('200 OK', get_response_headers('text/html'))
  return [b'']


url_dispatches = [
  (r'/static/.*', static),
  (r'/$', index),
  (r'/comment$', comment),
  (r'/get_regions$', get_regions),
  (r'/get_cities$', get_cities),
  (r'/view$', view),
  (r'/delete_comments$', delete_comments),
  (r'/stat$', stats)
]


db_exists = False

def create_db():
  if os.path.exists('appform.db'): 
    return

  print 'creating sqlite db...'

  sqlite_script = readfile('static/sqlite/create.sql')
  db_request(sql_scripts=[sqlite_script], commit_required=True)

  print 'appform.db was created succesfully'  


# Main WSGI function.

def app(environ, start_response):
  global db_exists

  if not db_exists:
    create_db()
    db_exists = True

  if environ['REQUEST_METHOD'].upper() == 'POST':
    handle_post(environ)

  for url_dispatch in url_dispatches:
    pattern = url_dispatch[0]
    func = url_dispatch[1]

    if re.match(pattern, environ['PATH_INFO']):
      return func(environ, start_response)

  return not_found(environ, start_response)
