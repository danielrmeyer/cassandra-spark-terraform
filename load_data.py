from cassandra.cluster import Cluster
import cassandra
import sys
import datetime
import time
from itertools import cycle, product

num_keys = 100

cluster = Cluster()
session = cluster.connect()

create_ks_query = '''CREATE KEYSPACE ks WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor': 1};'''
create_cf_query = '''CREATE COLUMNFAMILY ks.cf (
                     key text PRIMARY KEY,
                     color text,
                     size text,
                     qty int,
                     data_blob blob);'''


try:
    session.execute(create_ks_query)
except cassandra.AlreadyExists:
    pass


try:
    session.execute(create_cf_query)
except cassandra.AlreadyExists:
    pass



color_list=['red', 'green', 'blue', 'yellow', 'purple', 'pink', 'grey', 'black', 'white', 'brown']
size_list=['P', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL']
qty_list=xrange(500)
elements = cycle(product(color_list,size_list,qty_list))

row_count = 0
insert_query = '''a'''

while True:
    if row_count >= num_keys:
        break

    row_count += 1

    color, size, qty = elements.next()
    data_blob = str(color)+str(size)+str(qty)
    key = "key_%d" % row_count

    query = '''INSERT INTO ks.cf (
               key,
               color,
               size,
               qty,
               data_blob)
               VALUES (%s, %s, %s, %s, %s)'''

    params = [
        key,
        color,
        size,
        qty,
        buffer(data_blob.encode('hex'))]


    session.execute(query, params)


