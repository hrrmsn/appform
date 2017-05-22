#!/usr/bin/env python

import sqlite3

SQLITE_DB_PATH = 'appform.db'

# Helpful functions are here.

def readfile(filepath):
  file_content = 'Error when reading from file: \'' + filepath + '\'.'
  with open(filepath, 'r') as f:
    file_content = f.read()
  return file_content


def get_response_headers(content_type):
  return [('Content-Type', content_type)]


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


def get_single_value(db_response):
  tup = db_response[0] if len(db_response) > 0 else ('', )
  first_element = tup[0]
  return first_element  