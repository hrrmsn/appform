#!/usr/bin/env python

import urllib
import urlparse

from tools import get_response_headers
from tools import db_request
from tools import readfile

MIN_COMMENTS_NUMBER_BY_REGION = 5


# Helper functions are here.

def regions_table(db_response):
  stats_table = '<br><table class="regions">'

  stats_table += '<caption>'
  stats_table += 'Regions with amount of comments more than {}'.format(MIN_COMMENTS_NUMBER_BY_REGION)
  stats_table += '</caption>'

  stats_table += '<thead>'
  stats_table += '<tr>'
  stats_table += '<th class="row-id">#</th>'
  stats_table += '<th class="row-region">Region</th>'
  stats_table += '<th class="row-comments-number">Comments number</th>'
  stats_table += '</tr>'
  stats_table += '</thead>'
  stats_table += '<tbody>'

  line_number = 0
  for region_info in db_response:
    line_number += 1
    region = region_info[0]
    comments_number = region_info[1]
    stats_table += '<tr>'
    stats_table += '<td>' + str(line_number) + '</td>'
    stats_table += '<td><a href="stat?region={}">'.format(region) + region + '</a></td>'
    stats_table += '<td>' + str(comments_number) + '</td>'
    stats_table += '</tr>'
  stats_table += '</tbody></table>'
  return stats_table


def stats_all_regions(environ, start_response):
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


def stats_one_region(environ, start_response):
  query_string = urllib.unquote(environ['QUERY_STRING'])
  parsed_query = urlparse.parse_qs(query_string)

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


# URL-dispatching functions are here.

def stats(environ, start_response):
  if environ['QUERY_STRING']:
    return stats_one_region(environ, start_response)
  return stats_all_regions(environ, start_response)