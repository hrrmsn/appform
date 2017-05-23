#!/usr/bin/env python

import re
import urllib

import tools

TEXT_XML = 'text/xml'


# Helper functions are here.

def build_xml(main_tag, element_tag, list_of_tuples):
  xml = '<' + main_tag + '>'
  for tup in list_of_tuples:
    xml += '<' + element_tag + '>' + tup[0] + '</' + element_tag + '>'
  xml += '</' + main_tag + '>'
  return xml


# URL-dispatching functions are here.

def get_regions(environ, start_response):
  db_responses = tools.db_request(
    sql_statements=[("""SELECT region FROM regions""", )]
  )
  regions = db_responses[0]
  regions_xml = build_xml('regions', 'region', regions)
  start_response(tools.OK_200_STATUS, tools.get_response_headers(TEXT_XML))
  return [regions_xml.encode(tools.UTF8)]


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

  db_responses = tools.db_request(
    sql_statements=[(sql_command, selected_region)]
  )
  cities = db_responses[0]
  cities_xml = build_xml('cities', 'city', cities)
  start_response(tools.OK_200_STATUS, tools.get_response_headers(TEXT_XML))
  return [cities_xml.encode(tools.UTF8)]