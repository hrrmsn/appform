#!/usr/bin/env python

import urllib
import urlparse

import tools

MIN_COMMENTS_NUMBER_BY_REGION = 5


# Helper functions are here.

def areas_table(db_response, region=''):
  area_table = '<br><table class="areas">'

  area_table += '<caption>'
  if region:
    area_table += 'Comments by cities of {}'.format(region)
  else:
    area_table += 'Regions with amount of comments more than {}'.format(MIN_COMMENTS_NUMBER_BY_REGION)
  area_table += '</caption>'

  area_table += '<thead><tr>'
  area_table += '<th class="row-id">#</th>'
  area_table += '<th class="row-area">{}</th>'.format('City' if region else 'Region')
  area_table += '<th class="row-comments-number">Comments number</th>'
  area_table += '</tr></thead>'

  area_table += '<tbody>'
  line_number = 0
  for area_info in db_response:
    area, comments_number = area_info[0], area_info[1]
    line_number += 1

    area_table += '<tr>'
    area_table += '<td>{}</td>'.format(line_number)
    area_table += '<td>{}</td>'.format(area if region else '<a href="stat?region={}">{}</a>'.format(area, area))
    area_table += '<td>{}</td>'.format(comments_number)
    area_table += '</tr>'

  area_table += '</tbody></table>'
  return area_table


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

  db_responses = tools.db_request(
    sql_statements=[
      (sql_command, (MIN_COMMENTS_NUMBER_BY_REGION, ))
    ]
  )

  db_response = db_responses[0]
  response_body = tools.readfile('static/html/stats-all-regions.html')
  if not db_response:
    instead_of_table = """<br><p>Sorry, there are no regions with amount of comments more than {}.</p>""".format(
      str(MIN_COMMENTS_NUMBER_BY_REGION))
    response_body = response_body.format(**{'table': instead_of_table})

    start_response(tools.OK_200_STATUS, tools.get_response_headers(tools.TEXT_HTML))
    return [response_body.encode(UTF8)]

  response_body = response_body.format(**{'table': areas_table(db_response)})

  start_response(tools.OK_200_STATUS, tools.get_response_headers(tools.TEXT_HTML))
  return [response_body.encode(tools.UTF8)]


def stats_one_region(environ, start_response):
  query_string = urllib.unquote(environ['QUERY_STRING'])
  parsed_query = urlparse.parse_qs(query_string)

  region_name = parsed_query['region'].pop()

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
  params = (region_name, )
  db_responses = tools.db_request(
    sql_statements=[(sql_command, params)]
  )
  db_response = db_responses[0]

  response_body = tools.readfile('static/html/stats-one-region.html')
  if not db_response:
    title = 'No comments are found'
    table = '<br><p>Sorry, there are no comments for the cities of the specified region.</p>'
    response_body = response_body.format(**{'title': title, 'table': table})

    start_response(tools.OK_200_STATUS, tools.get_response_headers(tools.TEXT_HTML))
    return [response_body.encode(tools.UTF8)]

  response_body = response_body.format(
    **{'title': 'Cities of ' + region_name, 'table': areas_table(db_response, region=region_name)}
  )

  start_response(tools.OK_200_STATUS, tools.get_response_headers(tools.TEXT_HTML))
  return [response_body.encode(tools.UTF8)]


# URL-dispatching functions are here.

def stats(environ, start_response):
  if environ['QUERY_STRING']:
    return stats_one_region(environ, start_response)
  return stats_all_regions(environ, start_response)