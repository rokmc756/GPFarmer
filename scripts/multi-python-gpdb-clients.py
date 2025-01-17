#!/usr/bin/python

# import sys
# sys.path.append('/usr/local/lib64/python3.7')
import psycopg2
import multiprocessing as mp
import Queue
# import queue


def connect():
    C = psycopg2.connect(host = "192.168.0.51", user = "gpadmin", password = "changeme", port = 5432, database = "gpadmin")
    cur = C.cursor()
    return C,cur

def commit_and_close(C,cur):
    C.commit()
    cur.close()
    C.close()

def commit(C):
    C.commit()

def sub(queue):
    C,cur = connect()
    while not queue.empty():
        work_element = queue.get(timeout=1)
        #do something with the work element, that might produce an SQL error
    commit_and_close(C,cur)       
    return 0

if __name__ == '__main__':
    job_queue = mp.Queue()
    #Fill Job_queue
    #print "Run"
    for i in range(20):
        p=mp.Process(target=sub, args=(job_queue))
        p.start()  

