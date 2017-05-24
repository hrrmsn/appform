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
    if not area:
      area = '<i>N/A</i>'
    line_number += 1

    area_table += '<tr>'
    area_table += '<td>{}</td>'.format(line_number)
    area_table += '<td>{}</td>'.format(area if region else '<a href="stat?region={}">{}</a>'.format(area, area))
    area_table += '<td>{}</td>'.format(comments_number)
    area_table += '</tr>'

  area_table += '</tbody></table>'
  return area_table


def fill_html_template(html_code, stats_mode, region='', db_response=False):
  title = 'Cities of {}'.format(region)
  stat_page = 'Go to the <a href="/stat">stat</a> page.'

  if stats_mode == 'all':
    title = 'Comments number by regions'
    stat_page = 'Go to the <a href="static/html/outer-space.html">outer space</a>.'

  table = '<br><p><i>Sorry, there are no comments for the cities of the specified region.</i></p>'
  if db_response:
    table = areas_table(db_response, region=region if stats_mode == 'one' else '')
  elif not db_response and stats_mode == 'all':
    table = """<br><p><i>Sorry, there are no regions with amount of comments more than {}.</i></p>""".format(
      str(MIN_COMMENTS_NUMBER_BY_REGION))

  html_filled = html_code.format(**{'title': title, 'stat-page': stat_page, 'table': table})
  return html_filled


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
  response_body = tools.readfile('static/html/stats.html')
  if not db_response:
    response_body = fill_html_template(response_body, stats_mode='all')
    start_response(tools.OK_200_STATUS, tools.get_response_headers(tools.TEXT_HTML))
    return [response_body.encode(tools.UTF8)]

  response_body = fill_html_template(response_body, stats_mode='all', db_response=db_response)

  start_response(tools.OK_200_STATUS, tools.get_response_headers(tools.TEXT_HTML))
  return [response_body.encode(tools.UTF8)]


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
  db_responses = tools.db_request(
    sql_statements=[(sql_command, params)]
  )
  db_response = db_responses[0]

  response_body = tools.readfile('static/html/stats.html')
  if not db_response:
    response_body = fill_html_template(response_body, stats_mode='one', region=region)
    start_response(tools.OK_200_STATUS, tools.get_response_headers(tools.TEXT_HTML))
    return [response_body.encode(tools.UTF8)]

  response_body = fill_html_template(response_body, stats_mode='one', region=region, db_response=db_response)

  start_response(tools.OK_200_STATUS, tools.get_response_headers(tools.TEXT_HTML))
  return [response_body.encode(tools.UTF8)]


# URL-dispatching functions are here.

def stats(environ, start_response):
  if environ['QUERY_STRING']:
    return stats_one_region(environ, start_response)
  return stats_all_regions(environ, start_response)