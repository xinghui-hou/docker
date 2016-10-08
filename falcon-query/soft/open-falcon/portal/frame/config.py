# -*- coding:utf-8 -*-
__author__ = 'Ulric Qin'

# -- app config --
DEBUG = False

# -- db config --
DB_HOST = "falcon-mysql"
DB_PORT = 3306
DB_USER = "root"
DB_PASS = "upyun.com"
DB_NAME = "falcon_portal"

# -- cookie config --
SECRET_KEY = "4e.3pg8-u9iyunioj"
SESSION_COOKIE_NAME = "falcon-portal"
PERMANENT_SESSION_LIFETIME = 3600 * 24 * 30

UIC_ADDRESS = {
    'internal': 'http://127.0.0.1:1234',
    'external': 'http://127.0.0.1:1234',
}

UIC_TOKEN = ''

MAINTAINERS = ['root']
CONTACT = 'ulric.qin@gmail.com'

COMMUNITY = True

try:
    from frame.local_config import *
except Exception, e:
    print "[warning] %s" % e
