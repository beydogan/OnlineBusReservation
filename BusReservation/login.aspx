import threading

def readit():
  threading.Timer(3.0, readit).start()
  f = open('E:\keepalive.txt', 'r')
  f.close();

readit()