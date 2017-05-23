#!/usr/bin/env python

import re
import os
import urllib
import urlparse

import tools
import view
import post
import stats
import get_areas


# URL-dispatching functions are here.

def index(environ, start_response):
  response_body = tools.readfile('static/html/index.html')
  start_response(tools.OK_200_STATUS, tools.get_response_headers(tools.TEXT_HTML))
  return [response_body.encode(tools.UTF8)]


def comment(environ, start_response):
  response_body = tools.readfile('static/html/userform.html')
  start_response(tools.OK_200_STATUS, tools.get_response_headers(tools.TEXT_HTML))
  return [response_body.encode(tools.UTF8)]


def not_found(environ, start_response):
  response_body = tools.readfile('static/html/not-found.html')
  start_response('404 NOT FOUND', tools.get_response_headers(tools.TEXT_HTML))
  return [response_body.encode(tools.UTF8)]


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

  response_body = tools.readfile(file_path)
  if not content_type in ['image/jpeg', 'image/x-icon']:
    response_body = response_body.encode(tools.UTF8)

  start_response(tools.OK_200_STATUS, tools.get_response_headers(content_type))
  return [response_body]


def delete_comments(environ, start_response):
  query_string = urllib.unquote(environ['QUERY_STRING'])
  parsed_query = urlparse.parse_qs(query_string)

  sql_commands = []
  for rowid in parsed_query['rowid']:
    sql_query = """UPDATE persons SET comment=\'\' WHERE personid=?"""
    sql_params = (rowid, )
    sql_commands.append((sql_query, sql_params))

  tools.db_request(sql_statements=sql_commands, commit_required=True)

  start_response(tools.OK_200_STATUS, tools.get_response_headers(tools.TEXT_HTML))
  return [b'']


url_dispatches = [
  (r'/static/.*', static),
  (r'/$', index),
  (r'/comment$', comment),
  (r'/get_regions$', get_areas.get_regions),
  (r'/get_cities$', get_areas.get_cities),
  (r'/view$', view.view),
  (r'/delete_comments$', delete_comments),
  (r'/stat$', stats.stats)
]


db_exists = False

def create_db():
  if os.path.exists('appform.db'): 
    return

  print 'creating sqlite db...'

  sqlite_script = tools.readfile('static/sqlite/create.sql')
  tools.db_request(sql_scripts=[sqlite_script], commit_required=True)

  print 'appform.db was created succesfully'  


# Main WSGI function.

def app(environ, start_response):
  global db_exists

  if not db_exists:
    create_db()
    db_exists = True

  if environ['REQUEST_METHOD'].upper() == 'POST':
    post.handle_post(environ)

  for url_dispatch in url_dispatches:
    pattern = url_dispatch[0]
    func = url_dispatch[1]

    if re.match(pattern, environ['PATH_INFO']):
      return func(environ, start_response)

  return not_found(environ, start_response)
