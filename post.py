#!/usr/bin/env python

from tools import db_request
from tools import get_single_value


#  Helper functions are here.

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


# Function to handle post request.

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