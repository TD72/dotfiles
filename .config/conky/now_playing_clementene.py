#!/usr/bin/env python
#-*- coding: utf-8 -*-

import dbus
import optparse
import shutil
import subprocess



if __name__ == '__main__':
    '''Check if clementine is running'''
    cmd = 'ps -A'
    output = subprocess.check_output(cmd.split(" "))
    if 'clementine' not in output.decode('utf-8'):
        raise SystemExit

    '''Get system bus'''
    bus = dbus.SessionBus()
    cleme = bus.get_object('org.mpris.clementine', '/Player')
    clemedict = cleme.GetMetadata()

    '''Set up the command line parser'''
    usage = 'usage: %prog [options]'
    parser = optparse.OptionParser(usage=usage)
    parser.add_option('-a',  '--artist',  action='store_true', help='artist name')
    parser.add_option('-t',  '--title',   action='store_true', help='title of the track')
    parser.add_option('-l',  '--album',   action='store_true', help='album name')
    parser.add_option('-g',  '--genre',   action='store_true', help='genre of the current track')
    parser.add_option('-y',  '--year',    action='store_true', help='year of the track')
    parser.add_option('-m',  '--mtime',    action='store_true', help='time of the track')
    parser.add_option('-r',  '--rtime',    action='store_true', help='remaining time for the track')
    parser.add_option('-e',  '--etime',    action='store_true', help='elapsed time for the track')
    parser.add_option('-p',  '--progress',    action='store_true', help='progress of the track')
    parser.add_option('-n',  '--track',   action='store_true', help='track number')
    parser.add_option('-b',  '--bitrate', action='store_true', help='bitrate of the track')
    parser.add_option('-s',  '--sample',  action='store_true', help='sample rate of the track')
    parser.add_option('-c',  '--cover',   metavar='filename',  help='copy cover art to destination file')
    
    '''Get the parser options printed'''
    (opts, args) = parser.parse_args()
    if opts.artist:
        print(clemedict['artist'])
    if opts.title:
        print(clemedict['title'])
    if opts.album:
        print(clemedict['album'])
    if opts.genre:
        print(clemedict['genre'])
    if opts.year:
        print(clemedict['year'])
    if opts.track:
        print(clemedict['tracknumber'])
    if opts.sample:
        print(clemedict['audio-samplerate'])

    '''Manage time stuff'''
    cpos = mt = mtime = etime = rtime = progress = None
    if (opts.etime or opts.rtime or opts.mtime or opts.progress):
        cpos    = cleme.PositionGet()/1000
        mt      = clemedict['mtime']/1000
        mtime   = str(mt/60)+":"+str(mt%60) if mt%60>9 else str(mt/60)+":0"+str(mt%60)
        etime   = str(cpos/60)+":"+str(cpos%60) if cpos%60>9 else  str(cpos/60)+":0"+str(cpos%60)
        rtime   = str((mt-cpos)/60)+":"+str((mt-cpos)%60) if (mt-cpos)%60>9 else str((mt-cpos)/60)+":0"+str((mt-cpos)%60)
        progress= float(cpos)/float(mt)*100
    if opts.etime and etime is not None:
        print(etime)
    if opts.rtime and rtime is not None:
        print(rtime)
    if opts.mtime and mtime is not None:
        print(mtime)
    if opts.progress and progress is not None:
        print(progress)

    if opts.cover :
        cover = clemedict['arturl']
        if cover != "" :
            try :
                shutil.copyfile(cover.replace('file://', ''), opts.cover)
                print("")
            except Exception:
                print(e)
                print("")
        else :
            print("")
