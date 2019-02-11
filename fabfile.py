from fabric.api import env, run, sudo, put, get
from fabric.decorators import runs_once 
env.use_ssh_config = 'True'
env.warn_only = 'True'
env.colorize_errors = 'True'
env.skip_bad_hosts = 'True'
env.hosts = open('/home/eldar/script/hosts', 'r').readlines()


env.password = "XXXXXX"

def runsudo ():
	sudo ("ls -la /root")


def getfile (remotepath, localpath):
	get (remotepath,localpath+"."+env.host) 

def putfile(localpath,remotepath):
        put (localpath,remotepath)


def runcommand ():
	run ("ifconfig -a")
